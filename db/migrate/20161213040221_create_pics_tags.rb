class CreatePicsTags < ActiveRecord::Migration[5.0]
  def self.up
    create_table :pics_tags, :id => false do |t|
        t.integer :pic_id
        t.integer :tag_id
    end
  end
  def self.down
      drop_table :pics_tags
  end
end
