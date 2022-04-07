class Board < ApplicationRecord
  has_many :tasks
  belongs_to :created_by, class_name: 'Admin'
  belongs_to :updated_by, class_name: 'Admin', optional: true
  has_many :board_users
  has_many :users, through: :board_users

  enum status: {inactive: 0, active: 1, on_going: 2, pause: 3, completed: 4, deleted: 5}
end
