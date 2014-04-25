class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :datee_id
      t.integer :result_id
      t.integer :survey_id

      t.timestamps
    end
  end
end
