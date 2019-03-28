class ApplicationController < ActionController::API
  include Knock::Authenticable

  private
  def authenticate_admin
    if current_user.admin? or current_user.super?
      return current_user
    else
      render json: { message: "You don't have access to this function" }, status: 401
    end
  end
end
