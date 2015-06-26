class TicTac
  class Board
    def initialize(x, y)
      @border = {
        padding: '/',
        top: '~',
        side: '|',
        corner: '.'
      }
      @left_padding = 15
      @top_padding = 2
      @width = x
      @height = y
      @board_width = (@width*2)+1
      @display_width = (@left_padding * 2) + @board_width
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
      left_pad = @border[:padding] * @left_padding
      line = left_pad + ((@border[:corner] + @border[:top])*@width) + @border[:corner] + left_pad
      pad_top = ((@border[:padding] * @display_width) + "\n") * @top_padding

      # print board here:
      print pad_top
      puts line
      each_row do |row|
        print left_pad
        row.each_with_index do |cell, y|
          print @border[:side] + cell
        end
        print @border[:side] + left_pad + "\n"
        puts line
      end
      print pad_top
    end

    def empty_spaces
      empty_spaces = []
      each_cell do |x, y|
        cell = @gameboard[x][y]
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

    def each_triple
      each_row do |row, x|
        
      end
    end

    def game_won?
      each_cell do |x, y|
        
      end
    end
  end
end