require 'oystercard'

describe Oystercard do
 
  describe '#balance' do 
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top us the balance' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end
  end
end

