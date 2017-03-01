class CreateComments < ActiveRecord::Migration[5.0]

  def up
    create_table :comments do |t|
      t.string :commenter
      t.text :content
      t.string :html_content
      t.references :tweet, foreign_key: true

      t.timestamps
    end
  end

  def down
  	drop_table :comments
  end
  
end
