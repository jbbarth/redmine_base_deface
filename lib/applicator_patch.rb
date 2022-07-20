require_dependency 'deface/applicator'

module ApplicatorPatch

  # applies all applicable overrides to given source
  #
  def apply(source, details, log = true, syntax = :erb)
    overrides = find(details)

    if log && overrides.size > 0
      Rails.logger.debug "\e[1;32mDeface:\e[0m #{overrides.size} overrides found for '#{details[:virtual_path]}'"
    end

    unless overrides.empty?
      case syntax
      when :haml
        #convert haml to erb before parsing before
        source = Deface::HamlConverter.new(source.to_param).result
      when :slim
        source = Deface::SlimConverter.new(source.to_param).result
      end

      doc = Deface::Parser.convert(source)

      overrides.each do |override|
        if override.disabled?
          Rails.logger.debug("\e[1;32mDeface:\e[0m '#{override.name}' is disabled") if log
          next
        end

        override.parsed_document = doc
        matches = override.matcher.matches(doc, log)

        if log
          Rails.logger.send(matches.size == 0 ? :error : :debug, "\e[1;32mDeface:\e[0m '#{override.name}' matched #{matches.size} times with '#{override.selector}'")

          # temporarily check and notify on use of old selector styles.
          #
          if matches.empty? && override.selector.match(/code|erb-loud|erb-silent/)
            Rails.logger.error "\e[1;32mDeface: [WARNING]\e[0m Override '#{override.name}' may be using an invalid selector of '#{override.selector}', <code erb-loud|silent> tags are now <erb loud|silent>"
          end
        end

        if matches.empty?
          override.failure = "failed to match :#{override.action} selector '#{override.selector}'"
        else
          override.failure = nil
          matches.each { |match| override.execute_action match }
        end
      end

      # Prevents any caching by rails in development mode.
      details[:updated_at] = Time.now if Deface.before_rails_6?

      ###############################
      ### START PATCH
      source = CGI.unescapeHTML doc.to_s
      ### END PATCH
      ###############################

      Deface::Parser.undo_erb_markup!(source)
    end

    source
  end

end

Deface::Applicator::ClassMethods.prepend ApplicatorPatch
