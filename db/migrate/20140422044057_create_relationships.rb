class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :datee_id
      t.string :status

      t.timestamps
    end
  end
end
