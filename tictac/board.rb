class TicTac
  class Board
    def initialize(size)
      @border = {
        padding: ' ',
        top: '=',
        side: '!',
        corner: '-',
        underline: ' ',
        pad: ' '
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
      row1_4 = "#{@border[:corner]}#{@border[:top] * ((@size * 4) - 1)}#{@border[:corner]}\n"
      row2_3 = ((@border[:side] + (@border[:underline] * 3)) * @size) + @border[:side] + "\n"
      each_row do |row|
        print row1_4
        print row2_3
        row.each_with_index do |cell, y|
          if (cell.is_a?(Integer))
            cell = cell.to_s.rjust(3, "0")
          else
            cell = cell.center(3, @border[:pad])
          end
          print @border[:side] + cell
          print @border[:side] + "\n" if y == @size - 1
        end
        print row2_3
      end
      print row1_4
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

    def is_draw?
      draw = false
      draw = true if empty_spaces == []
      draw
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
  end
end