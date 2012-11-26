class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_game

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_game
    @current_game = BlackjackGame.find_by_id(session[:blackjackgame_id])
  end

end
