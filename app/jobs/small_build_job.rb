class SmallBuildJob
  include Sidekiq::Worker
  sidekiq_options queue: "medium"

  include Buildable
end
