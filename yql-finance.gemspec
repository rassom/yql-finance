# -*- encoding: utf-8 -*-
require File.expand_path('../lib/yql_finance/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "yql-finance"
  gem.version       = YQLFinance::VERSION
  gem.authors       = ["Shaun OConnell"]
  gem.email         = ["shaun@codescratch.com"]
  gem.description   = "YQL Finance library to query the API"
  gem.summary       = gem.description
  gem.homepage      = "http://codescratch.github.com/yql-finance/"
  gem.licenses      = ["MIT"]

  gem.files        = Dir['LICENSE', 'README.md', 'lib/**/*', 'spec/**/*']
  gem.require_path = 'lib'

  gem.add_development_dependency 'rspec'

end