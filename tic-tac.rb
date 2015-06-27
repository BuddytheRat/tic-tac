$LOAD_PATH.unshift(File.dirname(__FILE__))

class TicTac
  require 'tictac/board'
  require 'tictac/player'
  require 'tictac/computer'

  def initialize;
    Player.new("BuddytheRat", "B")
    Computer.new("Kihara", "K")
    Computer.new("Buttface", "W")
    @alert_stack = Array.new
    new_game
  end

  def new_game
    @gameboard = Board.new(5)
    Player.all.each { |player| player.winning_combos = @gameboard.winning_combos }
    decide_turn_order
    alert("#{Player.current.name} is the starting player!")
    game_loop
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
    query("Where will you place an #{Player.current.symbol}?", @gameboard.empty_spaces)
  end

  def query(question, options);
    puts question
    print "Choose: "
    options.each_with_index do |option, i|
      print "#{option.to_s}"
      print ", " unless i == options.size-1
    end
    print "\n"
    Player.current.choose(options)
  end

  def alert(alert)
    @alert_stack << alert
  end

  def display_alerts
    puts @alert_stack
    @alert_stack.clear
  end

  def refresh_screen
    system('cls')
    @gameboard.display
    display_alerts
  end

  def game_loop
    loop do
      refresh_screen
      if Player.current.has_won?
        alert("#{Player.current.name} is the winner!")
        break
      end

      choice = ask_for_next_move
      case
        when choice.is_a?(Integer)
          @gameboard.add_symbol(choice, Player.current.symbol)
          Player.current.update_combos(choice)
        else
          alert("Whoops! That's not quite right, #{Player.current.name}. Try again!")
          redo
      end

      next_player unless Player.current.has_won?
    end
    refresh_screen
  end
end

game = TicTac.new