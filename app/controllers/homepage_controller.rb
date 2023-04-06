class HomepageController < ApplicationController
    def index
        scores = SmsGameScore.all.group_by(&:user_id).map{|user_id, records| {
        userId: user_id, 
        userName: records.first.user.name,
        totalScore: records.sum(&:score)
        }}
    
        @display_scores = scores.map { |score| "| #{score[:userName]} #{score[:totalScore]} |" }.join("")
    end
end
