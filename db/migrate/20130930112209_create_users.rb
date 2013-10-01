class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :name
      t.integer :age, default: 0
      t.timestamps
    end
  end
end
