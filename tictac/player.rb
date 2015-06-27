class TicTac
  class Player
    attr_reader :name, :symbol
    attr_accessor :winning_combos
    @@players = Array.new

    def initialize(name, symbol)
      @@players << self
      @name = name
      @symbol = symbol

      @win = false
      @winning_combos = Array.new
    end

    def choose(options)
      choice = gets.chomp.to_i
      choice = "invalid" if options.none? { |option| option == choice }
      choice
    end

    def update_combos(move)
      @winning_combos.each do |combo|
        combo.delete_if { |i| i == move }
        @win = true if combo.empty?
      end
    end

    def has_won?
      @win
    end

    private

    def self.all
      @@players
    end

    def self.current
      @@players[0]
    end
  end
end