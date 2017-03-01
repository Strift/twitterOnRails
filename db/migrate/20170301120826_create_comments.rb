class CreateComments < ActiveRecord::Migration[5.0]

  def up
    create_table :comments do |t|
      t.string :commenter
      t.text :content
      t.references :tweet, foreign_key: true

      t.timestamps
    end
  end

  def down
  	delete_table :comments
  end
  
end
