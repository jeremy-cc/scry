# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scry/version"
Gem::Specification.new do |s|
  s.name        = "scry"
  s.version     = Scry::VERSION
  s.authors     = ["Jeremy Botha"]
  s.email       = ["jeremy.botha@thecurrencycloud.com"]
  s.homepage    = "https://github.com/jeremy-cc/scry"
  s.summary     = %q{Generic notification integration library}
  s.description = %q{A lightweight gem providing integration onto hipchat}
  s.has_rdoc  =   false

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"

  s.add_dependency('httparty', '= 0.10.2')
  s.add_dependency('json', '= 1.7.3')
end