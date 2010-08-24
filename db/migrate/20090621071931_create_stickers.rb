class CreateStickers < ActiveRecord::Migration
  def self.up
    create_table :stickers do |t|
      t.column :sticker, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :stickers
  end
end
