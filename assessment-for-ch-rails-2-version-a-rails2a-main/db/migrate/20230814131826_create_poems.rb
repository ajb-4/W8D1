class CreatePoems < ActiveRecord::Migration[7.0]
  def change
    create_table :poems do |t|
      t.string :title, null: false
      t.text :stanzas, null: false
      t.boolean :complete
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
