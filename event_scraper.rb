require 'nokogiri'
require 'open-uri'

class EventScraper
	def initialize(url)
		@doc = Nokogiri::HTML(open(url))
	end

	def get_event
		@doc.css('.vevent')
	end
	
	def css(x)
		@doc.css(x)
	end
end