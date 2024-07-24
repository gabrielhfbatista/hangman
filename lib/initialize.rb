require 'tty-cursor'
require 'whirly'
require 'color-console'

class Initialization
  @@letters = []

  def self.initialize_game
    system('cls')
    cursor = TTY::Cursor
    print cursor.move_to(50, 15)    

    Whirly.start spinner: "pong", color:false, status: "Loading..." do
      sleep 3
    end                   
  end

  def self.create_underscores(word)
    word.chars.map { |c| c == ' ' ? ' ' : '_' }.join(' ')
  end

  def self.display_missed_letters(letter, option)
    @@letters << letter unless @@letters.include?(letter)
    system('cls')
    cursor = TTY::Cursor
    print cursor.move_to(50, 15)

    case option
    when 1
      Console.puts "Missed Letters: #{@@letters.join(', ').upcase}", :red
    when 2
      Console.puts "Letras erradas: #{@@letters.join(', ').upcase}", :red
    else
      Console.puts "Letras equivocadas: #{@@letters.join(', ').upcase}", :red
    end
    puts ""

    hangman_figures = [
      '',
      '                                                                  +---+
                                                                  |   |
                                                                  O   |
                                                                      |
                                                                      |
                                                                      |
                                                              =========',
      '                                                                  +---+
                                                                  |   |
                                                                  O   |
                                                                  |   |
                                                                      |
                                                                      |
                                                              =========',
      '                                                                  +---+
                                                                  |   |
                                                                  O   |
                                                                 /|   |
                                                                      |
                                                                      |
                                                              =========',
      '                                                                  +---+
                                                                   |   |
                                                                   O   |
                                                                  /|\  |
                                                                       |
                                                                       |
                                                               =========',
      '                                                                  +---+
                                                                   |   |
                                                                   O   |
                                                                  /|\  |
                                                                  /    |
                                                                       |
                                                               =========',
      '                                                                  +---+
                                                                   |   |
                                                                   O   |
                                                                  /|\  |
                                                                  / \  |
                                                                       |
                                                               ========='
    ]
    puts hangman_figures[@@letters.size] if @@letters.size < hangman_figures.length
  end
end