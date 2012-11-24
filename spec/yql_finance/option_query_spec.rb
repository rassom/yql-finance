require "spec_helper"

describe YQLFinance::OptionQuery do

  before(:each) do
    @yql_option = YQLFinance::OptionQuery.new()
  end

  it "should find a valid underlying" do
    #yhoo_stock_info = @yql_option.find_by_underlying "MSFT", "2012-11-30"
    yhoo_stock_info = @yql_option.find_by_underlying "MSFT"
    #yhoo_stock_info = @yql_option.find_by_underlying "MSFT", "2013-01"
    yhoo_stock_info.should_not be_nil

    #puts ">>" * 10
    #yhoo_stock_info.each do | opt |
    #  puts opt.symbol
    #  puts opt.underlying_symbol
    #end
    #puts yhoo_stock_info.class
    #puts "** DATA"
    #puts yhoo_stock_info.inspect
    #puts "  BODY "
    #puts yhoo_stock_info.inspect

  end

  it "should find exact option by symbol" do
    #yhoo_stock_info = @yql_option.find_by_symbol "YHOO121222P00016000"
    #yhoo_stock_info.should_not be_nil
    #
    #puts ">>" * 10
    #puts yhoo_stock_info.class
    #puts "** DATA"
    #puts yhoo_stock_info.inspect
    #puts "  BODY "
    #puts yhoo_stock_info.inspect
  end

end