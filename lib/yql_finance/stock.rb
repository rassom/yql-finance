require 'yql_finance/base'

module YQLFinance
  class StockQuery < YQLFinance::Base
    def find_by_symbol(symbol_or_array)
      return nil if symbol_or_array.nil?

      if symbol_or_array.is_a? String
        search_symbols = [symbol_or_array]
      else
        search_symbols = symbol_or_array
      end

      search_text = "'#{search_symbols.join("','")}'"
      execute("select * from yahoo.finance.quotes where symbol in (#{search_text})")
    end

    def parse_result(http_body)
      return nil if http_body.nil?
      result_hash = JSON.parse(http_body)
      stock_results = []

      #if result_hash['query'] && result_hash['query']['results'] && result_hash['query']['results']['optionsChain']
      #  if result_hash['query']['results']['optionsChain'].is_a?(Array)
      #    result_hash['query']['results']['optionsChain'].each do |option_data|
      #
      #      option_results << Option.new(option_data['option'])
      #    end
      #  else
      #    option_results << Option.new(result_hash['query']['results']['optionsChain']['option'])
      #  end
      #
      #end
      #
      stock_results
    end
  end

  class Stock
    # "symbol":"YHOO","Ask":null,"AverageDailyVolume":"21769300","Bid":"18.35","AskRealtime":"0.00","BidRealtime":"18.35","BookValue":"13.121",
    # "Change_PercentChange":"+0.17 - +0.92%","Change":"+0.17","Commission":null,"ChangeRealtime":"+0.17","AfterHoursChangeRealtime":"N/A - N/A",
    #"DividendShare":"0.00","LastTradeDate":"11/23/2012","TradeDate":null,"EarningsShare":"3.246","ErrorIndicationreturnedforsymbolchangedinvalid":null,
    #"EPSEstimateCurrentYear":"1.15","EPSEstimateNextYear":"1.16","EPSEstimateNextQuarter":"0.26",
    #"DaysLow":"18.40","DaysHigh":"18.59","YearLow":"14.35","YearHigh":"18.59","HoldingsGainPercent":"- - -","AnnualizedGain":null,
    #"HoldingsGain":null,"HoldingsGainPercentRealtime":"N/A - N/A","HoldingsGainRealtime":null,"MoreInfo":"cn","OrderBookRealtime":null,
    #"MarketCapitalization":"21.963B","MarketCapRealtime":null,"EBITDA":"1.321B","ChangeFromYearLow":"+4.22","PercentChangeFromYearLow":"+29.41%"
    #,"LastTradeRealtimeWithTime":"N/A - <b>18.57</b>","ChangePercentRealtime":"N/A - +0.92%","ChangeFromYearHigh":"-0.02","PercebtChangeFromYearHigh":"-0.11%",
    #"LastTradeWithTime":"Nov 23 - <b>18.57</b>","LastTradePriceOnly":"18.57","HighLimit":null,"LowLimit":null,"DaysRange":"18.40 - 18.59",
    #"DaysRangeRealtime":"N/A - N/A","FiftydayMovingAverage":"16.8985","TwoHundreddayMovingAverage":"15.8226",
    #"ChangeFromTwoHundreddayMovingAverage":"+2.7474","PercentChangeFromTwoHundreddayMovingAverage":"+17.36%",
    #"ChangeFromFiftydayMovingAverage":"+1.6715","PercentChangeFromFiftydayMovingAverage":"+9.89%","Name":"Yahoo! Inc.","Notes":null,
    #"Open":"18.49","PreviousClose":"18.40","PricePaid":null,"ChangeinPercent":"+0.92%","PriceSales":"4.38","PriceBook":"1.40","ExDividendDate":null,
    #"PERatio":"5.67","DividendPayDate":null,"PERatioRealtime":null,"PEGRatio":"1.44","PriceEPSEstimateCurrentYear":"16.00","PriceEPSEstimateNextYear":"15.86",
    #"Symbol":"YHOO","SharesOwned":null,"ShortRatio":"1.20","LastTradeTime":"1:00pm","TickerTrend":"&nbsp;======&nbsp;",
    #"OneyrTargetPrice":"18.78","Volume":"7714732","HoldingsValue":null,"HoldingsValueRealtime":null,
    #"YearRange":"14.35 - 18.59","DaysValueChange":"- - +0.92%","DaysValueChangeRealtime":"N/A - N/A","StockExchange":"NasdaqNM",
    #"DividendYield":null,"PercentChange":"+0.92%"
    attr_accessor :symbol, :ask, :average_daily_volume, :bid, :ask_real_time, :bid_real_time, :book_value,
        :change_in_percent_change, :change, :commission, :change_real_time, :after_hours_change_real_time,
        :dividend_share, :last_trade_date, :trade_date, :earnings_per_share, :eps_estimate_current_year, :eps_estimate_next_year, :eps_estimate_next_quarter,
        :days_low, :days_high, :year_low, :year_high, :holdings_gain_percent, :annualized_gain,
        :holdings_gain, :holdings_gain_percent_real_time, :more_info, :order_book_real_time,
        :market_cap, :market_cap_real_time, :ebitda, :change_from_year_low, :percent_change_from_year_low,
        :last_trade_real_time_with_time, :change_percent_real_time, :change_from_year_high, :percent_change_from_year_high,
        :last_trade_with_time, :last_trade_price_only, :high_limit, :low_limit, :days_range,
        :days_range_real_time, :fifty_day_moving_average, :two_hundred_day_moving_average, :change_from_two_hundred_day_moving_average,
        :percent_change_from_two_hundred_day_moving_average, :change_from_fifty_day_moving_average, :percent_change_from_fifty_day_moving_average,
        :name, :notes, :open, :previous_close, :price_paid, :change_in_percent, :price_sales, :price_book, :ex_dividend_date,
        :pe_ratio, :dividend_pay_date, :pe_ratio_realtime, :peg_ratio, :price_eps_estimate_current_year, :price_eps_estimate_next_year,
        :shares_owned, :short_ratio, :last_trade_time, :ticker_trend, :one_year_target_price, :volume, :holdings_value, :holdings_value_real_time,
        :year_range, :days_value_change, :days_value_change_real_time, :dividend_yield, :percent_change
    def initialize(hash_data=nil)
      unless hash_data.nil?

      end
    end
  end
end

#stock_query = YQLFinance::Stock.new
#r = stock_query.find_by_symbol(["MSFT","YHOO"])
#puts r
