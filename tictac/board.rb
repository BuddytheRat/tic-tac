class TicTac
  class Board
    def initialize(size)
      @border = {
        padding: ' ',
        top: '=',
        side: '!',
        corner: '-'
      }
      @left_padding = 12
      @top_padding = 2
      @size = size
      @board_width = (@size*2)+1
      @display_width = (@left_padding * 2) + @board_width
      #create 2d array with numbered cells
      @gameboard = Array.new(@size) { Array.new(@size) }
      cell_number = 1
      @size.times do |x|
        @size.times do |y|
          @gameboard[x][y] = cell_number
          cell_number += 1
        end 
      end
    end

    def display
      left_pad = @border[:padding] * @left_padding
      line = left_pad + ((@border[:corner] + @border[:top])*@size) + @border[:corner] + left_pad
      pad_top = ((@border[:padding] * @display_width) + "\n") * @top_padding

      # print board here:
      print pad_top
      puts line
      each_row do |row|
        print left_pad
        row.each_with_index do |cell, y|
          print @border[:side] + cell.to_s
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
        empty_spaces << cell if cell.to_s =~ /\d/
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

    def winning_combos
      combos = Array.new
      # rows
      each_row { |row| combos << row.dup }
      # columns
      @size.times do |y|
        combo = Array.new
        @size.times do |x|
          combo << @gameboard[x][y]
        end
        combos << combo.dup
      end
      # diagonal
      combo = Array.new
      y = 0
      @size.times do |x|
        combo << @gameboard[x][y]
        y += 1
      end
      combos << combo.dup
      # anti-diagonal
      combo = Array.new
      y = 2
      @size.times do |x|
        combo << @gameboard[x][y]
        y -= 1
      end
      combos << combo
      combos
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
      each_cell do |x, y|

      end
    end
  end
end