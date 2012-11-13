require 'yql_finance/util'

module YQLFinance
  class Option < YQLFinance::Base
    def find_by_underlying(symbol_or_array)
      return nil if symbol_or_array.nil?

      if symbol_or_array.is_a? String
        search_symbols = [symbol_or_array]
      else
        search_symbols = symbol_or_array
      end

      search_text = "'#{search_symbols.join("','")}'"
      execute("select option from yahoo.finance.options where symbol in (#{search_text})")
    end
  end
end

#stock_query = YQLFinance::Option.new
#r = stock_query.find_by_underlying(["MSFT"])
#puts r


#require 'net/http'
#require 'uri'
#require 'cgi'
#require 'json'
#
#def path_with_params(page, params)
#  return page if params.empty?
#  page + "?" + params.map {|k,v|
#CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }.join("&")
#end
#
#finance_base = "query.yahooapis.com"
#
#params = {"q" => "select option from yahoo.finance.options where symbol in ('MSFT') and expiration='2012-11' and option.type='C'",
#          "format" => "json",
#          "env" => "store://datatables.org/alltableswithkeys",
#          #"env" => "http://datatables.org/alltables.env",
#          "diagnostics" => "true"}
#
#full_path = path_with_params("/v1/public/yql", params)
#
#response = Net::HTTP::start(finance_base) do | http_request |
#  http_request.get(full_path)
#end
#
#puts ">>> "
#request_hash = JSON.parse(response.body)
#
#puts "request_hash: #{request_hash.class}"

#request_hash["query"]["results"]["quote"].each_pair do |k,v|
#  puts "k #{k}"
#  puts "---"
#  puts "    v #{v}"
#end