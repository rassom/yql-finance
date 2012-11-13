require 'yql_finance/util'

module YQLFinance
  class Stock < YQLFinance::Base
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
  end
end

#stock_query = YQLFinance::Stock.new
#r = stock_query.find_by_symbol(["MSFT","YHOO"])
#puts r
