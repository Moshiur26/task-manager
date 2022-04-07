class Board < ApplicationRecord
  has_many :tasks
  belongs_to :created_by, class_name: 'Admin'
  belongs_to :updated_by, class_name: 'Admin', optional: true
end
