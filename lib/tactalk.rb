require 'yaml'
require 'words_counted'
require 'tokenizer'
require 'fuzzy_tools'
require 'ruby-tf-idf'
require 'lingua/stemmer'
require 'pragmatic_segmenter'

require 'net/http'
require 'uri'
require 'json'
require 'sanitize'

class TacTalk

  def initialize
    @docs = []
    @questions = []

    @struct = Struct.new(:question, :answer, :method)
  end

  def add_question_document doc
    parsed = begin
      YAML.load(File.open(doc))
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
    end

    @docs = @docs | parsed
    @questions = @docs.map { |doc| @struct.new(doc["question"],doc["answer"], doc['method']) }
  end

  def ask question
    doc = @questions.fuzzy_find(:question => question)

    return doc["answer"] if doc["method"].nil?

    klass = Object.const_get doc['method']
    klass = klass.new doc
    klass.run

  end
end
