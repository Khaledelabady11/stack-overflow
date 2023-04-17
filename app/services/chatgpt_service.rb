class ChatgptService
  include HTTParty

  attr_reader :api_url, :options, :model, :message

  def initialize(body, model = 'gpt-3.5-turbo')
    api_key = Rails.application.credentials.chatgpt_api_key
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer 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"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @message = body
  end

  def call
    body = {
      model: @model,
      messages: [{ role: 'user', content: message }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 10)
    # byebug
    raise response['error']['body'] unless response.code == 200

    response['choices'][0]['message']['content']
  end


  class << self
    def call(message, model = 'gpt-3.5-turbo')
      new(message, model).call
    end
  end
end
