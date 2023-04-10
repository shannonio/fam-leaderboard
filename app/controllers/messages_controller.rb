class MessagesController < ApplicationController 
  attr_reader :title, :user, :message_body

  skip_before_action :verify_authenticity_token
 #skip_before_action :authenticate_user!, :only => "reply"

  def reply
    @message_body = params["Body"]
    @user = User.find_by_phone_number(params["From"])
    @title = @message_body.split(" ")[0].tr('#', '').downcase

    from_number = params["From"]
    boot_twilio  
    did_win?(@message_body)
  end

  private

  def boot_twilio
    account_sid = 'AC83bc1cbc9a3b6e328c1e18828c440b37'
    auth_token = '3b8301b85407d8c5dc3f69966967ab2a'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def did_win?(body)
    case @title
    when "wordle"
      did_win_wordle?(body)
    when "worldle"
      did_win_worldle?(body)
    when "framed"
      did_win_framed?(body)
    when "heardle"
      did_win_heardle?(body)
    else
      puts "I don't know this game #{@title}"
    end
  end

  def score_it(score)
    SmsGameScore.create!(
        name: @title,
        score: score,
        user: @user
      )
  end


  def did_win_wordle?(body)
    match = body.match(/\d\/6/)
    if match
      x = match.to_s[0]
      score_it(x.to_i)
    else
      score_it(0)
    end
  end

  def did_win_worldle?(body)
    if body =~ /100%/
      score_it(1)
    else
      score_it(0)
    end
  end

  def did_win_heardle?(body)
    if body =~ /\u{1F7E9}/
      score_it(1)
    else
      score_it(0)
    end
  end

  def did_win_framed?(body)
    if body =~ /\u{1F7E9}/
      score_it(1)
    else
      score_it(0)
    end
  end

  def did_win_nyt_crosswords(body)
  end
end