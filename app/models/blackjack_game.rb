class BlackjackGame < ActiveRecord::Base
  attr_accessible :state

  serialize :state
end
