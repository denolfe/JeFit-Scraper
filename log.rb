class Log
	attr_accessor :date
	attr_accessor :link
	attr_accessor :data

	def initialize(date, link)
		@date = date
		@link = link
		@db = SQLite3::Database.new( "workout.sqlite3" )
		init_db
		puts "\nLog created: " << date.to_s
	end

	def process_exercise(exercise_name, rep_string)
		puts "\n\t#{exercise_name}"

		if /\d+?.\d?x\d+/.match(rep_string) # Reps
			rep_array = rep_string.scan(/\d+?.\d?x\d+/)
			rep_array.each_with_index do |rep, index|
				set_num = index + 1
				output = rep.split('x')
				reps = output[1]
				lbs = output[0].to_i.floor.to_s
				puts "\t\tSet #{set_num}, Reps: #{reps}, Lbs: #{lbs}"
				@db.execute( "insert into workouts(DATE, Exercise, Set_Num, Reps, Weight) values ('#{@date}', '#{exercise_name}', #{set_num}, #{reps}, #{lbs} )" )
			end
		elsif /Laps\/Reps/.match(rep_string) # Just Reps
			rep_array = rep_string.scan(/(?<=\s)\d+(?!\s:)/)
			rep_array.each_with_index do |rep, index|
				set_num = index + 1
				puts "\t\tSet #{set_num}, Reps: #{rep}"
				@db.execute( "insert into workouts(DATE, Exercise, Set_Num, Reps) values ('#{@date}', '#{exercise_name}', #{set_num}, #{rep})" )
			end
		else
			rep_array = rep_string.scan(/\d+:\d+:\d+/)
			rep_array.each_with_index do |rep, index|
				set_num = index + 1
				time_array = rep.split(':')
				hrs = time_array[0].to_i * 60 * 60
				mins = time_array[1].to_i * 60
				secs = time_array[2].to_i
				total_time_secs = hrs + mins + secs
				puts "\t\tSet #{set_num}, Secs: #{total_time_secs}s"
				@db.execute( "insert into workouts(DATE, Exercise, Set_Num, Weight) values ('#{@date}', '#{exercise_name}', #{set_num}, #{total_time_secs} )" )
			end
		end
	end

	def init_db
			# Init DB
			workout_table = <<SQL
				CREATE TABLE IF NOT EXISTS Workouts ( 
				    ID       INTEGER        PRIMARY KEY AUTOINCREMENT
				                            UNIQUE,
				    Date     DATE           NOT NULL,
				    Exercise VARCHAR( 40 )  NOT NULL,
				    Set_Num  INT            NOT NULL,
				    Reps     INT            DEFAULT ( NULL ),
				    Weight   INT            DEFAULT ( NULL ) 
				);
SQL
				@db.execute_batch( workout_table )
	end
end