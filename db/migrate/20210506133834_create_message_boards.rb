class CreateMessageBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :message_boards do |t|
      t.string    :nick_name
      t.text      :content
      t.integer   :like, default: 0
      t.integer   :unlike, default: 0

      t.timestamps
    end
  end
end
