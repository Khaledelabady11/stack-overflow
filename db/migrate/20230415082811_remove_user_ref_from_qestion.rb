class RemoveUserRefFromQestion < ActiveRecord::Migration[7.0]
  def change
    remove_reference(:questions, :user, foreign_key: true)

  end
end
