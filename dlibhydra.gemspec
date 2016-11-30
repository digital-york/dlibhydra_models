# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dlibhydra/version'

Gem::Specification.new do |spec|
  spec.name          = 'dlibhydra'
  spec.version       = Dlibhydra::VERSION
  spec.authors       = ['Julie Allinson']
  spec.email         = ['julie.allinson@york.ac.uk']

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = 'Models for York Digital Library and related projects'
  spec.description   = 'Using this gem will provide various re-usable data models designed for York Digital Library.'
  spec.homepage      = 'https://github.com/digital-york/dlibhydra'
  spec.license       = 'APACHE2'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib app)

  spec.add_dependency 'hydra-works' # , '~> 0.9'
  spec.add_dependency 'active_fedora-noid' # , '~> 1.1.0'
  spec.add_dependency 'active-fedora'
  
  spec.add_dependency 'curation_concerns'
  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rspec-rails', '~> 3.1'
  spec.add_development_dependency 'factory_girl_rails' # , :require => false
end
