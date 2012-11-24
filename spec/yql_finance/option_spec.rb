require "spec_helper"

describe YQLFinance::Option do

  before(:each) do

  end

  describe "#numeric?" do
    it "should evaluate a number as numeric" do
      10.downto(0) do |num|
        YQLFinance::Option.numeric?("#{num}").should be_true
      end

    end

    it "should evaluate an alpha as not numeric" do
      YQLFinance::Option.numeric?("a").should be_false
      YQLFinance::Option.numeric?("A").should be_false
      YQLFinance::Option.numeric?("z").should be_false
      YQLFinance::Option.numeric?("Z").should be_false
    end
  end

  it "should parse symbol and set values" do
    yahoo_option_symbol = "YHOO121222P00016000"
    yahoo_option = YQLFinance::Option.create_from(yahoo_option_symbol)

    yahoo_option.symbol.should eq("YHOO121222P00016000")
    yahoo_option.underlying_symbol.should eq("YHOO")
    yahoo_option.expiration_date.should eq(Date.parse("2012-12-22"))
    yahoo_option.type.should eq("P")
    yahoo_option.strike_price.should eq(BigDecimal.new("16.00"))

  end

  it "should parse hash and populate fields" do
    yahoo_hash = {"symbol" => "YHOO121222P00016000",
                  "type" => "P",
                  "strikePrice" => "16",
                  "lastPrice" => "0.03",
                  "change" => "0",
                  "changeDir" => nil,
                  "bid" => "0.02",
                  "ask" => "0.03",
                  "vol" => "110",
                  "openInt" => "7842"}

    yahoo_option = YQLFinance::Option.new(yahoo_hash)
    yahoo_option.symbol.should eq("YHOO121222P00016000")
    yahoo_option.underlying_symbol.should eq("YHOO")
    yahoo_option.expiration_date.should eq(Date.parse("2012-12-22"))
    yahoo_option.type.should eq("P")
    yahoo_option.strike_price.should eq(BigDecimal.new("16.00"))
    yahoo_option.last_price.should eq(BigDecimal.new("0.03"))

    yahoo_option.change.should eq(BigDecimal.new("0"))
    yahoo_option.change_direction.should be_nil
    yahoo_option.bid.should eq(BigDecimal.new("0.02"))
    yahoo_option.ask.should eq(BigDecimal.new("0.03"))
    yahoo_option.volume.should eq(110)
    yahoo_option.open_interest.should eq(7842)
  end
end