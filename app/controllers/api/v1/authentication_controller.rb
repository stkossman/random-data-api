module Api
  module V1
    class AuthenticationController < ApplicationController
      # Метод для входу користувача
      def login
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
          # Створення JWT токена
          # Payload може містити будь-які дані, які ви хочете закодувати в токен.
          # Ми використовуємо user_id та термін дії токена.
          # SECRET_KEY_BASE береться з config/credentials.yml.enc (Rails 5.2+) або config/secrets.yml.
          # У розробці можна використовувати Rails.application.secret_key_base
          # або згенерувати свою унікальну змінну середовища.
          # ENV['JWT_SECRET_KEY']

          # Краще використовувати змінну середовища для SECRET_KEY
          # Наприклад, додайте JWT_SECRET_KEY=your_super_secret_key до .env файлу (якщо ви використовуєте gem 'dotenv-rails')
          # Або в config/credentials.yml.enc для продакшн
          secret_key = ENV['JWT_SECRET_KEY'] || Rails.application.secret_key_base

          token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, secret_key, 'HS256')
          render json: { token: token, message: 'Login successful' }, status: :ok
        else
          render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
      end
    end
  end
end