class RepoSynchronizationJob
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(user)
    synchronization = RepoSynchronization.new(user)
    synchronization.start
    user.update(refreshing_repos: false)
  end
end
