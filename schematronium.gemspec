Gem::Specification.new do |gem|
  gem.name = 'schematronium'
  gem.version = '0.1.1'
  gem.date = '2015-07-27'
  gem.summary = 'Tool for running schematron against XML strings/files'
  gem.description = 'Wraps the saxon-xslt wrapper for Saxon 9 HE, providing a simple (one function) interface for running a schematron against an XML string or file'
  gem.authors = ['Dave Mayo']
  gem.email = 'dave_mayo@harvard.edu'
  gem.platform      = 'java'
  gem.require_paths = ["lib"]

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test)/})

  gem.homepage = 'http://github.com/harvard-library/schematronium'
  gem.license = 'GPLv3'

  # Runtime dependencies
  gem.add_runtime_dependency "saxon-xslt", '~> 0.7'
  gem.add_runtime_dependency "nokogiri", '~> 1.6'

  gem.add_development_dependency "rake", '~> 10.4'
  gem.add_development_dependency "minitest"

end
