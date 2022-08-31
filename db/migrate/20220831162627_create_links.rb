class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :shortcode, null: false

      t.timestamps
    end
  end
end
