# Create a globally accessible Nexmo credentialed client instance
::Nexmo = Nexmo::Client.new do |config|
    config.api_key = ENV['NEXMO_API_KEY'],
    config.api_secret = ENV['NEXMO_API_SECRET'],
    config.api_signature = ENV['NEXMO_API_SIGNATURE'],
    config.application_id = ENV['NEXMO_APPLICATION_ID'],
    config.private_key = ENV['NEXMO_PRIVATE_KEY'],
    config.nexmo_number = ENV['NEXMO_NUMBER']
end