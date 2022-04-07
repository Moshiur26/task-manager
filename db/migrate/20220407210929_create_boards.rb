class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :title, null: false
      t.text :description
      t.bigint :created_by_id
      t.bigint :updated_by_id

      t.timestamps
    end
  end
end
