# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/droonga/version'

Gem::Specification.new do |gem|
  gem.name          = "itamae-plugin-recipe-droonga"
  gem.version       = Itamae::Plugin::Recipe::Droonga::VERSION
  gem.summary       = %q{TODO: Summary}
  gem.description   = %q{TODO: Description}
  gem.license       = "LGPL"
  gem.authors       = ["KITAITI Makoto"]
  gem.email         = "KitaitiMakoto@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/itamae-plugin-recipe-droonga"

  gem.files         = `git ls-files`.split($/)

  `git submodule --quiet foreach --recursive pwd`.split($/).each do |submodule|
    submodule.sub!("#{Dir.pwd}/",'')

    Dir.chdir(submodule) do
      `git ls-files`.split($/).map do |subpath|
        gem.files << File.join(submodule,subpath)
      end
    end
  end
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
end
