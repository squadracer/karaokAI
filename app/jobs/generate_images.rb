class GenerateImages
  include CraiyonHelper
  include Sidekiq::Job

  queue_as :default

  def perform
    Image.first.destroy if Image.count > 20
    random_ajd = Rails.application.config.adjectives.sample
    random_noun = Rails.application.config.nouns.sample
    prompt = [random_ajd, random_noun].join(" ")
    url = generate(prompt)
    Image.create!(prompt:, url:)
    GenerateImages.perform_async
  end
end
