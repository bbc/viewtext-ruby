Gem::Specification.new do |s|
  s.name = %q{viewtext}
  s.version = "0.0.1"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Lowis", "Duncan Robertson"]
  s.date = %q{2011-05-25}
  s.description = <<-EOT
Wrapper for the Viewtext API
EOT
  s.email = %q{chris.lowis@bbc.co.uk}
  s.files = Dir["lib/**/*"]
  s.has_rdoc = false
  s.homepage = %q{}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{viewtext}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{}

  s.add_dependency 'sanitize'
  s.add_dependency 'faraday-stack'
  s.add_dependency 'json'
end
