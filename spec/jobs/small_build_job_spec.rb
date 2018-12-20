require "rails_helper"

describe SmallBuildJob do
  it 'is buildable' do
    expect(SmallBuildJob.new).to be_a(Buildable)
  end
end
