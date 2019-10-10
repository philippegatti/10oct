require_relative '../lib/00_dark_trader'

describe "dark_trader" do
    it "should return the main cryptocurrencies" do
        expect(perform().to_a.size.to_i).to be >1000
        expect(perform()[0]).to include ("BTC")
    end
	it "should return an array" do
      expect(perform()).to be_a_kind_of(Array)
  	end
end