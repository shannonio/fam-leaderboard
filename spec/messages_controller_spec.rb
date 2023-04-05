require "rails_helper"
require "spec_helper"

RSpec.describe MessagesController, type: :controller do
  describe "#reply" do
    let(:user) { User.create!(name: "Me", phone_number: "+1234567890") }
    let(:message_body) { "#Worldle #438 1/6 (100%) 🟩🟩🟩🟩🟩🎉" }
    let(:params) { { "From" => "+1234567890", "Body" => message_body } }

    describe "worldle winning" do
      let(:message_body) { "#Worldle #438 1/6 (100%) 🟩🟩🟩🟩🟩🎉" }

      before do
        allow(controller).to receive(:params).and_return(params)
        allow(User).to receive(:find_by_phone_number).with(params["From"]).and_return(user)
        allow(controller).to receive(:boot_twilio)
      end

      it "sets the @message_body instance variable" do
        controller.reply
        expect(controller.instance_variable_get(:@message_body)).to eq(message_body)
      end

      it "sets the @user instance variable" do
        controller.reply
        expect(controller.instance_variable_get(:@user)).to eq(user)
      end

      it "sets the @title instance variable" do
        controller.reply
        expect(controller.instance_variable_get(:@title)).to eq("worldle")
      end

      it "calls did_win? method with the correct argument" do
        expect(controller).to receive(:did_win?).with(message_body)
        controller.reply
      end

      it "creates a new smsgamescore in the database" do
        expect {
          controller.reply
        }.to change(SmsGameScore, :count).by(1)
      end

      it "creates a new game score with correct score in the database" do
        controller.reply
        record = SmsGameScore.last
        expect(record.score).to eq(1)
      end
    end

    describe "worldle losing" do
      let(:message_body) { "#Worldle #438 6/6 (60%) 🟩🟩🟩🟩🟩🎉" }

      before do
        allow(controller).to receive(:params).and_return(params)
        allow(User).to receive(:find_by_phone_number).with(params["From"]).and_return(user)
        allow(controller).to receive(:boot_twilio)
      end

      it "creates a new smsgamescore in the database" do
        expect {
          controller.reply
        }.to change(SmsGameScore, :count).by(1)
      end

      it "creates a new game score with correct score in the database" do
        controller.reply
        record = SmsGameScore.last
        expect(record.score).to eq(0)
      end
    end

    describe "wordle winning" do
      let(:message_body) { "
        Wordle 654 3/6
          🟨⬜⬜🟩🟩
          ⬜🟩🟩🟩🟩
          🟩🟩🟩🟩🟩
        " }

      before do
        allow(controller).to receive(:params).and_return(params)
        allow(User).to receive(:find_by_phone_number).with(params["From"]).and_return(user)
        allow(controller).to receive(:boot_twilio)
      end

      it "creates a new smsgamescore in the database" do
        expect {
          controller.reply
        }.to change(SmsGameScore, :count).by(1)
      end

      it "creates a new game score with correct score in the database" do
        controller.reply
        record = SmsGameScore.last
        expect(record.score).to eq(3)
      end
    end

    describe "wordle losing" do
      let(:message_body) {"
        Wordle 655 X/6

        ⬜⬜⬜⬜⬜
        ⬜⬜🟩⬜⬜
        ⬜⬜⬜🟨⬜
        ⬜⬜⬜⬜⬜
        🟩⬜🟩⬜⬜
        ⬜⬜⬜🟩⬜
      "}

      before do
        allow(controller).to receive(:params).and_return(params)
        allow(User).to receive(:find_by_phone_number).with(params["From"]).and_return(user)
        allow(controller).to receive(:boot_twilio)
      end

      it "creates a new smsgamescore in the database" do
        expect {
          controller.reply
        }.to change(SmsGameScore, :count).by(1)
      end

      it "creates a new game score with correct score in the database" do
        controller.reply
        record = SmsGameScore.last
        expect(record.score).to eq(0)
      end
    end
    
    describe "wordle losing" do
      let(:message_body) {"
        Wordle 655 X/6

        ⬜⬜⬜⬜⬜
        ⬜⬜🟩⬜⬜
        ⬜⬜⬜🟨⬜
        ⬜⬜⬜⬜⬜
        🟩⬜🟩⬜⬜
        ⬜⬜⬜🟩⬜
      "}

      before do
        allow(controller).to receive(:params).and_return(params)
        allow(User).to receive(:find_by_phone_number).with(params["From"]).and_return(user)
        allow(controller).to receive(:boot_twilio)
      end

      it "creates a new smsgamescore in the database" do
        expect {
          controller.reply
        }.to change(SmsGameScore, :count).by(1)
      end

      it "creates a new game score with correct score in the database" do
        controller.reply
        record = SmsGameScore.last
        expect(record.score).to eq(0)
      end
    end


  end
end
