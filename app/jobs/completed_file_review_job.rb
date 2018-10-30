class CompletedFileReviewJob < ApplicationJob
  @queue = :high

  # The following parameters are required for this job to run.
  # filename
  # commit_sha
  # pull_request_number
  # patch
  # violations
  #   [{ line: 123, message: "WAT" }]
  def self.perform(attributes)
    CompleteFileReview.call(attributes)
  rescue Resque::TermException
    Resque.enqueue(self, attributes)
  rescue ActiveRecord::RecordNotFound
    Resque.enqueue_in(30, self, attributes)
  rescue
    if attributes["attempts"].to_i >= 3
      raise
    else
      attributes["attempts"] = attributes["attempts"].to_i + 1
      Resque.enqueue_in(30, self, attributes)
    end
  end
end
