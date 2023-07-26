require 'sidekiq/api'

class SlidesController < ApplicationController
  def index
    image = Image.where.not(id: session[:image_ids] || []).sample

    if image
      session[:image_ids] ||= []
      session[:image_ids] << image.id
      @image_url = image.url
    end
  end

  def start
    if Sidekiq::Workers.new.find {|j| j.to_s =~ /GenerateImagesJob/ }.nil?
      GenerateImagesJob.perform_async
      GenerateImagesJob.set_last_request(DateTime.current)
    end
    redirect_to :root
  end
end
