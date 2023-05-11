# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    before_validation :ensure_session_token
    validates :username, :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: {message: "Password can't be blank"} 
    validates :password, length: {minimum: 6}, allow_nil: true 

    attr_reader :password 

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if !user
        return user if user.is_password?(password)
    end 

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end 

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end 

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end 

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end 

    has_many :subs,
        foreign_key: :moderator_id,
        class_name: :Sub,
        dependent: :destroy,
        inverse_of: :moderator

    has_many :posts,
        foreign_key: :author_id,
        class_name: :Post,
        dependent: :destroy,
        inverse_of: :author
end
