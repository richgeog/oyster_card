require 'oystercard'

describe Oystercard do

   subject(:oystercard) { described_class.new }

    it 'has a balance of zero' do
      expect(oystercard.balance).to eq(0)
    end

    it 'is initially not in a journey' do
      expect(oystercard).to_not be_in_journey
    end

    it 'holds an empty journey log' do
      expect(oystercard.journey_history).to eq([])
    end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect{ oystercard.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#touch_in & out' do
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }
    let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

    context 'with sufficent money' do

       before do
         oystercard.top_up(20)
       end

      xit 'remembers the touch_in station' do
        oystercard.touch_in(entry_station)
        expect(oystercard.entry_station).to eq(:entry_station)
      end

      xit 'remembers the touch_out' do
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
        expect(oystercard.exit_station).to eq(:exit_station)
      end

      xit 'is an active journey once touch_in' do
        oystercard.touch_in(entry_station)
        expect(oystercard).to be_in_journey
      end

      it 'stores the exit station' do
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
        expect(oystercard).to_not be_in_journey
      end

      it 'deducts the journey from the card on touch_out' do
        oystercard.touch_in(entry_station)
        expect{ oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
      end

      xit 'stores a journey' do
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
        expect(oystercard.journey_history).to include(journey)
      end
    end

    context 'without sufficent money' do

      it 'will not touch in if below the minimum balance' do
        oystercard.top_up(0)
        expect{ oystercard.touch_in(entry_station) }.to raise_error "You don't have enough money"
      end
    end
  end
end
