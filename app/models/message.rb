class Message < ActiveRecord::Base
  validates :text, :author, presence: true
end
