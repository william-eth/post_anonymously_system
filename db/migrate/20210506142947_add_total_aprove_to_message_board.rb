class AddTotalAproveToMessageBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :message_boards, :total_approved, :integer, default: 0
  end
end
