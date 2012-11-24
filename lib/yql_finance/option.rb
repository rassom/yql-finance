require 'yql_finance/base'
require 'date'
require 'bigdecimal'
require 'json'

module YQLFinance
  class OptionQuery < YQLFinance::Base

    # stock_query = YQLFinance::OptionQuery.new
    # r = stock_query.find_by_underlying(["MSFT"])
    # puts r
    def find_by_underlying(symbol_or_array, expiration=nil, type=nil)
      return nil if symbol_or_array.nil?

      if symbol_or_array.is_a? String
        search_symbols = [symbol_or_array]
      else
        search_symbols = symbol_or_array
      end

      search_text = "'#{search_symbols.join("','")}'"
      yql_string = "select option from yahoo.finance.options where symbol in (#{search_text})"

      if expiration
        yql_string = "#{yql_string} and expiration = '#{expiration}'"
      end
      if type
        yql_string = "#{yql_string} and type = '#{type}'"
      end

      http_response = execute(yql_string)
      parse_result(http_response.body)
    end

    def find_by_symbol(symbol_or_array)
      return nil if symbol_or_array.nil?

      if symbol_or_array.is_a? String
        search_symbols = [symbol_or_array]
      else
        search_symbols = symbol_or_array
      end

      underlying_array = []
      search_symbols.each do |symbol|
        option = Option.create_from symbol
        underlying_array << option.underlying_symbol
      end

      search_text = "'#{search_symbols.join("','")}'"
      underlying_text = "'#{underlying_array.join("','")}'"
      http_response = execute("select option from yahoo.finance.options where symbol in (#{underlying_text}) and option.symbol in (#{search_text})")
      parse_result(http_response.body)
    end

    def parse_result(http_body)
      return nil if http_body.nil?
      result_hash = JSON.parse(http_body)
      option_results = []

      if result_hash['query'] && result_hash['query']['results'] && result_hash['query']['results']['optionsChain']
        if result_hash['query']['results']['optionsChain'].is_a?(Array)
          result_hash['query']['results']['optionsChain'].each do |option_data|

            option_results << Option.new(option_data['option'])
          end
        else
          option_results << Option.new(result_hash['query']['results']['optionsChain']['option'])
        end

      end

      option_results
    end
  end

  class Option
    attr_accessor :symbol, :underlying_symbol, :expiration_date, :type, :strike_price, :last_price, :change, :change_direction, :bid, :ask, :volume, :open_interest

    def initialize(hash_data=nil)
      if hash_data
        prototype_option = Option.create_from(hash_data['symbol'])
        unless prototype_option.nil?
          @symbol = prototype_option.symbol
          @underlying_symbol = prototype_option.underlying_symbol
          @expiration_date = prototype_option.expiration_date
          @type = prototype_option.type
          @strike_price = prototype_option.strike_price
        end

        @last_price = BigDecimal.new(hash_data['lastPrice']) unless hash_data['lastPrice'].nil?
        @change = BigDecimal.new(hash_data['change']) unless hash_data['change'].nil?
        @change_direction = BigDecimal.new(hash_data['changeDir']) unless hash_data['changeDir'].nil?
        @bid = BigDecimal.new(hash_data['bid']) unless hash_data['bid'].nil?
        @ask = BigDecimal.new(hash_data['ask']) unless hash_data['ask'].nil?
        @volume = hash_data['vol'].to_i unless hash_data['vol'].nil?
        @open_interest = hash_data['openInt'].to_i unless hash_data['openInt'].nil?

      end
    end

    class << self
      def create_from(symbol)
        return nil if symbol.nil?

        option = Option.new
        option.symbol = symbol
        option.underlying_symbol=""

        symbol.upcase!

        symbol.each_char do |char|
          if (!Option.numeric?(char))
            option.underlying_symbol << char
          else
            break
          end
        end

        symbol_remainder = symbol[option.underlying_symbol.length..symbol.length]

        year = "20#{symbol_remainder[0..1]}"
        month = symbol_remainder[2..3]
        day = symbol_remainder[4..5]

        option.expiration_date = Date.parse("#{year}-#{month}-#{day}")
        option.type = symbol_remainder[6]

        strike_price_whole_number_string = symbol_remainder[7..11]
        strike_price_decimal_number_string = symbol_remainder[12..symbol_remainder.length]

        option.strike_price = BigDecimal.new("#{strike_price_whole_number_string}.#{strike_price_decimal_number_string}")

        option
      end

      def numeric? val
        val.match(/[^0-9]/).nil?
      end
    end
  end
end
