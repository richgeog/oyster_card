class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 2

  attr_reader :balance, :current_journey, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
    reset_current_journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !entry_station.nil?
  end

  def touch_in(entry_station)
    fail "You don't have enough money" if balance < MINIMUM_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    save_journey_history
    @entry_station = nil
    deduct(MINIMUM_CHARGE)
  end

  def entry_station
    current_journey[:entry_station]
  end

  def exit_station
    current_journey[:exit_station]
  end

  private

  attr_writer :balance, :journey_history, :current_journey
  attr_accessor :in_journey

  def deduct(amount)
    @balance -= amount
  end

  def save_journey_history
    journey_history << current_journey
    reset_current_journey
  end

  def reset_current_journey
    @current_journey = {entry_station: nil, exit_station: nil}
  end

  def entry_station=(station)
    current_journey[:entry_station] = station
  end

  def exit_station=(station)
    current_journey[:exit_station] = station
  end

end

