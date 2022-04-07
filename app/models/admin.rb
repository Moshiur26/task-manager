class Admin < ApplicationRecord
    devise :registerable,
         :database_authenticatable,
         :validatable,
         :jwt_authenticatable
         # jwt_revocation_strategy: JwtBlacklist

    has_many :created_tasks, class_name: 'Task', foreign_key: :created_by_id, dependent: :restrict_with_exception
    has_many :updated_tasks, class_name: 'Task', foreign_key: :updated_by_id, dependent: :restrict_with_exception
    has_many :created_boards, class_name: 'Board', foreign_key: :created_by_id, dependent: :restrict_with_exception
    has_many :updated_boards, class_name: 'Board', foreign_key: :updated_by_id, dependent: :restrict_with_exception

    validates :name, :phone, :email, :password, :password_confirmation, presence: true
    validates :email, :phone, uniqueness: true

    enum role: { admin: 0, super_admin: 1 } 
end
