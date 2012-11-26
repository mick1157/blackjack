class GamesController < ApplicationController

  def show

    #
    #  ###  Find :black_games (row in table) associated with this user (as was stored in this users cookie)
    #
    bj_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @bj = bj_game.state                # Restore the BJ class instance vars
#   logger.info "****** Look here ***** bj= #{@bj.inspect} #{@bj.class}"
#    Rails.logger.info "****** Look here ***** #{@bj.class}"

    @dealer_card = @bj.display_dealer_card
    @player1_cards = @bj.display_player_card(1)
    @player2_cards = @bj.display_player_card(2)
    @player3_cards = @bj.display_player_card(3)
    @player4_cards = @bj.display_player_card(4)
    @current_player = @bj.fetch_current_player
    @num_players = @bj.fetch_num_players
    @debug_game = @bj.fetch_debug_game
    #
    #  ### If @debug = 'on' then
    #  ###      Read entire :blackjack_games table into and array to display for debugging purposes
    #
    if @debug_game == 'on'
      @blackjackgame_array = BlackjackGame.order("created_at DESC").all
    end # end if debug

  end #end show

  #
  # ###  All players have chosen to Stand (or have busted) -- time to calculate the winner
  #
  def winner
    #
    #  ###  Find :blackjack_games (row in table) associated with this user (as was stored in this users cookie)
    #
    bj_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @bj = bj_game.state                  # Restore the BJ class instance vars
    #
    # ###  Fetch the actual cards for all players
    # ###    need to set the current player before fetching display_cards (so all cards come back)
    #
    @bj.set_current_player(1)       # set current player to  player # 1
    @player1_cards = @bj.display_player_card(1)
    @bj.set_current_player(2)       # set current player to  player # 1
    @player2_cards = @bj.display_player_card(2)
    @bj.set_current_player(3)       # set current player to  player # 1
    @player3_cards = @bj.display_player_card(3)
    @bj.set_current_player(4)       # set current player to  player # 1
    @player4_cards = @bj.display_player_card(4)

    @player1_total = @bj.determine_players_best_total(1)
    @player2_total = @bj.determine_players_best_total(2)
    @player3_total = @bj.determine_players_best_total(3)
    @player4_total = @bj.determine_players_best_total(4)

    @current_player = @bj.fetch_current_player
    @num_players = @bj.fetch_num_players
    #
    # ### Deal dealer cards until value is  > 16
    #
    loop do           # deal dealer card until > 16
      @dealer_total = @bj.determine_dealers_best_total
      if @dealer_total > 16 then break end
      @bj.deal_dealer_card
    end # end of loop do deal dealer card until > 16
    #
    # ### Fetch all dealer cars to display
    #
    @dealer_cards = @bj.display_dealer_card("dealer")    # Fetch all cards in dealer hand
    #
    # ### test to see if dealer has gone bust
    #
    dealer_total = @dealer_total
    if dealer_total > 21 then
      dealer_total = 0
    end #check if dealer has gone bust
    #
    # ### Determine each players (winning) status
    #
    if @player1_total == 0; @player1_status = "skipped!"
    elsif @player1_total > 21; @player1_status = "Busted!"
    elsif @player1_total == dealer_total; @player1_status = "a draw!"
    elsif @player1_total > dealer_total; @player1_status = "Wins!"
    elsif @player1_total < dealer_total; @player1_status = "Loses!"
    end # end of if player1 total = dealers total

    if @player2_total == 0; @player2_status = "skipped!"
    elsif @player2_total > 21; @player2_status = "Busted!"
    elsif @player2_total == dealer_total; @player2_status = "a draw!"
    elsif @player2_total > dealer_total; @player2_status = "Wins!"
    elsif @player2_total < dealer_total; @player2_status = "Loses!"
    end # end of if player1 total = dealers total

    if @player3_total == 0; @player3_status = "skipped!"
    elsif @player3_total > 21; @player3_status = "Busted!"
    elsif @player3_total == dealer_total; @player3_status = "a draw!"
    elsif @player3_total > dealer_total; @player3_status = "Wins!"
    elsif @player3_total < dealer_total; @player3_status = "Loses!"
    end # end of if player1 total = dealers total

    if @player4_total == 0; @player4_status = "skipped!"
    elsif @player4_total > 21; @player4_status = "Busted!"
    elsif @player4_total == dealer_total; @player4_status = "a draw!"
    elsif @player4_total > dealer_total; @player4_status = "Wins!"
    elsif @player4_total < dealer_total; @player4_status = "Loses!"
    end # end of if player1 total = dealers total
    #
    #  ### If @debug = 'on' then
    #  ###      Read entire :blackjack_games table into and array to display for debugging purposes
    #
    @debug_game = @bj.fetch_debug_game
    if @debug_game == 'on'
      @blackjackgame_array = BlackjackGame.order("created_at DESC").all
    end # end if debug

  end #end winner

  #
  # ### Initialize a new game (create the BJ class and archive it to Blackjackgame)
  #
  def create
    @num_players = params[:num_players].to_i

    #
    # ###   Past max num of players allowed
    #
    if @num_players > 4
      redirect_to new_games_path, :notice => "Number of players requested exceeds the maximum number of 4!"
    end
    #
    # ### Create a new BJ class (instance vars) to store a new black jack game
    # ### establish the number of players for this game
    #
    @bj=BJ.new(@num_players)
    #
    #### code for dealing 2 cards to all the players and the dealer
    #
    2.times do                                  # Loop through deal 2 cards

      @num_players.times do |current_player|        # Loop through number of players
        card = @bj.deal_player_card(current_player+1)
      end #end of loop through current number of player

      @bj.deal_dealer_card
    end #end of loop do deal 2 cards
    #
    #### Save current BJ (game) instance variables to a external table
    #
    bj_game=BlackjackGame.create! :state => @bj
    session[:blackjackgame_id] = bj_game.id      # Save pointer of BJ object (db record) in cookie
    #
    #### Show the user the game state
    #
    redirect_to show_games_path, :notice => "Game initialized!"
  end # end create

  #
  # ### Initialize a new deal (intialize hands in the BJ class and update it to Blackjackgame database)
  #
  def newdeal
    #
    # ### Create a new BJ class (instance vars) to store a new black jack game
    # ### establish the number of players for this game
    #
    bj_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @bj = bj_game.state                  # Restore the BJ class instance vars
    #
    # ### Reset all the players and dealers hand  -- *and check in enough cards left in deck
    #
    @bj.init_dealer_hand
    @bj.init_player_hands
    @bj.set_current_player(1)       # set current player to  player # 1
    #
    #### code for dealing 2 cards to all the players and the dealer
    #
    @num_players = @bj.fetch_num_players
    2.times do                                  # Loop through deal 2 cards

      @num_players.times do |current_player|        # Loop through number of players
        card = @bj.deal_player_card(current_player+1)
      end #end of loop through current number of player

      @bj.deal_dealer_card
    end #end of loop do deal 2 cards
    #
    #### Save current BJ (game) instance variables to a external table
    #
    bj_game.save(:state => @bj) if bj_game
    #
    #### Show the user the game state
    #
    redirect_to show_games_path, :notice => "Game initialized!"
  end # end newdeal


  def hit
    @msg = "Player choose Hit...!"
    bj_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @bj = bj_game.state                  # Restore the BJ class instance vars

    @current_player = @bj.fetch_current_player    # fetch the instance var (from BJ object)

    @bj.deal_player_card(@current_player)
    #
    ### Check if player has gone bust -- (if so advance to next player)
    #
    current_player_lowest_total=@bj.add_players_lowest_hand(@current_player)
    if current_player_lowest_total > 21
      @msg = "Player has exceeded 21!"
      @num_players = @bj.fetch_num_players
      if @current_player < @num_players
        @current_player = @current_player + 1
        @bj.set_current_player(@current_player)
        bj_game.save(:state => @bj) if bj_game
        redirect_to show_games_path, :notice => @msg and return
      else
        bj_game.save(:state => @bj) if bj_game
        redirect_to winner_games_path, :notice => @msg and return
      end

    end

    bj_game.save(:state => @bj) if bj_game
    redirect_to show_games_path, :notice => @msg

  end # end hit

  def stand
    bj_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @bj = bj_game.state                  # Restore the BJ class instance vars

    @current_player = @bj.fetch_current_player    # fetch the instance var (from BJ object)
    @num_players = @bj.fetch_num_players          # fetch the instance var (from BJ object)

    #
    # ### Advance to next player and re-prompt for hit or stand
    #
    if @current_player < @num_players
      @current_player = @current_player + 1
      @bj.set_current_player(@current_player)      # store instance var (into BJ object)
      bj_game.save(:state => @bj) if bj_game
      redirect_to show_games_path, :notice => "Player choose Stand...!" and return
    else
    #
    # ### If already at last player then time to calculate winner
    #
      bj_game.save(:state => @bj) if bj_game
      redirect_to winner_games_path, :notice => "Time to calculate the winner...!" and return
    end

  end # end stand
  #
  # ###   Set the @debug_game instance variable to "on"
  #
  def start_debug
    bj_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @bj = bj_game.state                  # Restore the BJ class instance vars

    @debug_game = @bj.set_debug_game("on")    # set the instance var (in BJ object)

    bj_game.save(:state => @bj) if bj_game
    redirect_to show_games_path, :notice => "Debug stopped!"
  end
  #
  # ###   Set the @debug_game instance variable to "off"
  #
  def stop_debug
    bj_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @bj = bj_game.state                  # Restore the BJ class instance vars

    @debug_game = @bj.set_debug_game("off")    # set the instance var (in BJ object)

    bj_game.save(:state => @bj) if bj_game
    redirect_to show_games_path, :notice => "Debug stopped!"
  end

  def update
    @blackjackgame = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @blackjackgame.save :state => @bj if @blackjackgame
    redirect_to root_url, :notice => "Game saved!"


#    @blackjackgame = BlackjackGame.find(params[:id])
#    @blackjackgame.attributes = params[:BlackjackGame]
#    if @blackjackgame.save :state => @bj
#      flash[:notice] = "Blackjack game updated"
#    end

  end # end update


  def destroy
    @blackjackgame = BlackjackGame.find_by_id(session[:blackjackgame_id])
    @blackjackgame.destroy if @blackjackgame
    redirect_to root_url, :notice => "Game terminated!"
  end # end destroy


end # class GameController
