require 'station'

describe Station do

  subject(:station) { described_class.new("Watford", 1) }

  it 'has a name' do
    expect(station.name).to eq "Watford"
  end

  it 'has a zone number' do
    expect(station.zone).to eq 1
  end

end
