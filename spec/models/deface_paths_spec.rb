require "spec_helper"

describe "DefacePaths" do
  if Rails.version < '6.0'
    it "overrides app paths" do
      overrides_paths = Rails.application.paths["app/overrides"]
      this_plugin_paths = Rails.root.join("plugins/redmine_base_deface/app/overrides")
      expect(overrides_paths).to include(this_plugin_paths.to_s),
             "The init.rb of this very plugin should add every plugins' app/overrides to rails paths for app/overrides"
    end
  end
end
