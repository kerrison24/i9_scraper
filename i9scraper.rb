require 'csv'
require 'mailgun'
require_relative 'event_scraper'


#email client
Mailgun.configure do |config|
  config.api_key = 'key-9u1wnwp8c6d-5lby830nm6xz8gaixik7'
  config.domain  = 'sandbox92031.mailgun.org'
end
@mailgun = Mailgun()

#initialize nokogiri
events = EventScraper.new('http://inspire9.com/events')

#csv
CSV.open("i9_events.csv", "w") do |csv|
  csv << ["**Events coming up at Inspire9**"]
  csv << ["Event","Date","Time", "Link to event"]
	events.get_event.each do |event|
    csv << [event.css('h3.summary').first.content,
            event.css('.dtstart').first["datetime"].split.delete_at(0),
            event.css('.dtstart').first["datetime"].split.delete_at(1),
            event.css('a.url').first["href"]]
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

