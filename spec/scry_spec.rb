require 'spec_helper'

describe 'Scry' do
  it 'Creates a Hipchat notifier when requested to' do
    scry = Scry::Base.new({})

    scry.hipchat.should_not be_nil
    scry.hipchat.should be_a(Scry::Hipchat::Notifier)
  end
end