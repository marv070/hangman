require "minitest/autorun"
require_relative "hangman.rb"

class TestHangMan <Minitest::Test

	def test_create_new_instance_of_hangman
		game = Hangman.new("PIZZA")
		assert_equal("pizza", game.word)
	end

	def test_create_anothe_new_instance_of_hangman
		game = Hangman.new("TaBle")
		assert_equal("table", game.word)
	end

	
	def test_check_to_see_if_letter_picked_has_already_been_picked
		game = Hangman.new("TaBle")
		choice = "a"
		game.already_guessed = ["a"]
		assert_equal(true, game.already_guessed?(choice))
	end

	def test_check_to_see_if_letter_not_picked_returns_true
		game = Hangman.new("TaBle")
		choice = "a"
		game.already_guessed = []
		assert_equal(false, game.already_guessed?(choice))
	end

	def test_that_non_picked_letter_goes_into_already_guessed_array
		game = Hangman.new("TaBle")
		choice = "a"
		assert_equal(["a"], game.update_guessed(choice))
	end

	def test_that_non_picked_letter_goes_into_already_guessed_array_with_letters
		game = Hangman.new("TaBle")
		game.already_guessed = ["a"]
		choice = "b"
		assert_equal(["a","b"], game.update_guessed(choice))
	end

	def test_to_check_letter_guessed_matches_letter_in_key_word
		game = Hangman.new("pizza")
		choice = "p"
		assert_equal(true, game.good_guess?(choice))
	end

	def test_to_check_another_letter_guessed_matches_letter_in_key_word
		game = Hangman.new("pizza")
		choice = "z"
		assert_equal(true, game.good_guess?(choice))
	end

	def test_to_check_non_matching_letter_guessed_returns_false_in_good_guess?
		game = Hangman.new("pizza")
		choice = "v"
		assert_equal(false, game.good_guess?(choice))
	end

	def test_create_correct_number_of_spaces_with_in_progress
		game = Hangman.new("PIZZA")
		assert_equal("_____", game.progress)
	end

	def test_create_correct_number_of_spaces_with_in_progress1
		game = Hangman.new("MinedMinds")
		assert_equal("__________", game.progress)
	end

	def test_update_correct_space_within_progress_with_guessed_letter
		game = Hangman.new("pizza")
		choice = "p"
		assert_equal("p____", game.update_progress(choice))
	end

	def test_update_correct_space_within_progress_with_guessed_letter2
		game = Hangman.new("pizza")
		choice = "i"
		assert_equal("_i___", game.update_progress(choice))
	end


	def test_update_multiply_correct_spaces_within_progress_with_guessed_letter
		game = Hangman.new("pizza")
		choice = "z"
		assert_equal("__zz_", game.update_progress(choice))
	end


	def test_do_not_update_progress_with_invalid_guess
		game = Hangman.new("pizza")
		choice = "k"
		assert_equal("_____", game.update_progress(choice))
	end

	def test_for_winner_by_matching_progress_with_key_word
		game = Hangman.new("pizza")
		game.progress = "pizza"
		assert_equal(true, game.winner?)
	end

	def test_for_non_winner_by_matching_progress_with_key_word
		game = Hangman.new("pizza")
		game.progress = "p_zz_"
		assert_equal(false, game.winner?)
	end

	def test_to_check_loser_method_returns_true_if_out_of_chances
		game = Hangman.new("pizza")
		game.chances = 0
		assert_equal(true, game.loser?)
	end

	def test_to_check_loser_method_returns_false_if_chances_left
		game = Hangman.new("pizza")
		game.chances = 8
		assert_equal(false, game.loser?)
	end

	def test_show_all_guesses_method_returns_all_letters_guessed
		game = Hangman.new("pizza")
		game.already_guessed = []
		assert_equal("", game.show_all_guesses)
	end
	
	def test_show_all_guesses_method_returns_all_letters_guessed_with_3_guessed_letters
		game = Hangman.new("pizza")
		game.already_guessed = ["a","b","c"]
		assert_equal("a, b, c", game.show_all_guesses)
	end

	def test_returns_all_letters_guessed_in_abc_order_with_4_guessed_letters
		game = Hangman.new("pizza")
		game.already_guessed = ["i","p","c","w"]
		assert_equal("c, i, p, w", game.show_all_guesses)
	end

	def test_return_progress_returns_string
		game = Hangman.new("pizza")
		game.progress = "_i__a"
		assert_equal("_ i _ _ a", game.show_progress)
	end
	
	def test_return_progress_returns_string_with_minedminds
		game = Hangman.new("minedminds")
		game.progress = "m__e_____s"
		assert_equal("m _ _ e _ _ _ _ _ s", game.show_progress)
	end
	
	def test_that_chances_decrease_with_incorrect_guess
		game = Hangman.new("pizza")
		game.chances = 8
		assert_equal(7, game.update_chances_left)
	end

	def test_that_chances_do_not_decrease_with_correct_guess
		game = Hangman.new("pizza")
		game.chances = 1
		assert_equal(0, game.update_chances_left)
	end

end