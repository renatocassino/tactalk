require 'yaml'
require 'words_counted'
require 'tokenizer'
require 'fuzzy_tools'
require 'ruby-tf-idf'
require 'lingua/stemmer'
require 'pragmatic_segmenter'

# require 'net/http'
# require 'uri'
# require 'json'
# require 'sanitize'

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

    # doc['method'].constantize.new doc
    klass = Object.const_get doc['method']
    klass = klass.new doc
    klass.run

  end

  def get_wikipedia_page page
    url = "http://en.wikipedia.org/w/api.php?format=json&action=parse&page=#{page}"
    content = Net::HTTP.get(URI.parse(url))

    result = JSON.load content
    Sanitize.fragment result['parse']['text']['*']
  end

  # def distance(str1, str2)
  #   return str2.length if str1.empty?
  #   return str1.length if str2.empty?
  #
  #   return distance(str1[1..-1], str2[1..-1]) if str1[0] == str2[0] # match
  #   l1 = distance(str1, str2[1..-1])          # deletion
  #   l2 = distance(str1[1..-1], str2)          # insertion
  #   l3 = distance(str1[1..-1], str2[1..-1])   # substitution
  #   return 1 + [l1,l2,l3].min                 # increment cost
  # end

end
