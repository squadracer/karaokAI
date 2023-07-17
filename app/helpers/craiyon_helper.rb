module CraiyonHelper
  URL = "https://api.craiyon.com/v3"

  def generate(prompt)
    HTTParty.post(URL, body: {prompt: prompt}.to_json, headers: {"Content-type" => "application/json"})
  end
end