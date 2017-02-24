class Idea < ApplicationRecord
  belongs_to :user
  has_many :likes, :dependent => :delete_all
  has_many :users, through: :likes
end
