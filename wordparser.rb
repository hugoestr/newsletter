require 'json'
require './TokenParser.rb'

# It should parse with the right encoding
# parser returns newsletter structure
# a translater turns it into yaml

def get_text(file)
  f = File.open file, "r"
  lines = f.readlines
  lines[0]
end

def parse(file)
  text = get_text file
  word_document = JSON.parse text
end

file = ARGV[0]
parse file
