require 'spec_helper'
require 'itamae/plugin/recipe/droonga'

describe Itamae::Plugin::Recipe::Droonga do
  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).to_not be_empty
  end
end
