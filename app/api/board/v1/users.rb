# frozen_string_literal: true

module Board
  module V1
    class Users < Board::Base
      resource '/' do
        params do
          requires :username, type: String
          requires :password, type: String
        end

        desc 'User Login'
        route_setting :authentication, optional: true

        post 'login' do
          user = User.find_by(email: params[:username])
          if user&.valid_password?(params[:password])
            success_response_with_json(
              "Successfully logged in.",
              HTTP_CODE[:OK],
              {
                token: JsonWebToken.user_token_encode(user),
                name: user.name,
                phone: user.phone,
                username: user.email,
              }
            )
          else
            error! failure_response_with_json("Invalid username or password", HTTP_CODE[:FORBIDDEN]), HTTP_CODE[:OK]
          end
        rescue StandardError => error
          Rails.logger.error "\n#{__FILE__}\nUser login failed due to: #{error.message}"
          error! failure_response_with_json("User login failed due to: #{error.message}", HTTP_CODE[:FORBIDDEN]), HTTP_CODE[:OK]
        end
      end
    end
  end
end