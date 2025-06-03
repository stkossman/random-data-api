class ApplicationController < ActionController::API
  def authenticate_request!
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      secret_key = ENV['JWT_SECRET_KEY'] || Rails.application.secret_key_base
      decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
      @current_user = User.find(decoded_token[0]['user_id'])
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
