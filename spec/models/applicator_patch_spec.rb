require 'spec_helper'

# Dummy Deface instance for testing actions / applicator
class Dummy
  extend Deface::Applicator::ClassMethods
  extend Deface::Search::ClassMethods

  attr_reader :parsed_document

  def self.all
    Rails.application.config.deface.overrides.all
  end
end

module Deface
  describe Applicator do

    # include_context "mock Rails.application"

    before { Dummy.all.clear }

    describe "source containing a javascript tag" do
      before { Deface::Override.new(:virtual_path => "posts/index",
                                    :name => "Posts#index",
                                    :remove => "p") }
      let(:source) { "<%= javascript_tag do %>if (y > 0) {y = 0;}<% end %>" }
      it "should return unmodified source" do
        expect(Dummy.apply(source, { :virtual_path => "posts/index" })).to eq("<%= javascript_tag do %>if (y > 0) {y = 0;}<% end %>")
      end
    end
  end
end
