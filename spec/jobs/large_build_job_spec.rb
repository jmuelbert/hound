require "rails_helper"

describe LargeBuildJob do
  it 'is buildable' do
    expect(LargeBuildJob.new).to be_a(Buildable)
  end
end
