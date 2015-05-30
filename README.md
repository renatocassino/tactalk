# TacTalk
Gem to create a chatterbot with simple scripts. Can run in console, web or desktop applications.

Depends of:

Simple NLP with algorithms:

- Segmenter: https://github.com/diasks2/pragmatic_segmenter
- Stemmer: https://github.com/aurelian/ruby-stemmer
- Tokenize: https://github.com/arbox/tokenizer
- WordCount: https://github.com/abitdodgy/words_counted
- TF-IDF: https://github.com/mathieuripert/ruby-tf-idf
- Similarity: https://github.com/brianhempel/fuzzy_tools

# Instalation

```ruby
gem install TacTalk
```

## How to use

You can create a chatterbot with this lib and the usage is very simple.
First, you need create a YAML file with theese params:

```yaml
- question: Who is the most richest man in the world?
  answer: Bill Gates.
- question: What is the more expensive car?
  answer: McLaren P1 GTR and cost $3.3M.
- question: What is the most popular programming language in 2015?
  answer: C, by Tiobe.
- question: Good night
  answer: Good night!
```

Now, you can ask for TacTalk:

```ruby
require 'tactalk'

tac = TacTalk.new
tac.add_question_document  "/path/to/file.yaml"
tac.ask "Who is the richest guy?"

# -> Bill Gates.
```

## How call a method with a question?

In our example, create this method:

```ruby
require 'net/http'
require 'uri'
require 'json'
require 'sanitize'

class GetWikipediaPage

  def initialize doc
    @doc = doc
  end

  # This method will called by TacTalk
  def run
    url = "http://en.wikipedia.org/w/api.php?format=json&action=parse&page=china"
    content = Net::HTTP.get(URI.parse(url))

    result = JSON.load content
    Sanitize.fragment result['parse']['text']['*']
  end
end
```

Now, you must add a question and call the param `method` in question YAML file.

Ex:

```yaml
.
.
.
- question: China in wikipedia
  method: GetWikipediaPage
```