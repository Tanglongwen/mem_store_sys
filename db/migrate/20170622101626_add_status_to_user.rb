class AddStatusToUser < ActiveRecord::Migration[5.1]
  def change
   add_column :users, :status, :string, :default => '00A'
  end
end
