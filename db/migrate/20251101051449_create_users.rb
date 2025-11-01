class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.integer :role_id

      t.timestamps
    end
  end
end
