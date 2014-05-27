# KOSapi Client

[![Build Status](http://img.shields.io/travis/flexik/kosapi_client.svg)][travis]
[![Dependency Status](http://img.shields.io/gemnasium/flexik/kosapi_client.svg)][gemnasium]
[![Code Climate](http://img.shields.io/codeclimate/github/flexik/kosapi_client.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/codeclimate/coverage/github/flexik/kosapi_client.svg)][codeclimate]
[![Inline docs](http://inch-pages.github.io/github/flexik/kosapi_client.svg)](http://inch-pages.github.io/github/flexik/kosapi_client)

[travis]: http://travis-ci.org/flexik/kosapi_client
[gemnasium]: https://gemnasium.com/flexik/kosapi_client
[codeclimate]: https://codeclimate.com/github/flexik/kosapi_client

A simple Ruby client library for [KOSapi RESTful service](https://kosapi.fit.cvut.cz).

## Installation

Add this line to your application's Gemfile:

    gem 'kosapi_client', github: 'flexik/kosapi_client'

And then execute:

    $ bundle

## Basic usage

```ruby
# Creates a new instance of client with OAuth2 credentials
client = KOSapiClient.new(OAUTH_CLIENT_ID, OAUTH_SECRET)

# Retrieves first page of all course events
course_events_page = client.course_events
course_events_page.each { |event| do_stuff_with_event(event) }

# Fetches page of parallels according to API parameters
parallels_page = client.parallels.offset(0).limit(50).query('course.department' => '18*')

# Finds all parallels related to parallel with id = 42
client.parallels.find(42).related
```

## Configuration

KOSapiClient can be created and configured in two ways.
The simple way is to call `KOSapiClient.new`, which returns ApiClient instance.

```ruby
client = KOSapiClient.new(OAUTH_CLIENT_ID, OAUTH_SECRET)
client.parallels.find(42)
```
    
The other way is to use configure client using `KOSapiClient.configure` and setting options inside block.
In addition to returning the client instance from `configure`, the client is also stored in `KOSapiClient` singleton property and its methods can be accessed by calling them on `KOSapiClient` directly.
This approach is more suitable for configuring client inside an initializer. 
 
```ruby
KOSapiClient.configure do |c|
  c.client_id = ENV['KOSAPI_OAUTH_CLIENT_ID']
  c.client_secret = ENV['KOSAPI_OAUTH_CLIENT_SECRET']
end

KOSapiClient.parallels.find(42)
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
