require_relative 'initialize'
require_relative 'draw_words'

class Hangman
  attr_reader :word, :won, :attempts, :option

  def initialize
    Initialization.initialize_game
    display_language_options
    @option = get_valid_option
    @word = DrawWords.draw(@option)
    @won = false
    @attempts = 6
    display_game_intro
    play(@option)
  end

  def play(option)
    underscore_spaces = Initialization.create_underscores(@word)
    puts ""
    puts "                                                        #{underscore_spaces}"
    puts ""
    guessed_letters = []
    attempts_left = @attempts
  
    while attempts_left > 0
      display_guess_prompt(attempts_left)
      letter = get_valid_letter
  
      if guessed_letters.include?(letter)
        case option
        when 1
          Console.puts "You already guessed that letter! Guessed letters: #{guessed_letters.join(', ').upcase}", :red
        when 2
          Console.puts "Você já chutou essa palavra! Palavras chutadas: #{guessed_letters.join(', ').upcase}", :red
        when 3
          Console.puts "¡Ya has adivinado esa palabra! palabras patadas #{guessed_letters.join(', ').upcase}", :red
        end
      elsif @word.downcase.include?(letter)
        case option
        when 1
          Console.puts "Your word contains the letter '#{letter}'!", :green
        when 2
          Console.puts "Sua palavra contém a letra '#{letter}'!", :green
        when 3
          Console.puts "Tu palabra contiene la letra '#{letter}'!", :green
        end
        guessed_letters << letter
        underscore_spaces = update_underscore_spaces(guessed_letters)
        puts ""
        puts "                                                #{underscore_spaces}"
        puts ""
        if underscore_spaces.gsub(/\s+/, "") == @word
          case option
          when 1
            Console.puts "Congratulations, you guessed the word '#{@word}'!", :green
          when 2
            Console.puts "Parabéns, você adivinhou a palavra '#{@word}'!", :green
          when 3
            Console.puts "Congratulaciones por adivinar la palabra '#{@word}'!", :green
          end
          break
        end
      else
        Initialization.display_missed_letters(letter, @option)
  
        case option
        when 1
          Console.puts "Your word doesn't contain the letter '#{letter}'!", :red
        when 2
          Console.puts "Sua palavra não contém a letra '#{letter}'!", :red
        when 3
          Console.puts "Tu palabra no contiene la letra '#{letter}'!", :red
        end
  
        guessed_letters << letter
        attempts_left -= 1
        puts ""
        puts "                                                #{underscore_spaces}"
        puts ""
      end
    end
  
    if attempts_left == 0
      case option
      when 1
        Console.puts "Game over! The word was '#{@word}'.", :red
      when 2
        Console.puts "Fim de Jogo! A palavra era '#{@word}'!", :red
      when 3
        Console.puts "¡Fin del juego! La palabra era '#{letter}'!", :red
      end
    end
  end

  private

  def display_language_options
    language_options = <<-LANGUAGE
      Select a language! 

      1- English
      2- Portuguese
      3- Spanish
    LANGUAGE
    puts language_options
  end

  def get_valid_option
    option = gets.chomp.to_i
    if option.is_a?(Integer) && option >= 1 && option <= 3
      option
    else
      Console.puts "Option Invalid! There's no option like that!", :red
      exit
    end
  end

  def display_game_intro
    system('cls')
      puts ""
      puts "  _ _ _       _                          _           _____                                    _____                  "
      puts " | | | | ___ | | ___  ___  _____  ___   | |_  ___   |  |  | ___  ___  ___  _____  ___  ___   |   __| ___  _____  ___ "
      puts " | | | || -_|| ||  _|| . ||     || -_|  |  _|| . |  |     || .'||   || . ||     || .'||   |  |  |  || .'||     || -_|"
      puts " |_____||___||_||___||___||_|_|_||___|  |_|  |___|  |__|__||__,||_|_||_  ||_|_|_||__,||_|_|  |_____||__,||_|_|_||___|"
      puts "                                                                     |___|                                           "
      puts ""
      puts ""
      puts ""
      puts "                                                        +---+"
      puts "                                                        |   |"
      puts "                                                            |"
      puts "                                                            |"
      puts "                                                            |"
      puts "                                                        ========="
      puts ""
      puts ""
  end

  def only_letters?(input)
    input.match?(/^[[:alpha:]]+$/)
  end

  def get_valid_letter
    letter = gets.chomp.downcase
    if only_letters?(letter) && !@word.nil?
      letter
    else
      Console.puts "Enter a valid letter!", :red
      get_valid_letter
    end
  end

  def display_guess_prompt(attempts_left)
    case @option
    when 1
      Console.puts "Guess a letter (#{attempts_left} attempts left):"
    when 2
      Console.puts "Chute uma letra (#{attempts_left} tentativas restantes):"
    else
      Console.puts "Escribelo una letra (#{attempts_left} intentos restantes):"
    end
  end

  def update_underscore_spaces(guessed_letters)
    @word.chars.map { |c| guessed_letters.include?(c.downcase) || c == ' ' ? c : '_' }.join(' ')
  end
end