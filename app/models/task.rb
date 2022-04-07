class Task < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :board
  belongs_to :parent, class_name: 'Task', optional: true
  has_many :childes, class_name: 'Task', foreign_key: :parent_id, dependent: :restrict_with_exception
  belongs_to :created_by, class_name: 'Admin'
  belongs_to :updated_by, class_name: 'Admin', optional: true

  enum status: {inactive: 0, active: 1, on_going: 2, pause: 3, completed: 4, deleted: 5}
end
