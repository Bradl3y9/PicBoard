class CreatePicTags < ActiveRecord::Migration[5.0]
  def change
    create_table :pic_tags do |t|
      	t.integer :pic_id
        t.integer :tag_id
      	t.timestamps
    end
  end
end
