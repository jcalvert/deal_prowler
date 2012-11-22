class CreateWootOffs < ActiveRecord::Migration
  def up
    create_table :woot_offs do |t|
      t.string :subtitle
      t.string :write_up
      t.string :podcast_title
      t.string :podcast_teaser
      t.string :podcast_mp3_url
      t.string :podcast_ogg_url
      t.string :type
      t.string :woot_id
      t.string :title
      t.string :site
      t.string :start_date
      t.string :end_date
      t.text :offers

      t.timestamps
    end
  end

  def down
    drop_table :woot_offs
  end
end
