require 'tty-cursor'
require 'whirly'

class Initialization
  @@letters = []

  def self.initializing
    system('cls')
    cursor = TTY::Cursor
    print cursor.move_to(50, 15)    

    Whirly.start spinner: "pong", color:false, status: "Loading..." do
      sleep 3
    end                   
  end

  def self.create_underscore_spaces(word)
    word.chars.map { |c| c == ' ' ? ' ' : '_' }.join(' ')
  end

  def self.missedLetters(letter, option)
    if @@letters.empty? || @@letters.last != letter
      @@letters << letter
    end
    system('cls')
    cursor = TTY::Cursor
    print cursor.move_to(50, 15)
      if option == 1
        puts "Missed Letters: #{@@letters.join(', ').upcase}"
      elsif option == 2
        puts "Letras erradas: #{@@letters.join(', ').upcase}"
      else
        puts "Letras equivocadas: #{@@letters.join(', ').upcase}"
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
    if @@letters.size < hangman_figures.length
      puts hangman_figures[@@letters.size]
    end
  end
end
