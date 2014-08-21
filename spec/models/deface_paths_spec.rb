require "spec_helper"

describe "DefacePaths" do
  it "should app overrides paths" do
    overrides_paths = Rails.application.paths["app/overrides"]
    this_plugin_paths = Rails.root.join("plugins/redmine_base_deface/app/overrides")
    assert overrides_paths.include?(this_plugin_paths.to_s),
           "The init.rb of this very plugin should add every plugins' app/overrides to rails paths for app/overrides"
  end
end
