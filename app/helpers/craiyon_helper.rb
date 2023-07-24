module CraiyonHelper
  API_URL = "https://api.craiyon.com/v3"
  IMG_URL = "https://img.craiyon.com/"

  def generate(prompt)
    response = HTTParty.post(API_URL, body: {
      prompt: prompt,
      negative_prompt: "",
      model: "photo",
      token: nil,
      version: "35s5hfwn9n78gb06"
    }.to_json, headers: {"Content-type" => "application/json"}, timeout: 300)
    IMG_URL + response["images"][0]
  end
end