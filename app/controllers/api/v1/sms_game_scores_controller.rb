class Api::V1::SmsGameScoresController < ApplicationController
 def index
    scores = SmsGameScore.all.group_by(&:user_id).map{|user_id, records| {
      userId: user_id, 
      userName: records.first.user.name,
      totalScore: records.sum(&:score)
    }}

    render json: scores
  end

  def show
  end

  def destroy
  end

  private

  def recipe_params
    params.permit(:name, :image, :ingredients, :instruction)
  end
end
