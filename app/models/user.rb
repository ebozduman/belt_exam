class User < ApplicationRecord
    has_secure_password

    EMAIL_REGEX = /\A[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.(com|net|org)\z/
    PASSWD_REGEX = /\A[a-zA-Z0-9@#$%^&+=]+\z/
    validates :name, :alias, presence: true, length: {minimum: 2}
    validates :email, presence: true, uniqueness: {case_sensitive:false}, format: {with: EMAIL_REGEX}
    validates :password, length: {minimum: 8}, format: {with: PASSWD_REGEX}

    has_many :ideas
    has_many :likes
    has_many :idea_likes, through: :likes, source: :idea
end
