# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'calendar_sniper/version'

Gem::Specification.new do |spec|
  spec.name          = "calendar_sniper"
  spec.version       = CalendarSniper::VERSION
  spec.authors       = ["Chris MacNaughton", "Rob DiMarco"]
  spec.email         = ["chris@elocal.com", "rob@elocal.com"]
  spec.description   = %q{Gem that adds date related scopes to ActiveRecord models}
  spec.summary       = %q{CalendarSniper adds with_date_range, with_to_date, with_from_date, and
    in_date_range scopes to ActiveRecord models that it is included into.}
  spec.homepage      = "https://github.com/eLocal/calendar_sniper"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
