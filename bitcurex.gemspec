# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitcurex/version'

Gem::Specification.new do |gem|
  gem.name          = "bitcurex"
  gem.version       = Bitcurex::VERSION
  gem.authors       = ["Adrian Dulić", "Michał Ciemięga"]
  gem.email         = ["adulic@gmail.com"]
  gem.description   = %q{Bitcurex API}
  gem.summary       = %q{Bitcurex API}
  gem.homepage      = "https://github.com/adriandulic/bitcurex"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'oj', '~> 2.5.5'
  gem.add_dependency 'httparty', '~> 0.13.1'

  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'rspec', '~> 3.0.0'
end
