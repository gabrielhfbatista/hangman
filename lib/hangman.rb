require_relative 'initialize'
require_relative 'draw_words'

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
    else
      return Console.puts "Option Invalid! There's no option like that!", :red
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
        Console.puts "Guess a letter (#{attempts_left} attempts left):", :blue
        letter = gets.chomp.downcase
        if only_letters?(letter) && !@word.nil?
          if guessed_letters.include?(letter)
            puts "You already guessed that letter! Guessed letters: #{guessed_letters.join(', ').upcase}"
          elsif @word.downcase.include?(letter)
            Console.puts "Your word contains the letter '#{letter}'!", :green
            guessed_letters << letter
            underscore_spaces = @word.chars.map { |c| guessed_letters.include?(c.downcase) || c == ' ' ? c : '_' }.join(' ')
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
            if underscore_spaces.gsub(/\s+/, "") == @word
              Console.puts "Congratulations, you guessed the word '#{@word}'!", :green
              break
            end
          else
            Initialization.missedLetters(letter, @option)
            Console.puts "Your word doesn't contain the letter '#{letter}'!", :red
            guessed_letters << letter
            attempts_left -= 1
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
          end
        else
          Console.puts "Enter a valid word!", :red
        end
      end
      if attempts_left == 0
        Console.puts "Game over! The word was '#{@word}'.", :red
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
        if only_letters?(letter) && !@word.nil?
          if guessed_letters.include?(letter)
            puts "Você já chutou esta letra! Letras chutadas: #{guessed_letters.join(', ').upcase}"
          elsif @word.downcase.include?(letter)
            Console.puts "Sua palavra contém a letra '#{letter}'!", :green
            guessed_letters << letter
            underscore_spaces = @word.chars.map { |c| guessed_letters.include?(c.downcase) || c == ' ' ? c : '_' }.join(' ')
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
            if underscore_spaces.gsub(/\s+/, "") == @word.gsub(/\s+/, "")
              Console.puts "Parabéns, você acertou a palavra, sua palavra era '#{@word}'!", :green
              break
            end
          else
            Initialization.missedLetters(letter, @option)
            Console.puts "Sua palavra não contém essa letra '#{letter}'!", :red
            guessed_letters << letter
            attempts_left -= 1
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
          end
        else
          Console.puts "Digite uma letra válida!", :red
        end
      end
      if attempts_left == 0
        Console.puts "Fim de jogo! A palavra era '#{@word}'.", :red
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
        if only_letters?(letter) && !@word.nil?
          if guessed_letters.include?(letter)
            puts "¡Ya escribiste esta letra: #{guessed_letters.join(', ').upcase}"
          elsif @word.downcase.include?(letter)
            Console.puts "Tu palabra contiene esta letra '#{letter}'!", :green
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
            Console.puts "Tu palabra no contiene la letra '#{letter}'!", :red
            guessed_letters << letter
            attempts_left -= 1
            puts ""
            puts "                                                #{underscore_spaces}"
            puts ""
          end
        else
          Console.puts "Introduzca una letra válida!", :red
        end
      end
      if attempts_left == 0
        Console.puts "¡Fin del juego! La palabra era '#{@word}'.", :red
      end
    end
  end
end