
	


File.open("words.rb", 'r') do |keyword|
	words = []
	keyword.each { |w| words << w.gsub(/ /, '').chomp } #make sure word is free of spaces and trailing newline character removed
	
	game = Hangman.new(words[rand(words.length)]) #choose a random word
	
	