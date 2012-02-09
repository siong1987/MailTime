class UsersController < ApplicationController
  def create
    gmail = Gmail.new(params[:username], params[:password])
    count = gmail.inbox.count + gmail.in_label('[Gmail]/Sent Mail').count
    Juggernaut.publish(["/start/#{params[:username]}"], {count: count}.to_json)
    #Juggernaut.publish(["/start/#{params[:username]}"], {count: 3000}.to_json)

    received_timestamps = []
    sent_timestamps = []

    # parsing received emails
    gmail.inbox.emails.each do |m|
      Juggernaut.publish(["/update/#{params[:username]}"], {count: 1}.to_json)

      timestamp = m.date.to_time.to_i
      received_timestamps << timestamp
    end

    # parsing sent emails
    gmail.in_label('[Gmail]/Sent Mail').emails.each do |m|
      Juggernaut.publish(["/update/#{params[:username]}"], {count: 1}.to_json)

      timestamp = m.date.to_time.to_i
      sent_timestamps << timestamp
    end

    #3000.times do |i|
    #  received_timestamps << (Time.now.to_i - rand(1000000))
    #end

    #1000.times do |i|
    #  sent_timestamps << (Time.now.to_i - rand(1000000))
    #end

    hash = {received: received_timestamps, sent: sent_timestamps}
    render json: hash
  end
end

