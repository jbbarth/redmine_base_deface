module RedmineBaseDeface
  module OverridesLoader
    def self.ignore_ruby_overrides(plugins_dir = Rails.root.join("plugins"))
      Dir.glob("#{plugins_dir}/*/app/overrides/**/*.rb").each do |path|
        Rails.autoloaders.main.ignore(path)
      end
    end

    # Overrides must not be loaded when Deface is disabled (e.g. production with
    # precompiled views): the DSL methods of Deface::DSL::Context are only defined
    # by Deface::Environment, which Deface does not set up in that case.
    def self.load_all(plugins_dir = Rails.root.join("plugins"))
      return unless Rails.application.config.deface.enabled

      Dir.glob("#{plugins_dir}/*/app/overrides/**/*.rb").each do |path|
        load path
      end
      Dir.glob("#{plugins_dir}/*/app/overrides/**/*.deface").each do |path|
        Deface::DSL::Loader.load path
      end
    end
  end
end
