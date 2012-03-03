class UsersController < ApplicationController
  def create
    gmail = Gmail.new(params[:username], params[:password])
    count = gmail.inbox.count + gmail.in_label('[Gmail]/Sent Mail').count

    received_timestamps = []
    sent_timestamps = []

    # parsing received emails
    gmail.inbox.emails.each do |m|
      begin
        timestamp = m.date.to_time.to_i
        received_timestamps << timestamp
      rescue
        next
      end
    end

    # parsing sent emails
    gmail.in_label('[Gmail]/Sent Mail').emails.each do |m|
      begin
        timestamp = m.date.to_time.to_i
        sent_timestamps << timestamp
      rescue
        next
      end
    end

    hash = {received: received_timestamps, sent: sent_timestamps}
    render json: hash
  end
end

