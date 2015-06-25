class TicTac
  class Player
    attr_reader :name, :symbol
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
    def choose
      choice = gets.chomp
      # verify choice is valid (is one of available numbers)
      # choice = choose() if (invalid)
      choice
    end
  end
end