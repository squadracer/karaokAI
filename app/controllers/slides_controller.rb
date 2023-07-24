class SlidesController < ApplicationController
  def index
    @image_url = Image.last&.url
    @prompt = Image.last&.prompt
  end

  def start
    GenerateImages.perform_async
    redirect_to :root
  end
end
