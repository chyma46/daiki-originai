class AddSportToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :sport, :string
  end
end
