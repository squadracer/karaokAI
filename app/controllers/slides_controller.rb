class SlidesController < ApplicationController
  def index
    @random_ajd = Rails.application.config.adjectives.sample
    @random_noun = Rails.application.config.nouns.sample
  end
end
