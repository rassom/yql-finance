require "spec_helper"

describe YQLFinance::StockQuery do

  before(:each) do
    @yql_stock = YQLFinance::StockQuery.new
  end

  it "should find a valid symbol" do
    yhoo_stock_info = @yql_stock.find_by_symbol "YHOO"
    yhoo_stock_info.should_not be_nil

    #puts ">>" * 10
    #puts yhoo_stock_info.class
    #puts "** DATA"
    #puts yhoo_stock_info.inspect
    #puts "  BODY "
    puts yhoo_stock_info.body

  end

  it "should find multiple stocks given an array of symbols" do
    stock_info = @yql_stock.find_by_symbol ["YHOO", "GOOG"]
    stock_info.should_not be_nil

    #puts ">>" * 10
    #puts yhoo_stock_info.class
    #puts "** DATA"
    #puts yhoo_stock_info.inspect
    #puts "  BODY "
    #puts stock_info.body

  end
end