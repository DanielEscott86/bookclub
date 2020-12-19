class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title
      t.string :author
      t.text :description
      t.decimal :price
      t.string :image_url
      t.string :department

      t.timestamps
    end
  end
end
