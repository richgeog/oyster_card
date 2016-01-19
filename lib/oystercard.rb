class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 2

  attr_reader :balance, :entry_station 
  attr_accessor :in_journey

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !entry_station.nil?
  end

  def touch_in(station)
    fail "You don't have enough money" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  private

  attr_writer :entry_station
  
  def deduct(amount)
    @balance -= amount
  end

end

