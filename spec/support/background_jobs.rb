require "sidekiq/testing"

RSpec.configure do |config|
  config.around(:each, type: :feature) do |example|
    run_background_jobs_immediately do
      example.call
    end
  end

  config.around(:each, type: :request) do |example|
    run_background_jobs_immediately do
      example.call
    end
  end

  config.around(:each, type: :job) do |example|
    run_background_jobs_immediately do
      example.call
    end
  end

  def run_background_jobs_immediately
    inline = Resque.inline
    Resque.inline = true

    Sidekiq::Testing.inline! do
      yield
    end

    Resque.inline = inline
  end
end
