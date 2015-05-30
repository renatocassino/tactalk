Gem::Specification.new do |s|
  s.name        = 'TacTalk'
  s.version     = '0.0.0'
  s.date        = '2015-05-30'
  s.summary     = "Simple tool to create your Question Answer with methods."
  s.description = "....."
  s.authors     = ["Tacnoman"]
  s.email       = 'renatocassino@gmail.com'
  s.files       = ["lib/tactalk.rb", "lib/action.rb"]
  s.homepage    =
    'https://github.com/tacnoman/tactalk'
  s.license = 'MIT'

  s.add_dependency "words_counted"
  s.add_dependency "tokenizer"
  s.add_dependency "fuzzy_tools"
  s.add_dependency "ruby-tf-idf"
  s.add_dependency "ruby-stemmer"
  s.add_dependency "pragmatic_segmenter"

  s.add_dependency "sanitize"
end
