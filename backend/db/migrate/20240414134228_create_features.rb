class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :feature_id, null: false
      t.decimal :magnitude, precision: 5, scale: 2
      t.string :place, null: false
      t.datetime :time, null: false
      t.string :url, null: false
      t.boolean :tsunami
      t.string :mag_type, null: false
      t.string :title, null: false
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :latitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
