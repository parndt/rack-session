# frozen_string_literal: true

require_relative 'lib/rack/session/version'

Gem::Specification.new do |spec|
  spec.name = "rack-session"
  spec.version = Rack::Session::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.author = "Rack Contributors"
  spec.summary = "A session implementation for Rack."
  spec.license = "MIT"

  spec.files = Dir.glob('{lib}/**/*', base: __dir__) + ["LICENSE.md"]

  spec.require_path = 'lib'

  spec.homepage = 'https://github.com/rack/rack-session'

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_dependency "rack", ">= 3.0.0.beta1"

  spec.add_development_dependency 'minitest', "~> 5.0"
  spec.add_development_dependency 'minitest-sprint'
  spec.add_development_dependency 'minitest-global_expectations'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
