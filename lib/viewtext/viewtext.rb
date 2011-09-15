require 'faraday'
require 'sanitize'
require 'json'
require 'ostruct'

class ViewTextResponse < OpenStruct
  def content
    Sanitize.clean(super)
  end
end

class ViewText
  def initialize(target_url)
    @target_url = target_url
  end

  def viewtext_url
    "http://viewtext.org/api/text?url=#{@target_url}&format=json"
  end

  def fetch
    response = fetch_data
    body_json = JSON.parse(response.body)
    ViewTextResponse.new(body_json)
  end

  def fetch_data
    conn = connection(viewtext_url)
    begin
      data = conn.get
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
