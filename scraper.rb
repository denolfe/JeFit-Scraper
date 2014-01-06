require 'rubygems'
require 'mechanize'
require 'logger'
require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'date'

require './log'

class Scraper

	def initialize()
		# Agent Setup
		@agent = Mechanize.new
		@agent.log = Logger.new 'mech.log'
		@agent.user_agent_alias = 'Mac Safari'
		@agent.follow_meta_refresh = true
		@agent.redirect_ok = true

		# Open page, Fill out form
		puts 'Opening JeFit...'
		@page = @agent.get 'http://www.jefit.com/login/'
		form = @page.form_with(:id => 'registerform')
		username_field = form.field_with(:name => 'vb_login_username').value = ARGV[0]
		password_field = form.field_with(:name => 'vb_login_password').value = ARGV[1]
		@page = @agent.submit form

		# Log in
		puts 'Logging in...'
		sleep(2)
		@page = @agent.get 'http://www.jefit.com/my-jefit/'
		sleep(2)
	end

	def get_data(start_month=1, end_month=12, year)
		year = Date.today.strftime("%Y") if year.nil?
		(start_month..end_month).each do |month|
			# Get logs from calendar
			@page = @agent.get "http://www.jefit.com/my-jefit/my-logs/?yy=#{year}&mm=#{month.to_s}"
			

			calendar_link = @page.parser.css('.calenderDay img') # days with entries contain an image
			link_count = calendar_link.length.to_i
			puts "\nGetting logs for #{month.to_s}, #{year.to_s}... #{link_count.to_s} logs found.\n"
			if link_count > 0
				# Get each day's log links
				workout_day = Array.new
				calendar_link.each_with_index do |link, index|
					workout_day.push('http://www.jefit.com' << link.parent.attributes['href'].to_s)
				end

				# Loop each log entry for exercises
				workout_day.each do |link|
					log_date = /\d+-\d+-\d+/.match(link)
					log = Log.new(log_date, link.to_s)
					@page = @agent.get log.link
					# puts page.parser.css('div#workout-logs .dahsed-bottom-row')
					entries = @page.parser.css('div#workout-logs .dahsed-bottom-row') #page.parser.css('div#workout-logs .dahsed-bottom-row a')
					entries.each_with_index do |entry, index|
						exercise_name = entry.at_css('a').text.strip
						rep_string = entry.css('div')[3].text
						log.process_exercise(exercise_name, rep_string)
					end
				end
			end
		end
	end
end

if __FILE__ == $0
	if ARGV[0].nil? || ARGV[1].nil?
		puts 'Credentials not entered.'
		exit
	end

scraper = Scraper.new
scraper.get_data(1, 12, 2013)

end # if file