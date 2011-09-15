require 'test/unit'
require 'viewtext'
require 'webmock/test_unit'
require 'mocha'

class TestViewText < Test::Unit::TestCase
  def setup
    WebMock.disable_net_connect!
  end

  def test_viewtext_url
    vt = ViewText.new('http://google.com')
    assert_equal 'http://viewtext.org/api/text?url=http://google.com&format=json', vt.viewtext_url
  end

  def test_connection
    vt = ViewText.new('http://google.com')
    assert vt.connection('http://google.com').is_a?(Faraday::Connection)
  end

  def test_fetch_data
    stub_request(:get, 'http://viewtext.org/api/text?url=http://google.com&format=json')

    vt = ViewText.new('http://google.com')
    vt.fetch_data

    assert_requested :get, 'http://viewtext.org/api/text?url=http://google.com&format=json'
  end

  def test_fetch
    vt = ViewText.new('http://google.com')
    mock_response = mock()
    mock_response.stubs(:body).returns({:foo => 'bar'}.to_json)

    vt.expects(:fetch_data).returns(mock_response)

    data = vt.fetch

    assert_equal 'bar', data.foo
    assert data.is_a?(ViewTextResponse)
  end
end
