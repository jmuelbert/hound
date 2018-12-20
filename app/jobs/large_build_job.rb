class LargeBuildJob
  include Sidekiq::Worker
  sidekiq_options queue: "low"

  include Buildable
end
