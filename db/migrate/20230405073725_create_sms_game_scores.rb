class CreateSmsGameScores < ActiveRecord::Migration[7.0]
  def change
    create_table :sms_game_scores do |t|
      t.string :name
      t.integer :score
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
