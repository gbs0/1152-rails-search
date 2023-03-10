class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.text :synopsis
      t.references :director, null: false, foreign_key: true
      t.string :genre

      t.timestamps
    end
  end
end
