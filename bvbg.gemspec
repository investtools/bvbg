
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bvbg/version"

Gem::Specification.new do |spec|
  spec.name          = "bvbg"
  spec.version       = Bvbg::VERSION
  spec.authors       = ["Pedro Aguiar dos Santos"]
  spec.email         = ["desenvolvimento@investtools.com.br"]

  spec.summary       = %q{Gem for reading Bovespa BVBG files}
  spec.homepage      = "https://github.com/investtools/bvbg.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier"
  spec.add_dependency "saxerator"
  spec.add_dependency "ox"
end
