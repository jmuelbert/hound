class RepoSyncsController < ApplicationController
  def create
    unless current_user.refreshing_repos?
      current_user.update(refreshing_repos: true)

      RepoSynchronizationJob.perform_async(current_user)
    end

    head 201
  end
end
