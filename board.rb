require_relative 'number.rb'
require 'pry'

class Board
attr_accessor :board

  def initialize
    @board = []
    4.times do
      @board << [["  "],["  "],["  "],["  "]]
    end
  end

  def place_new_number
    placed= false
    until placed
      x=rand(4)
      y=rand(4)
      if @board[x][y] == ["  "]
        @board[x][y] = Number.new
        placed= true
      end
    end
  end

  def start
    self.place_new_number
    self.place_new_number
    puts "Use left = s, up = e, right = f, down = d to move the pieces"
    puts " "
  end

  def reverser
    @board.map! { |row| row.reverse! }
    end

    def transposer
      @board= @board.transpose
    end

  def move
    moved= false
    @board.map! do |row|
      spaces= row.select { |x| x ==["  "] }
      numbers= row.select { |x| x !=["  "] }
      combine_row= numbers+spaces
      if row != combine_row
        if !moved
          moved= true
        end
      end
      row = combine_row
    end
    moved
  end



  def add_numbers
    combined= false
    @board.map! do |row|
      if row[0] != ["  "] && row[1] != ["  "]
        if row[0].value == row[1].value
          if !combined
            combined= true
          end
          row[0].value = 2*row[0].value
          row.delete_at(1)
          row << ["  "]
        end
      end
      if row[1] != ["  "] && row[2] != ["  "]
        if row[1].value == row[2].value
          if !combined
            combined= true
          end
          row[1].value = 2*row[1].value
          row.delete_at(2)
          row << ["  "]
        end
      end

      if row[2] != [" "] && row[3] != ["  "]
        if row[2].value == row[3].value && row[2] != ["  "]
          if !combined
            combined= true
          end
          row[2].value = 2*row[2].value
          row.delete_at(3)
          row << ["  "]
        end
      end
      row
    end
    combined
  end

  def filled?
    @board.each { |row| return false if row.include?(["  "]) }
    true
  end

  def finished?

    @board.each_with_index do |row, x|
      row.each_with_index do |element, y|
        if element != ["  "]
          if element.value == 2048
            puts "You Did It!"
            return true
          end
        end
      end
    end

    @board.each_with_index do |row, x|
      row.each_with_index do |element, y|

        if x < 3
          if element == ["  "] || @board[x+1][y] == ["  "]
            return false
          else
            if element.value == @board[x+1][y].value
              return false
            end
          end
        end

        if y < 3
          if element == ["  "] || @board[x][y+1] == ["  "]
            return false
          else

            if element.value == @board[x][y+1].value
              return false
            end
          end
        end


      end
    end
    puts "You Didn't Do It!"
    true
  end

  def print_board
    @board.each do |row|
      string= ""
      row.each do |element|
        if element == ["  "]
          string += "| #{element[0]} |"
        else
          if element.value < 10
            string += "| #{element.value}  |"
          elsif element.value < 100
            string += "| #{element.value} |"
          elsif element.value < 1000
            string += "|#{element.value} |"
          else
            string += "|#{element.value}|"
          end
        end
      end
      puts string
      puts " "
    end
  end


end
