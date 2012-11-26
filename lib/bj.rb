#
# ###  Initialize the class Blackjack
#
class BJ
  #
  # ### Initialize Decks  and establish the number of players
  #
  def initialize(num_players)

    self.init_dealer_hand            # create instance array for holding dealers cards
    self.init_player_hands           # create instance arrays for holding all the players cards
    self.set_current_player(1)       # set instance current player to  player # 1
    self.set_num_players(num_players)   # Set a instance variable for holding current player
    self.set_debug_game("off")              # set a instance variable for holding a debug switch

    @deck = ["2 of spades","3 of spades","4 of spades","5 of spades","6 of spades",

             "7 of spades" ,"8 of spades","9 of spades" ,"10 of spades" ,"jack of spades",
             "queen of spades", "king of spades", "ace of spades" ,

             "2 of clubs","3 of clubs","4 of clubs","5 of clubs","6 of clubs","7 of clubs",
             "8 of clubs","9 of clubs","10 of clubs", "jack of clubs","queen of clubs", "king of clubs","ace of clubs" ,

             "2 of hearts","3 of hearts","4 of hearts" ,"5 of hearts","6 of hearts", "7 of hearts",
             "8 of hearts","9 of hearts","10 of hearts","jack of hearts","queen of hearts", "king of hearts", "ace of hearts",

             "2 of diamonds","3 of diamonds","4 of diamonds","5 of diamonds","6 of diamonds",
             "7 of diamonds" ,"8 of diamonds" ,"9 of diamonds" ,"10 of diamonds","jack of diamonds",

             "queen of diamonds", "king of diamonds", "ace of diamonds"]

    @deckhash = {"2 of spades" => 2,"3 of spades" => 3,"4 of spades" => 4,"5 of spades" => 5,"6 of spades" => 6,
                 "7 of spades" => 7,"8 of spades" => 8,"9 of spades" => 9,"10 of spades" => 10,"jack of spades" => 10,

                 "queen of spades" => 10, "king of spades" => 10, "ace of spades" => 1,
                 "2 of clubs" => 2,"3 of clubs" => 3,"4 of clubs" => 4,"5 of clubs" => 5,"6 of clubs" => 6,"7 of clubs" => 7,

                 "8 of clubs" => 8,"9 of clubs" => 9,"10 of clubs" => 10, "jack of clubs" => 10,"queen of clubs" => 10, "king of clubs" => 10,"ace of clubs" => 1,

                 "2 of hearts" => 2 ,"3 of hearts" => 3,"4 of hearts" => 4,"5 of hearts" => 5,"6 of hearts" => 6,"7 of hearts" => 7,

                 "8 of hearts" => 8,"9 of hearts" => 9,"10 of hearts" => 10,"jack of hearts" => 10,"queen of hearts" => 10, "king of hearts" => 10, "ace of hearts" => 1,

                 "2 of diamonds" => 2,"3 of diamonds" => 3,"4 of diamonds" => 4,"5 of diamonds" => 5,"6 of diamonds" => 6,

                 "7 of diamonds" => 7,"8 of diamonds" => 8,"9 of diamonds" => 9,"10 of diamonds" => 10,"jack of diamonds" => 10,

                 "queen of diamonds" => 10, "king of diamonds" => 10, "ace of diamonds" => 1}

    self.card_shuffle

  end #end of initialize
  #
  # ### Return the @debug_game instance variable
  #
  def fetch_debug_game
    return @debug_game
  end #end return
  #
  # ### Initialize the @debug_name instance variable
  #
  def set_debug_game(debug_game="off")     # can be "on" or "off"
    @debug_game = debug_game
  end #end initialize
  #
  # ### Initialize the @num_player instance variable
  #
  def set_num_players(num_players)
    @num_players = num_players
  end #end initialize
  #
  # ### Return the @num_player instance variable
  #
  def fetch_num_players
    return @num_players
  end #end return
  #
  # ### Initialize the @num_player instance variable
  #
  def set_current_player(current_player)
    @current_player = current_player
  end #end initialize
  #
  # ### Return the @current_player instance variable
  #
  def fetch_current_player
    return @current_player
  end #end return
  #
  # ### initialize player hands
  #
  def init_player_hands

    @player1_hand = []
    @player2_hand = []
    @player3_hand = []
    @player4_hand = []

  end # end init_play_hand
  #
  # ### Initialize Player Hands
  #
  def init_dealer_hand

    @dealer_hand = []

  end
  #
  # ### Shuffle Deck
  #
  def card_shuffle

    @deck.shuffle!

  end # end of card_shuffle
  #
  # ### Deal the Dealer a Card
  #
  def deal_dealer_card

    card = @deck.delete_at(0)
    @dealer_hand << card

  end #end of deal_dealer_card_method
  #
  # ### Dealing Player Cards
  #
  def deal_player_card(current_player)

    card = @deck.delete_at(0)
    if current_player == 1 then
      @player1_hand << card
    end
    if current_player == 2 then
      @player2_hand << card
    end
    if current_player == 3 then
      @player3_hand << card
    end
    if current_player == 4 then
      @player4_hand << card
    end

  end # end of dealing player card
  #
  # ### Displaying Dealer Cards (Return the only yhe 2cd card unless -- (the arg passed was equal to "dealer"))
  #
  def display_dealer_card(dealer="")
    card = []
    if dealer == "dealer"
      card = @dealer_hand               # Fetch all of dealers cards
    else
      card = ["blank card"]
      card << @dealer_hand.fetch(1)     # Fetch dealers 2cd card
    end
   return card
  end
  #
  # ### Displaying Player Cards
  # ###   if current player that is passed as arg == @current_player show  all cards
  # ###       otherwise hide the first card
  #
  def display_player_card(current_player)
    cards = []
    if current_player == 1 then
      if current_player == @current_player
        cards = @player1_hand
      else
        cards = ["blank card"]
        @player1_hand.each_index {|ndx| if ndx > 0 then cards << @player1_hand[ndx] end}
      end
    end
    if current_player == 2 then
      if current_player == @current_player
        cards = @player2_hand
      else
        cards = ["blank card"]
        @player2_hand.each_index {|ndx| if ndx > 0 then cards << @player2_hand[ndx] end}
      end
    end
    if current_player == 3 then
      if current_player == @current_player
        cards = @player3_hand
      else
        cards = ["blank card"]
        @player3_hand.each_index {|ndx| if ndx > 0 then cards << @player3_hand[ndx] end}
      end
    end
    if current_player == 4 then
      if current_player == @current_player
        cards = @player4_hand
      else
        cards = ["blank card"]
        @player4_hand.each_index {|ndx| if ndx > 0 then cards << @player4_hand[ndx] end}
      end
    end
    return cards
  end #end of displaying player card
  #
  # ### resets player's hand
  #
  def reset_players_hand(current_player)
    if current_player == 1 then
      @player1_hand = []
    end
    if current_player == 2 then
      @player2_hand = []
    end
    if current_player == 3 then
      @player3_hand = []
    end
    if current_player == 4 then
      @player4_hand = []
    end
  end # end of reset player's hand
#
# ### Sum of Dealer's Lowest total
#
  def determine_dealers_lowest_total
    sum_of_dealers_hand = 0
    @dealer_hand.each {|x|
      card_value = @deckhash.fetch(x)
      if card_value == 1 then card_value = 11
      end
      sum_of_dealers_hand = sum_of_dealers_hand + card_value
    }
    # ### This method returns sum of dealer's hand
    return sum_of_dealers_hand
  end #end of add dealer's hand
#
# ### This method returns sum of dealer's best total
#
  def determine_dealers_best_total
    # @dealer_hand = ['ace of spades', '5 of spades', '4 of spades', 'ace of diamonds']
    # @player1_hand = ['3 of spades', 'ace of hearts', '4 of spades', 'ace of clubs']
    # @player1_hand = ['ace of clubs', '2 of clubs', 'ace of hearts', '4 of hearts']
    #  @dealer_hand = ['king of hearts', '6 of diamonds']
    sum_of_dealers_hand = 0
    number_of_aces_in_hand = 0
    @dealer_hand.each {|x|                # begin loop adding dealers hand
      card_value = @deckhash.fetch(x)

      if card_value == 1 then             # adjust aces to a value of 11
        card_value = 11
        number_of_aces_in_hand = number_of_aces_in_hand + 1
      end
      sum_of_dealers_hand = sum_of_dealers_hand + card_value

    } #end of loop adding dealers hand

    if sum_of_dealers_hand > 21 then      # must set one or more aces back to one
      loop do
        if number_of_aces_in_hand == 0 then break end
        sum_of_dealers_hand = sum_of_dealers_hand - 10
        if sum_of_dealers_hand < 22 then break end
        number_of_aces_in_hand = number_of_aces_in_hand - 1
      end  #end of loop do
    end    #end of sum_of_dealers_hand > 21

    # $stdout.write("Showing card and value #{sum_of_dealers_hand}, #{number_of_aces_in_hand} \n")
    # ### this method returns of the dealer's best hand'

    sum_of_dealers_hand = sum_of_dealers_hand + 0

  end # end of determine dealers best total
#
# ### Method to sum players to the best total(to account for aces)
# ### This method returns sum of player's best hand
#
  def determine_players_best_total(current_player)
    # @player1_hand = ['ace of spades', '5 of spades', '4 of spades', 'ace of diamonds']
    # @player1_hand = ['3 of spades', 'ace of hearts', '4 of spades', 'ace of clubs']
    # @player1_hand = ['ace of clubs', '2 of clubs', 'ace of hearts', '4 of hearts']
    sum_of_players_hand = 0
    number_of_aces_in_hand = 0
    if current_player == 1 then
      @player1_hand.each {|x|                        #begin loop adding players hand
        card_value = @deckhash.fetch(x)
        if card_value == 1 then                      #adjust aces to a value of 11
          card_value = 11
          number_of_aces_in_hand = number_of_aces_in_hand + 1
        end   #end of ace adjustment
        sum_of_players_hand = sum_of_players_hand + card_value
      } #end of loop adding players hand

      if sum_of_players_hand > 21 then               #must set one or more aces back to one
        loop do
          if number_of_aces_in_hand == 0 then break end

          sum_of_players_hand = sum_of_players_hand - 10

          if sum_of_players_hand < 22 then break end
          number_of_aces_in_hand = number_of_aces_in_hand - 1
        end  #end of loop do
      end    #end of sum_of_players_hand > 21
    end #end if current player = 1

    if current_player == 2 then
      @player2_hand.each {|x|                        #begin loop adding players hand
        card_value = @deckhash.fetch(x)
        if card_value == 1 then                      #adjust aces to a value of 11
          card_value = 11
          number_of_aces_in_hand = number_of_aces_in_hand + 1
        end  #end of ace adjustment
        sum_of_players_hand = sum_of_players_hand + card_value
      } #end of loop adding players hand
      if sum_of_players_hand > 21 then               #must set one or more aces back to one
        loop do
          if number_of_aces_in_hand == 0 then break end
          sum_of_players_hand = sum_of_players_hand - 10
          $stdout.write("sum of players hand #{sum_of_players_hand} :")
          if sum_of_players_hand < 22 then break end
          number_of_aces_in_hand = number_of_aces_in_hand - 1
        end #end of loop do
      end   #end of sum_of_players_hand > 21
    end #end if current player = 2

    if current_player == 3 then
      @player3_hand.each {|x|                        #begin loop adding players hand
        card_value = @deckhash.fetch(x)
        if card_value == 1 then                      #adjust aces to a value of 11
          card_value = 11
          number_of_aces_in_hand = number_of_aces_in_hand + 1
        end  #end of ace adjustment
        sum_of_players_hand = sum_of_players_hand + card_value
      } #end of loop adding players hand
      if sum_of_players_hand > 21 then               #must set one or more aces back to one
        loop do
          if number_of_aces_in_hand == 0 then break end
          sum_of_players_hand = sum_of_players_hand - 10
#         $stdout.write("sum of players hand #{sum_of_players_hand}  :")
          if sum_of_players_hand < 22 then break end
          number_of_aces_in_hand = number_of_aces_in_hand - 1
        end  #end of loop do
      end  #end of sum_of_players_hand > 21
    end #end if current player = 3

    if current_player == 4 then
      @player4_hand.each {|x|                        #begin loop adding players hand
        card_value = @deckhash.fetch(x)
        if card_value == 1 then                      #adjust aces to a value of 11
          card_value = 11
          number_of_aces_in_hand = number_of_aces_in_hand + 1
        end  #end of ace adjustment
        sum_of_players_hand = sum_of_players_hand + card_value
      } #end of loop adding players hand
      if sum_of_players_hand > 21 then               #must set one or more aces back to one
        loop do
          if number_of_aces_in_hand == 0 then break end
          sum_of_players_hand = sum_of_players_hand - 10
#         $stdout.write("sum of players hand #{sum_of_players_hand}  :")
          if sum_of_players_hand < 22 then break end
          number_of_aces_in_hand = number_of_aces_in_hand - 1
        end #end of loop do
      end #end of sum_of_players_hand > 21
    end #end if current player = 4
    # ### This method returns sum of player's best hand
    return sum_of_players_hand
  end #end of sum of player's best hand
  #
  # ### Sum up of all the player's current hand
  # ###   This method returns sum of player's hand
  #
  def add_players_lowest_hand(current_player)
    sum_of_players_hand = 0
    if current_player == 1 then
      @player1_hand.each {|x|
        card_value = @deckhash.fetch(x)
        sum_of_players_hand = sum_of_players_hand + card_value
        # $stdout.write("Showing card and value #{x}, #{sum_of_players_hand}, #{card_value} \n")
      }
    end #end if current player = 1
    if current_player == 2 then
      @player2_hand.each {|x|
        card_value = @deckhash.fetch(x)
        sum_of_players_hand = sum_of_players_hand + card_value
        #  $stdout.write("Showing card and value #{x}, #{sum_of_players_hand}, #{card_value} \n")
      }
    end #end if current player = 2
    if current_player == 3 then
      @player3_hand.each {|x|
        card_value = @deckhash.fetch(x)
        sum_of_players_hand = sum_of_players_hand + card_value
        #  $stdout.write("Showing card and value #{x}, #{sum_of_players_hand}, #{card_value} \n")
      }
    end #end if current player = 3
    if current_player == 4 then
      @player4_hand.each {|x|
        card_value = @deckhash.fetch(x)
        sum_of_players_hand = sum_of_players_hand + card_value
        #  $stdout.write("Showing card and value #{x}, #{sum_of_players_hand}, #{card_value} \n")
      }
    end #end if current player = 4
# ### This method returns sum of player's hand
    return sum_of_players_hand
  end #end of add player's hand

end #end of class Blackjack
