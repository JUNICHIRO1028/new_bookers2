class RemoveIntroductionFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :intorduction, :string
  end
end
