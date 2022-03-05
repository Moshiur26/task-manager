class JsonWebToken
    def self.encode(payload)
      expiration = 1.year.from_now.to_i
      JWT.encode payload.merge(exp: expiration), Rails.application.secret_key_base
    end
  
    def self.decode(token)
      JWT.decode(token, Rails.application.secret_key_base).first
    end
  
    def self.remove_token(bearer_token = '')
      auth_key = AuthorizationKey.find_by(token: bearer_token) if bearer_token.present?
      auth_key.destroy! if auth_key.present?
      auth_key.present? ? auth_key.destroyed? : false
    end
  
    def self.user_token_encode(user, bearer_token = '')
      expiry = 3.month.from_now
      rand = SecureRandom.hex(10)
      hash = BCrypt::Password.create(rand)
      token = JWT.encode hash, Rails.application.secret_key_base
  
      auth_key = AuthorizationKey.find_by(token: bearer_token) if bearer_token.present?
  
      if auth_key.present? && auth_key&.authable_id == user&.id
        if auth_key.update!(expiry: expiry, token: token)
          token
        end
      elsif AuthorizationKey.create!(token: token, expiry: expiry, authable: user)
        token
      end
    end
  
    def self.new_auth_key(user)
      token_hash = token_hash(user)
      token_hash[:authable] = user
      AuthorizationKey.create!(token_hash)
    end
  
    def self.token_hash(user)
      expiry = 3.month.from_now
      rand = SecureRandom.hex(10)
      hash = BCrypt::Password.create(rand)
      token = JWT.encode hash, Rails.application.secret_key_base
      { expiry: expiry, token: token }
    end
  end
  