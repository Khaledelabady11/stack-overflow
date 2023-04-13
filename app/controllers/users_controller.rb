class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create,:login]

  def index
    @users = User.all
    render json: @users
  end


  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'User Created Successfuly' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      user.token = token
      user.save
      render json: { token: token }

    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
