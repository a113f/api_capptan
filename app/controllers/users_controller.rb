class UsersController < ApplicationController
  before_action :authenticate_user, only: [:my_cars]

  def index
    render json: { message: "Welcome to schedules api." }
  end

  def create
    user = User.new(user_params)

    if user.save
      auth_token = Knock::AuthToken.new payload: { sub: user.id }
      render json: {
        user: user,
        token: auth_token.token
      }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def my_cars
    render json: current_user.cars.to_json, status: 200
  end

  private
  def user_params
    params.require( :user ).permit(
      :name, :email, :password, :password_confirmation
    )
  end
end
