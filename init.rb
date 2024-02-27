Redmine::Plugin.register :redmine_base_deface do
  name 'Redmine Base Deface plugin'
  author 'Jean-Baptiste BARTH'
  description 'This is a plugin for Redmine'
  version '5.1.1'
  url 'https://github.com/jbbarth/redmine_base_deface'
  author_url 'jeanbaptiste.barth@gmail.com'
  #doesn't work since redmine evaluates dependencies as it loads, and loads in lexical order
  #TODO: see if it works in Redmine 2.6.x or 3.x when they're released
  # requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.3' if Rails.env.test?
end

# Little hack for deface in redmine:
# - redmine plugins are not railties nor engines, so deface overrides are not detected automatically
# - deface doesn't support direct loading anymore ; it unloads everything at boot so that reload in dev works
# - hack consists in adding "app/overrides" path of all plugins in Redmine's main #paths
if Rails.version > '6.0'
  Dir.glob("#{Rails.root}/plugins/*/app/overrides/**/*.rb").each do |path|
    Rails.autoloaders.main.ignore(path)
    load File.expand_path(path, __FILE__)
  end

  Dir.glob("#{Rails.root}/plugins/*/app/overrides/**/*.deface").each do |path|
    Deface::DSL::Loader::load File.expand_path(path, __FILE__)
  end

  Rails.application.config.after_initialize do
    require_relative "lib/applicator_patch"
  end
else
  Rails.application.paths["app/overrides"] ||= []
  Dir.glob("#{Rails.root}/plugins/*/app/overrides").each do |dir|
    Rails.application.paths["app/overrides"] << dir unless Rails.application.paths["app/overrides"].include?(dir)
  end

  ActiveSupport::Reloader.to_prepare do
    require_dependency "applicator_patch"
  end
end
