class CreateBoardUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :board_users do |t|
      t.bigint :board_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
