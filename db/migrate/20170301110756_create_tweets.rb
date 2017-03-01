class CreateTweets < ActiveRecord::Migration[5.0]

  def up
    create_table :tweets do |t|
      t.string :author
      t.text :content
      t.text :html_content

      t.timestamps
    end
  end

  def down
  	drop_table :tweets
  end
  
end
