require_relative 'board.rb'
require_relative 'number.rb'
require_relative 'reset_screen'

game= Board.new
game.start
game.print_board


until game.finished?
  string = "wrong key inputd"
  response= STDIN.gets.chomp()

  if response.downcase == "s"
    string= "moved left"
    moved= game.move
    combined= game.add_numbers

  elsif response.downcase == "e"
    string= "moved up"
    game.transposer
    moved= game.move
    combined= game.add_numbers
    game.transposer

  elsif response.downcase == "f"
    string= "moved right"
    game.reverser
    moved= game.move
    combined= game.add_numbers
    game.reverser

  elsif response.downcase == "d"
    string= "moved down"
    game.transposer
    game.reverser
    moved= game.move
    combined= game.add_numbers
    game.reverser
    game.transposer
  end


  if !game.filled? && (response.downcase == 'd' ||response.downcase == 's' || response.downcase == 'e' || response.downcase == 'f' )
    if moved || combined
      game.place_new_number
    end
  end
  reset_screen
  game.print_board
  puts string
end
