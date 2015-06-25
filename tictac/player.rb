class TicTac
  class Player
    attr_reader :name, :symbol
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
    def choose
      choice = gets.chomp
      
      choice
    end
  end
end