# -*- encoding: utf-8 -*-

require File.expand_path('../lib/ruby_info', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "ruby_info"
  gem.version       = RubyInfo::VERSION
  gem.summary       = 'Adds the RubyInfo pseudo-constant.'
  gem.description   = 'Provides a RubyInfo class that simplifies accessing global information. Run RubyInfo.list to get started.'
  gem.license       = "MIT"
  gem.authors       = ["Jan Lelis"]
  gem.email         = ["hi@ruby.consulting"]
  gem.homepage      = "https://github.com/janlelis/ruby_info"

  gem.files         = Dir['{**/}{.*,*}'].select { |path| File.file?(path) }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake', '~> 13.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
