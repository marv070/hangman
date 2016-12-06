require 'sinatra'

require_relative 'hangman.rb'

enable :sessions

get'/' do
	session[:play] = nil

	erb :hang_word
end

post '/setup' do 
	word = params[:key_word]
	session[:play] = Hangman.new(word)
	session[:name] = params[:username].upcase
	   redirect '/choice'
end

get '/auto_word' do 
	File.open("dictionary.txt", 'r') do |keyword|
	words = []
	keyword.each { |w| words << w.gsub(/ /, '').chomp } #make sure word is free of spaces and trailing newline character removed
	
	session[:play] = Hangman.new(words[rand(words.length)]) #choose a random word
	end
	
	  redirect '/choice'
end

get '/choice' do
	chances_left = session[:play].chances
	current_progress = session[:play].show_progress
	all_letters_guessed = session[:play].show_all_guesses.upcase
	
	erb :choice, :locals => { :chances_left => chances_left, :current_progress => current_progress, :all_letters_guessed => all_letters_guessed, :name => session[:name]}

end

post '/choice' do
	choice = params[:choice].downcase
	date_time = DateTime.now
	file = "test_summary.csv"
	if session[:play].already_guessed?(choice) == true
	 	redirect '/choice'
	end
	session[:play].make_move(choice)
		if session[:play].winner?
	   		session[:play].write_to_csv(file, session[:name],session[:play].word, session[:play].winner?, date_time)

	   		 redirect '/winner'
		elsif 
			session[:play].loser?
			session[:play].write_to_csv("test_summary.csv", session[:name],session[:play].word, session[:play].winner?, date_time)
			redirect '/loser'
		else
			redirect '/choice'
		end
end

get '/winner' do
	keyword = session[:play].word.upcase
	erb :winner, :locals => { :keyword => keyword}
end




get '/loser' do
	keyword = session[:play].word.upcase
	erb :loser, :locals => { :keyword => keyword}
end



