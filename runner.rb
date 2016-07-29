require_relative 'board.rb'
require_relative 'number.rb'

game= Board.new
game.start
game.print_board


until game.finished?

  response= STDIN.gets.chomp()
  board_snapshot = game.board
  if response.downcase == "s"
    puts "moved left"
    moved= game.move
    combined= game.add_numbers

  elsif response.downcase == "e"
    puts "moved up"
    game.transposer
    moved= game.move
    combined= game.add_numbers
    game.transposer

  elsif response.downcase == "f"
    puts "moved right"
    game.reverser
    moved= game.move
    combined= game.add_numbers
    game.reverser

  elsif response.downcase == "d"
    puts "moved down"
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

  game.print_board
end
