module Buildable
  def perform(payload_data)
    payload = Payload.new(payload_data)

    unless blacklisted?(payload)
      UpdateRepoStatus.call(payload)
      StartBuild.call(payload)
    end
  end

  private

  def blacklisted?(payload)
    BlacklistedPullRequest.where(
      full_repo_name: payload.full_repo_name,
      pull_request_number: payload.pull_request_number,
    ).any?
  end
end
