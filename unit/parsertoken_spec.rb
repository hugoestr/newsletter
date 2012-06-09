class Entry
  attr_accessor :title, :paragraphs

  def initialize()
    @paragraphs = []
  end
end

class Newsletter
  attr_accessor :articles
  
  def initialize()
    @articles = []
  end
end

#at the point where I can start implementing the new algorithm
class TokenParser
  def parse(tokens)
    result = newsletter tokens
  end

  # return article if found, otherwise nil
  def article(tokens)
    candidate = match_article tokens
    result = check_article_match candidate, tokens
  end

  # return newsletter if found, otherwise nil
  def newsletter(tokens)
    entries = find_articles tokens
    result = create_newsletter entries
  end

  private

  def check_article_match(candidate, tokens)
    if candidate.paragraphs.length == 0
      tokens.unshift candidate.title
      candidate = nil
    end
    candidate
  end

  def match_article(tokens)
    candidate = Entry.new
    candidate.title = tokens.shift
    
    while  tokens.length > 0 
      paragraph = tokens.shift

      if candidate.title[:size] > paragraph[:size]
        candidate.paragraphs << paragraph
      else
        tokens.unshift paragraph 
        break
      end
    end
  
    candidate
  end

  def find_articles(tokens)
    entries = []
    
    while tokens.length > 0 
      entry = article(tokens)

      if entry != nil
        entries << entry
      else
        break
      end
    end
    
    entries
  end

  def create_newsletter(entries)
    if entries.length <= 0
      result = nil
    else
      result = Newsletter.new
      result.articles = entries
    end
    result
  end
    
end

describe TokenParser do
  before :each do
    @input = [{:size => 12}, {:size => 10 },{:size => 10 },{:size => 12 },]
    @t = TokenParser.new
  end

  describe "parsing" do
    it "should parse the input into an article " do
      newsletter = @t.parse @input
      newsletter.articles.length.should > 0
    end

    it "should  return null when article not found" do
      newsletter = @t.parse [{:size => 15}, {:size => 15}]
      newsletter.should == nil
    end

     it "should return a newsletter with two articles" do
      newsletter = @t.parse [{:size => 15}, {:size => 10},{:size => 10},{:size => 10},{:size => 15},{:size => 10},{:size => 10},]
     newsletter.articles.length.should == 2 
    end
  end

  describe "article" do
    it "should return nil when no article found" do
      article = @t.article [{:size => 15}, {:size => 15}]
      article.should == nil
    end

    it "should return an article when it is found" do
      article = @t.article [{:size => 15}, {:size => 10}]
      article.should_not == nil
    end

    it "should return an article when it is found, many entries" do
      article = @t.article [{:size => 15}, {:size => 10},{:size => 10},{:size => 10},]
      article.should_not == nil
    end
  end

end
