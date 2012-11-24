require 'net/http'
require 'uri'
require 'cgi'

module YQLFinance
  class Base
    DEFAULT_BASE_URL = "query.yahooapis.com"
    DEFAULT_PATH_URL = "/v1/public/yql"
    DEFAULT_ENV = "http://datatables.org/alltables.env"
    DEFAULT_FORMAT = "json"

    def initialize(params={})
      @params = {"format"=>DEFAULT_FORMAT,"env"=>DEFAULT_ENV,"diagnostics"=>false}
      @params.merge!(params)

    end

    def execute(yql_query)
      @params["q"] = yql_query
      full_path = construct_url_path(DEFAULT_PATH_URL,@params)
      response = Net::HTTP::start(DEFAULT_BASE_URL) do |http_request|
        http_request.get(full_path)
      end
      response
    end

    private
    def construct_url_path(path_url, params)
      return path_url if params.empty?
      path_url + "?" + params.map { |k, v| CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }.join("&")
    end
  end
end