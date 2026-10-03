require "spec_helper"
require "tmpdir"

describe RedmineBaseDeface::OverridesLoader do
  let(:plugins_dir) { Dir.mktmpdir }
  let(:overrides_dir) { File.join(plugins_dir, "probe_plugin/app/overrides/issues") }
  let(:ruby_override) { File.join(overrides_dir, "probe.rb") }
  let(:dsl_override) { File.join(overrides_dir, "probe.html.erb.deface") }
  let!(:all_overrides) { Deface::Override.all }

  before do
    FileUtils.mkdir_p(overrides_dir)
    File.write(ruby_override, <<~RUBY)
      Deface::Override.new(virtual_path: "issues/probe_rb", name: "probe-rb", remove: "p")
    RUBY
    File.write(dsl_override, <<~ERB)
      <!-- replace 'div.subject' -->
      <div class="subject">probe</div>
    ERB
  end

  after do
    FileUtils.remove_entry(plugins_dir)
    all_overrides.delete(:"issues/probe_rb")
  end

  it "loads ruby and DSL overrides when Deface is enabled" do
    expect(Deface::DSL::Loader).to receive(:load).with(dsl_override)

    RedmineBaseDeface::OverridesLoader.load_all(plugins_dir)

    expect(all_overrides[:"issues/probe_rb"]).to have_key("probe-rb")
  end

  it "loads nothing when Deface is disabled" do
    disabled_config = ActiveSupport::OrderedOptions.new
    disabled_config.enabled = false
    allow(Rails.application.config).to receive(:deface).and_return(disabled_config)
    expect(Deface::DSL::Loader).not_to receive(:load)

    RedmineBaseDeface::OverridesLoader.load_all(plugins_dir)

    expect(all_overrides[:"issues/probe_rb"]).to be_nil
  end
end
