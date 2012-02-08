class UsersController < ApplicationController
  def create
    gmail = Gmail.new(params[:username], params[:password])
    puts gmail.inbox.count
    puts 'hi'
  end
end
