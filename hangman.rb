class Hangman
require 'csv'	
	attr_accessor :chances, :word, :already_guessed, :progress

	def initialize(word)
		 (@word = word).downcase!
		#(@word = word)
		@progress = "_" * word.length
		@chances = 6
		@already_guessed = []
	end
	def already_guessed?(choice)
		@already_guessed.include? choice 
	end

	def update_guessed(choice)
		@already_guessed << choice
	end

	def update_chances_left
		 @chances -= 1 
	end

	def good_guess?(choice)
		 found = false

		 @word.scan(/\w/) do |letter|
			letter == choice ? found = true : false
		 end
		
		found 
	end

	def update_progress(choice)
		(0...@word.length).zip(@word.scan(/\w/)) do |index,letter|
			  letter == choice ? @progress[index] = letter.upcase : false
		 end
		@progress
	end

	def show_progress
		@progress.scan(/_|\w/).join(' ')
	end

	#Returns a string of the previously guessed letters.
	def show_all_guesses
		@already_guessed.sort.join(", ")
	end

	def make_move(choice)
		update_guessed(choice)
		if good_guess?(choice)
			update_progress(choice)
		else
			update_chances_left
		end
	end

	def loser?
		@chances == 0
	end

	def winner?
		@progress.upcase == @word.upcase
	end

	def write_to_csv(file, name, keyword, win, date_time) 
		CSV.open(file, "a") do |csv|
  		csv << ["#{name}" + ", " + "#{keyword}" + ", " + "#{win}" + ", " + "#{date_time}"]
		end
	end

	def read_from_csv(csv_file_to_read)
		# game.write_to_csv("test_summary.csv", name, keyword, win, date_time)
		file = File.open(csv_file_to_read,"r")
		csv = CSV.parse(file)
	end

end