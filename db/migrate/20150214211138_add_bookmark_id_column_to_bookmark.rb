class AddBookmarkIdColumnToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :bookmark_id, :integer
  end
end
