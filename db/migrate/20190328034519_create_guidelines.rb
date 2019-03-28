class CreateGuidelines < ActiveRecord::Migration[5.2]
  def change
    create_table :guidelines do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :description
      t.string :detail
      t.boolean :inactive, default: false

      t.timestamps
    end
  end
end
