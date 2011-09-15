require 'faraday'
require 'sanitize'
require 'json'
require 'ostruct'

class ViewTextResponse < OpenStruct
end

class ViewText
  def initialize(target_url)
    @target_url = target_url
  end

  def viewtext_url
    "http://viewtext.org/api/text?url=#{@target_url}&format=json"
  end

  def fetch
    conn = connection(viewtext_url)

    begin
      response = conn.get
      data = JSON.parse(response.body)
      data["content"] = Sanitize.clean(data["content"])
      return ViewTextResponse.new(data)
    rescue Faraday::Error::ParsingError => e
      return nil
    end
  end

  def connection(url, opts={})
    if ENV['http_proxy']
      opts.merge!({ :proxy => ENV['http_proxy'] })
    end

    conn = Faraday.new(url, opts)
  end
end
