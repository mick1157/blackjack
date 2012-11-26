class CreateBlackjackGames < ActiveRecord::Migration
  def change
    create_table :blackjack_games do |t|
      t.text :state

      t.timestamps
    end
  end
end
