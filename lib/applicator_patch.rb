require_dependency 'deface/applicator'

module ApplicatorPatch;end

module Deface
  module Applicator
    module ClassMethods

      # applies specified overrides to given source
      def apply_overrides(source, overrides:, log: true)

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
            matches.each {|match| override.execute_action match }
          end
        end

        ###############################
        ### START PATCH
        source = CGI.unescapeHTML doc.to_s
        ### END PATCH
        ###############################

        Deface::Parser.undo_erb_markup!(source)

        source
      end

    end
  end
end
