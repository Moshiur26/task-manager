class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
  has_many :authorization_keys
  has_many :tasks
  has_many :board_users
  has_many :boards, through: :board_users

  validates :name, :phone, :email, :password, :password_confirmation, presence: true
  validates :email, :phone, uniqueness: true
end
