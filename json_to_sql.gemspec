Gem::Specification.new do |s|
  s.name                  = 'json_to_sql'
  s.version               = '0.1.0'
  s.platform              = Gem::Platform::RUBY
  s.summary               = 'copy JSON file into an SQL table and vice-versa'
  s.description           = 'Insert key/values from .json into SQL table where Column name = key, or save table rows into a JSON formatted file'
  s.authors               = ['Alexander Rose']
  s.homepage              = 'http://github.com/rosealexander/json-to-sql'
  s.license               = 'MIT'
  s.required_ruby_version = '>=3.1'
  s.files                 = Dir.glob('{lib,bin}/**/*')
  s.require_path          = 'lib'
  s.executables           = ['json_to_sql']
end
