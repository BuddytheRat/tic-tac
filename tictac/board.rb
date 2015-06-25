class TicTac
  class Board
    def initialize(x, y)
      @border = {
        top: '~',
        side: ':',
        corner: '.'
      }
      @width = x
      @height = y
      @char_width = (@width*2)+1
      #create 2d array with numbered cells
      @gameboard = Array.new(@width) { Array.new(@height) }
      cell_number = 1
      @width.times do |x|
        @height.times do |y|
          @gameboard[x][y] = cell_number.to_s
          cell_number += 1
        end 
      end
    end

    def display
      line = ((@border[:corner] + @border[:top])*@width) + @border[:corner]
      # puts board here:
      puts line
      each_row do |row|
        row.each_with_index do |cell, y|
          print @border[:side] + cell
          print @border[:side] + "\n" if y == @width-1
        end
        puts line
      end
    end

    def empty_spaces
      empty_spaces = []
      each_cell do |cell|
        empty_spaces << cell if cell =~ /\d/
      end
      return empty_spaces
    end

    def add_symbol(num, symbol)
      each_cell do |x, y|
        if @gameboard[x][y] == num
          @gameboard[x][y] = symbol
          break
        end
      end
    end

    private
    def each_row
      @gameboard.each_with_index do |row, x|
          yield(row, x)
      end        
    end 

    def each_cell
      each_row do |row, x|
        row.each_with_index do |cell, y|
          yield(x, y)
        end
      end
    end

    def game_won?

    end
  end
end