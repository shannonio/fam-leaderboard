class HomepageController < ApplicationController
    def index
        scores = SmsGameScore.all.order("score DESC").group_by(&:user_id).map{|user_id, records| {
          userId: user_id, 
          userName: records.first.user.name,
          totalScore: records.sum(&:score)
        }}

        @display_scores = scores.map { |score| "| #{score[:userName]} #{score[:totalScore]} |" }.join("")
        @display_rank = "🥇 #{scores[0][:userName]} | 🥈 #{scores[1][:userName]} | 🥉 #{scores[2]&[:userName]}"
    end
end
