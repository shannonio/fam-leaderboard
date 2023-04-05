require 'rails_helper'

RSpec.describe "Api::V1::SmsGameScores", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/sms_game_scores/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/sms_game_scores/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/sms_game_scores/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
