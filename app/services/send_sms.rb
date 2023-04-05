require 'twilio-ruby'

account_sid = 'AC83bc1cbc9a3b6e328c1e18828c440b37'
auth_token = '3b8301b85407d8c5dc3f69966967ab2a'
client = Twilio::REST::Client.new(account_sid, auth_token)

from = '+18444860817' # Your Twilio number
to = '+17192587876' # Your mobile phone number

client.messages.create(
from: from,
to: to,
body: "Hey friend!"
)