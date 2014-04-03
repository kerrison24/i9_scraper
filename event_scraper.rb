require 'nokogiri'
require 'open-uri'

class EventScraper
	def initialize(url)
		@doc = Nokogiri::HTML(open(url))
	end

	def get_event
		@doc.css('.vevent')
	end
	
	def get_summary
		@doc.css('a.url h3.summary')
	end

	def get_date
		@doc.css('.dtstart')
	end

	def css(x)
		@doc.css(x)
	end

	def link
		first["href"]
	end
end