$LOAD_PATH.unshift(File.dirname(__FILE__))

class TicTac
  require 'tictac/board'
  require 'tictac/player'
  require 'tictac/computer'

  def initialize;
    Player.new("BuddytheRat", "X")
    Player.new("Kihara", "O")
    Player.new("Buttface", "W")
    @alert_stack = Array.new
    new_game
  end

  def new_game
    @gameboard = Board.new(3, 3)
    decide_turn_order
    alert("#{Player.current.name} is the starting player!")
    main_loop
  end

  private
  def decide_turn_order()
    Player.all.shuffle!
  end

  def next_player
    Player.all << Player.all.shift
    alert("#{Player.current.name}'s turn!")
  end

  def ask_for_next_move
    symbol = Player.current.symbol
    query("Where will you place an #{symbol}?", @gameboard.empty_spaces)
  end

  def query(question, options);
    puts question
    print "Choose: "
    options.each_with_index do |option, i|
      print "#{option}"
      print ", " unless i == options.size-1
    end
    print "\n"
    Player.current.choose
  end

  def alert(alert)
    @alert_stack << alert
  end

  def display_alerts
    puts @alert_stack
    @alert_stack.clear
  end

  def game_over?
    #Check for win conditions
  end

  def main_loop
    while !(game_over?)
      system('cls')
      @gameboard.display
      display_alerts
      choice = ask_for_next_move

      case choice
        when /\d/ #Cell
          @gameboard.add_symbol(choice, Player.current.symbol)
        when :quit #Quit
          resign
        when :invalid #Invalid
          alert("Whoops! That's not quite right, #{Player.current.name}. Try again!")
          redo
      end
      next_player
    end
  end
end

game = TicTac.new