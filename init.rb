Redmine::Plugin.register :redmine_base_deface do
  name 'Redmine Base Deface plugin'
  author 'Jean-Baptiste BARTH'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/jbbarth/redmine_base_deface'
  author_url 'jeanbaptiste.barth@gmail.com'
end

# Little hack for deface in redmine:
# - redmine plugins are not railties nor engines, so deface overrides are not detected automatically
# - deface doesn't support direct loading anymore ; it unloads everything at boot so that reload in dev works
# - hack consists in adding "app/overrides" path of all plugins in Redmine's main #paths
paths = Rails.application.paths["app/overrides"]
paths ||= []
Dir.glob("#{Rails.root}/plugins/*/app/overrides").each do |dir|
  paths << dir unless paths.include?(dir)
end
