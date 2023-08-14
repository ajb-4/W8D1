class FixauthorId < ActiveRecord::Migration[7.0]
  def change
    remove_column :poems, :author_id, foreign_key: {to_table: :users}
  end
end
