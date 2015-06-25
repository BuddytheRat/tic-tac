$LOAD_PATH.unshift(File.dirname(__FILE__))

class TicTac
  require 'tictac/board'
  require 'tictac/player'
  require 'tictac/computer'

  def initialize;
    @player1 = Player.new("BuddytheRat", "X")
    @player2 = Player.new("Kihara", "O")
    @alert_stack = []
    new_game
  end

  def new_game
    @gameboard = Board.new(3, 3)
    @current_player = decide_start_player(@player1, @player2)
    main_loop
  end

  private
  def decide_start_player(player1, player2)
    return [player1, player2].shuffle
    alert("#{@current_player[0].name} is the starting player!")
  end

  def next_player
    @current_player << @current_player.shift
    alert("#{@current_player[0].name}'s turn!")
  end

  def ask_for_next_move
    symbol = @current_player[0].symbol
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
    @current_player[0].choose
  end

  def alert(alert)
    @alert_stack << alert
  end

  def display_alerts
      puts @alert_stack
      @alert_stack.clear
  end

  def game_over?; end

  def main_loop
    while !(game_over?)
      system('cls')
      @gameboard.display
      display_alerts
      choice = ask_for_next_move
      case choice
        when /\d/
          @gameboard.add_symbol(choice, @current_player[0].symbol)
        when /quit/i
          resign
        when 'invalid'
          alert("Whoops! That's not quite right, #{@current_player[0].name}. Try again!")
          redo
      end
      next_player
    end
  end
end

game = TicTac.new