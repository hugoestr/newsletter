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
