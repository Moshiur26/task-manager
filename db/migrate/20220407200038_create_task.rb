class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.bigint :user_id
      t.bigint :created_by_id
      t.bigint :updated_by_id
      t.string :title
      t.string :description
      t.integer :status, default: 0
      t.float :hours
      t.datetime :planned_start_date
      t.datetime :planned_end_date
      t.datetime :actual_start_date
      t.datetime :actual_end_date
      t.text :content
      t.bigint :board_id
      t.bigint :parent_id

      t.timestamps
    end
  end
end
