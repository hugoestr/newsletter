require_relative '../TokenParser'

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
