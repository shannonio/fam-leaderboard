class ApplicationController < ActionController::Base
    attr_reader :display_scores

    def index
        scores = SmsGameScore.all.group_by(&:user_id).map{|user_id, records| {
        userId: user_id, 
        userName: records.first.user.name,
        totalScore: records.sum(&:score)
        }}
    
        puts @display_scores = scores.map { |score| "| #{score.name} #{score.totalScore} |" }.join("")
    end
end
