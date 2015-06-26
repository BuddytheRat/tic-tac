class TicTac
  class Player
    attr_reader :name, :symbol
    @@players = []
    def initialize(name, symbol)
      @@players << self
      @name = name
      @symbol = symbol

      @winning_combos = Array.new
    end

    def choose
      choice = gets.chomp
      
      choice
    end

    def self.all
      @@players
    end

    def self.current
      @@players[0]
    end
  end
end