class ApplicationController < ActionController::Base
  # before_action :authorize_request , only: [:login]

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    begin
      decoded_token = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
      @current_user_id = decoded_token.first['user_id']
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find_by(id: @current_user_id)
  end
end
