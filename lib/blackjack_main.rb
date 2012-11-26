#
# ### this is the beginning of the program
#
@bj=Blackjack.new
@bj.card_shuffle

@bj.init_player_hands
@bj.init_dealer_hand
#
#### code for prompting for number of players
#
loop do #prompt for number of players

  @num_players = 0

  $stdout.write("Choose how many people want to play 1, 2, 3, 4 or Exit: ")
  answer = $stdin.gets.chomp.capitalize
  puts ("You said :#{answer}")

  if answer == "Exit" then exit end
  @num_players = answer.to_f
  case @num_players
    when 1...5
      $stdout.write("Your answer has been accepted\n")
      break
  end #end of case

  $stdout.write("Your answer should be between 1 and 4\n")

end #end prompt for number of players
#
#### code for dealing 2 cards to all the players and the dealer
#
num_cards_dealt_to_player = 0
loop do #loop through deal 2 cards
  if num_cards_dealt_to_player == 2 then break end

  # $stdout.write("dealing card number #{num_cards_dealt_to_player + 1} \n")

  current_player = 0

  loop do #loop through number of players
    if current_player == @num_players then break end
    # $stdout.write("To player #{current_player + 1} \n")

    card = @bj.deal_player_card(current_player)
    current_player = current_player + 1
  end #end of loop through current number of player

  # $stdout.write("Dealers Card -- ")
  @bj.deal_dealer_card
  num_cards_dealt_to_player = num_cards_dealt_to_player + 1
end #end of loop do deal 2 cards
#
#### Code to loop through players prompting to hit, stand, or exit
#
@bj.display_dealer_card
current_player = 0
loop do #loop for all players prompt for hit or stand

  if current_player == @num_players then break end
  $stdout.write("For player #{current_player + 1} \n")

  loop do #prompt for hit or stand
    @bj.display_player_card(current_player)
    $stdout.write("Choose whether you want to Hit, Stand, or Exit: ")

    answer = $stdin.gets.chomp.capitalize
    puts("You said: #{answer}")

    if answer == "Exit" then exit end
    if answer == "Hit" then
      card = @bj.deal_player_card(current_player)


      a = @bj.add_players_lowest_hand(current_player)
      $stdout.write("a =  #{a} \n")
      if a > 21 then

        $stdout.write("Player #{current_player + 1} has gone bust \n")
        @bj.reset_players_hand(current_player)

        break
      end # end of if a > 21

      next
    end # end of answer == hit

    if answer == "Stand" then break end
    $stdout.write("You entered a wrong command")

  end # prompt hit or stand

  current_player = current_player + 1

end #end of loop through current number of player
#
# ### Deal dealer cards until value is  > 16
#
loop do #deal dealer card until > 16
  dealers_total = @bj.determine_dealers_best_total
  # $stdout.write("Deal until > 16 #{dealers_total} \n")

  if dealers_total > 16 then break end
  # $stdout.write("To dealer ------")
  @bj.deal_dealer_card

end # end of loop do deal dealer card until > 16
#
# ### test to see if dealer has gone bust
#
dealers_total = @bj.determine_dealers_best_total
if dealers_total > 21 then
  @bj.init_dealer_hand

  dealers_total = 0
  $stdout.write("Dealer has gone bust #{dealers_total} \n")
end #check if dealer has gone bust
#
# ### loop through current players to determine who wins
#
$stdout.write("Dealers total #{dealers_total} \n")

current_player = 0
loop do #Loop through all player's hands and decide winner'
  if current_player >= @num_players then break end

  # $stdout.write("For player #{current_player + 1} \n")
  players_total = @bj.determine_players_best_total(current_player)

  # $stdout.write("Players total #{players_total} \n")
  if players_total == 0
    $stdout.write("Player #{current_player + 1} Busted! \n")

  elsif players_total == dealers_total
    $stdout.write("Player #{current_player + 1} has a draw! \n")
  elsif players_total > dealers_total

    $stdout.write("Player #{current_player + 1} Wins! \n")
  elsif players_total < dealers_total
    $stdout.write("Player #{current_player + 1} Loses! \n")

  end # end of if players total = dealers total
  current_player = current_player + 1
end # end of Loop through all player's hands and decide winner'

$stdout.write("End of dealing all players")

exit #end of loop and end of program
