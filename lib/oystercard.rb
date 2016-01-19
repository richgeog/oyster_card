class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 2

  attr_reader :balance 
  attr_accessor :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    in_journey
  end

  def touch_in
    fail "You don't have enough money" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

