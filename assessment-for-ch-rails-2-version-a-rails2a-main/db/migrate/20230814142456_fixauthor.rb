class Fixauthor < ActiveRecord::Migration[7.0]
  def change
    add_column :poems, :author_id, :bigint, foreign_key: {to_table: :users}
  end
end
