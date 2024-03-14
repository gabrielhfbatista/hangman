require_relative 'initialize'
require_relative 'draw_words'
require 'color-console'

class Hangman
  attr_reader :word
  attr_reader :won
  attr_reader :attempts
  attr_reader :option

  def initialize
    Initialization.initializing
    language = <<-LANGUAGE
      Select a language! 

      1- English
      2- Portuguese
      3- Spanish
    LANGUAGE
    puts language
    option = gets.chomp.to_i
    if option.is_a?(Integer) && option >= 1 && option <= 3
      @word = DrawWords.draw(option)
      @won = false
      @attempts = 6
      @option = option
      system('cls')
      puts ""
      Console.puts "  _ _ _       _                          _           _____                                    _____                  ", :green
      Console.puts " | | | | ___ | | ___  ___  _____  ___   | |_  ___   |  |  | ___  ___  ___  _____  ___  ___   |   __| ___  _____  ___ ", :green
      Console.puts " | | | || -_|| ||  _|| . ||     || -_|  |  _|| . |  |     || .'||   || . ||     || .'||   |  |  |  || .'||     || -_|", :green
      Console.puts " |_____||___||_||___||___||_|_|_||___|  |_|  |___|  |__|__||__,||_|_||_  ||_|_|_||__,||_|_|  |_____||__,||_|_|_||___|", :green
      Console.puts "                                                                     |___|                                           ", :green
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
    else
      return puts "Option Invalid! There's no option like that!"
    end
  end

  def only_letters?(input)
    input.match?(/^[[:alpha:]]+$/)
  end

  def play
    if @option == 1
      underscore_spaces = Initialization.create_underscore_spaces(@word)
      puts ""
      puts "                                                        #{underscore_spaces}"
      puts ""
      guessed_letters = []
      attempts_left = 6
      while attempts_left > 0
        puts "Guess a letter (#{attempts_left} attempts left):"
        letter = gets.chomp.downcase
        if only_letters?(letter)
          if guessed_letters.include?(letter)
            puts "You already guessed that letter! Guessed letters: #{guessed_letters.join(', ').upcase}"
          elsif @word.downcase.include?(letter)
            puts "Your word contains the letter '#{letter}'!"
            guessed_letters << letter
            underscore_spaces = @word.chars.map { |c| guessed_letters.include?(c.downcase) || c == ' ' ? c : '_' }.join(' ')
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
            if underscore_spaces.gsub(/\s+/, "") == @word
              puts "Congratulations, you guessed the word '#{@word}'!"
              break
            end
          else
            Initialization.missedLetters(letter, @option)
            puts "Your word doesn't contain the letter '#{letter}'!"
            guessed_letters << letter
            attempts_left -= 1
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
          end
        else
          puts "Digite uma letra válida!"
        end
      end
      if attempts_left == 0
        puts "Game over! The word was '#{@word}'."
      end
    elsif @option == 2
      underscore_spaces = Initialization.create_underscore_spaces(@word)
      puts ""
      puts "                                                      #{underscore_spaces}"
      puts ""
      guessed_letters = []
      attempts_left = 6
      while attempts_left > 0
        puts "Chute uma letra (#{attempts_left} tentativas restantes):"
        letter = gets.chomp.downcase
        if only_letters?(letter)
          if guessed_letters.include?(letter)
            puts "Você já chutou esta letra! Letras chutadas: #{guessed_letters.join(', ').upcase}"
          elsif @word.downcase.include?(letter)
            puts "Sua palavra contém essa letra '#{letter}'!"
            guessed_letters << letter
            underscore_spaces = @word.chars.map { |c| guessed_letters.include?(c.downcase) || c == ' ' ? c : '_' }.join(' ')
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
            if underscore_spaces.gsub(/\s+/, "") == @word.gsub(/\s+/, "")
              puts "Parabéns, você acertou a palavra, sua palavra era '#{@word}'!"
              break
            end
          else
            Initialization.missedLetters(letter, @option)
            puts "Sua palavra não contém essa letra '#{letter}'!"
            guessed_letters << letter
            attempts_left -= 1
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
          end
        else
          puts "Digite uma letra válida!"
        end
      end
      if attempts_left == 0
        puts "Fim de jogo! A palavra era '#{@word}'."
      end
    else
      underscore_spaces = Initialization.create_underscore_spaces(@word)
      puts ""
      puts "                                                      #{underscore_spaces}"
      puts ""
      guessed_letters = []
      attempts_left = 6
      while attempts_left > 0
        puts "Escribelo una letra (#{attempts_left} intentos restantes):"
        letter = gets.chomp.downcase
        if only_letters?(letter)
          if guessed_letters.include?(letter)
            puts "¡Ya escribiste esta letra: #{guessed_letters.join(', ').upcase}"
          elsif @word.downcase.include?(letter)
            puts "Tu palabra contiene esta letra '#{letter}'!"
            guessed_letters << letter
            underscore_spaces = @word.chars.map { |c| guessed_letters.include?(c.downcase) || c == ' ' ? c : '_' }.join(' ')
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
            if underscore_spaces.gsub(/\s+/, "") == @word.gsub(/\s+/, "")
              puts "Felicitaciones, entendiste bien la palabra, tu palabra fue '#{@word}'!"
              break
            end
          else
            Initialization.missedLetters(letter, @option)
            puts "Tu palabra no contiene esta letra '#{letter}'!"
            guessed_letters << letter
            attempts_left -= 1
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
          end
        else
          puts "Introduzca una letra válida!"
        end
      end
      if attempts_left == 0
        puts "¡Fin del juego! La palabra era '#{@word}'."
      end
    end
  end
end