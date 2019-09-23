require 'sinatra'
require 'twilio-ruby'
require 'yaml'

secrets = YAML.load_file('secrets.yml')

get '/bother-robert' do

  if secrets["auth_keys"].include?(params['key'])
    account_sid = secrets["twilio_sid"]
    auth_token = secrets["twilio_token"]
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = secrets["from_number"]
    to = secrets["robert_number"]

    client.messages.create(
      from: from,
      to: to,
      body: "#{params['smartass']}"
    )
    return " 🤣  #{params['smartass']}!"
  else
    return "unauthorized, sucker"
  end

end