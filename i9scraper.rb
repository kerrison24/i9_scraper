require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mailgun'


#email client
Mailgun.configure do |config|
  config.api_key = 'key-9u1wnwp8c6d-5lby830nm6xz8gaixik7'
  config.domain  = 'sandbox92031.mailgun.org'
end
@mailgun = Mailgun()

#initialize nokogiri
doc = Nokogiri::HTML(open('http://inspire9.com/events'))

#csv
CSV.open("i9_events.csv", "w") do |csv|
  csv << ["**Events this week at Inspire9"]
	doc.css('h3.summary').each do |event|
    csv << [event]
  end
end

#email
parameters = {
  :to => "kerrisongarcia@gmail.com",
  :subject => "Inspire9 Events",
  :text => "Here are upcoming events at Inspire9.",
  :from => "kerrisongarcia@sandbox92031.mailgun.org",
  :attachment => File.open("i9_events.csv")
}
@mailgun.messages.send_email(parameters)

