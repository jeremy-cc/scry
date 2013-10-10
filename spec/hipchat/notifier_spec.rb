require 'spec_helper'

describe 'Hipchat Notifier' do

  let(:config) {
    {
        :host=>'test.host',
        :api_key=>'test.key',
        :room_id=>'test.room',
        :colours => {
            :info=>'green',
            :none=>'gray',
            :warning=>'yellow',
            :error=>'red'
        }
    }
  }

  let(:error_message) {
    {
        'color'=>'red',
        'message' => 'test',
        'notify' => true,
        'message_format' => 'text',
    }
  }

  let(:warning_message) {
    {
        'color'=>'yellow',
        'message' => 'test',
        'notify' => true,
        'message_format' => 'text',
    }
  }

  let(:info_message) {
    {
        'color'=>'green',
        'message' => 'test',
        'notify' => false,
        'message_format' => 'text',
    }
  }

  let(:subject) {
    Scry::Hipchat::Notifier.new(config)
  }

  it 'constructs a post request and executes it against the specified endpoint' do
    http = mock('HTTP').as_null_object
    post = mock('Post').as_null_object

    Net::HTTP.should_receive(:new).and_return(http)
    Net::HTTP::Post.should_receive(:new).and_return(post)

    post.should_receive(:add_field).with('Content-Type', 'application/json')
    post.should_receive(:body=).with(info_message.to_json)

    http.should_receive(:request).with(post).and_return(Net::HTTPNoContent.new('1.1', 204, 'ok'))

    subject.post_to_endpoint(info_message)
  end

  it 'raises an exception if the post request does not get a HTTP 204 response' do
    http = mock('HTTP').as_null_object
    post = mock('Post').as_null_object

    Net::HTTP.should_receive(:new).and_return(http)
    Net::HTTP::Post.should_receive(:new).and_return(post)

    post.should_receive(:add_field).with('Content-Type', 'application/json')
    post.should_receive(:body=).with(info_message.to_json)

    http.should_receive(:request).with(post).and_return(Net::HTTPUnauthorized.new('1.1', 402, 'unauthorised'))

    lambda { subject.post_to_endpoint(info_message) }.should raise_error
  end

  it 'sends an info message to a remote endpoint when requested' do
    http = mock('HTTP').as_null_object
    post = mock('Post').as_null_object

    Net::HTTP.should_receive(:new).and_return(http)
    Net::HTTP::Post.should_receive(:new).and_return(post)

    post.should_receive(:add_field).with('Content-Type', 'application/json')
    post.should_receive(:body=).with(info_message.to_json)

    http.should_receive(:request).with(post).and_return(Net::HTTPNoContent.new('1.1', 204, 'ok'))

    subject.info 'test'
  end

  it 'sends an warning message to a remote endpoint when requested' do
    http = mock('HTTP').as_null_object
    post = mock('Post').as_null_object

    Net::HTTP.should_receive(:new).and_return(http)
    Net::HTTP::Post.should_receive(:new).and_return(post)

    post.should_receive(:add_field).with('Content-Type', 'application/json')
    post.should_receive(:body=).with(warning_message.to_json)

    http.should_receive(:request).with(post).and_return(Net::HTTPNoContent.new('1.1', 204, 'ok'))

    subject.warning 'test'
  end

  it 'sends an error message to a remote endpoint when requested' do
    http = mock('HTTP').as_null_object
    post = mock('Post').as_null_object

    Net::HTTP.should_receive(:new).and_return(http)
    Net::HTTP::Post.should_receive(:new).and_return(post)

    post.should_receive(:add_field).with('Content-Type', 'application/json')
    post.should_receive(:body=).with(error_message.to_json)

    http.should_receive(:request).with(post).and_return(Net::HTTPNoContent.new('1.1', 204, 'ok'))

    subject.error 'test'
  end
end