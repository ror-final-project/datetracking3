class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.integer :datee_id
      t.integer :friendly_id
      t.integer :num_exp
      t.datetime :date
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
