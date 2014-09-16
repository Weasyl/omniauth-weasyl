# -*- mode: ruby; coding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = "omniauth-weasyl"
  gem.version = "0.1"
  gem.authors = ["weykent"]
  gem.email = ["weykent@weasyl.com"]
  gem.description = %q{A Weasyl strategy for OmniAuth.}
  gem.summary = %q{A Weasyl strategy for OmniAuth.}
  gem.homepage = "https://github.com/Weasyl/omniauth-weasyl"
  gem.license = "ISC"

  gem.files = `git ls-files`.split($/)
  gem.executables = []
  gem.test_files = []
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'omniauth', '~> 1.0'
  gem.add_runtime_dependency 'omniauth-oauth2'
end
