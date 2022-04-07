class Task < ApplicationRecord
  belongs_to :user, optional: true
  # belongs_to :board
  belongs_to :parent, class_name: 'Task', optional: true
  has_many :childes, class_name: 'Task', foreign_key: :parent_id, optional: true
  belongs_to :created_by, class_name: 'Admin'
  belongs_to :updated_by, class_name: 'Admin', optional: true
end
