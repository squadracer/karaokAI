class GenerateImagesJob
  include CraiyonHelper
  include Sidekiq::Job

  queue_as :default

  BATCH_SIZE = 20 # we've estimated that one image generation takes a bit more than 1 minute
  @@LAST_START_REQUEST = 1.day.ago

  def self.set_last_request(time)
    @@LAST_START_REQUEST = time
  end

  def perform
    Image.first.destroy if Image.count > BATCH_SIZE
    random_ajd = Rails.application.config.adjectives.sample
    random_noun = Rails.application.config.nouns.sample
    prompt = [random_ajd, random_noun].join(" ")
    url = generate(prompt)
    Image.create!(prompt:, url:)
    GenerateImagesJob.perform_async unless @@LAST_START_REQUEST > GenerateImagesJob::BATCH_SIZE.minutes.ago
  end
end
