class UserTokenController < Knock::AuthTokenController
  skip_before_action :verify_authenticity_token

  def create
    render json: {
      user: entity,
      token: auth_token.token,
    }, status: :created
  end
end
