require "giant_bomb_api/exception"
require "giant_bomb_api/client"
require "giant_bomb_api/request"
require "giant_bomb_api/request/search"
require "giant_bomb_api/resource"
require "giant_bomb_api/resource/game"

module GiantBombApi

  class Configuration
    attr_accessor :api_key
  end

  class << self
    attr_accessor :configuration
  end

  def self.raise_error(message)
    raise Exception.new message
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)

    @@client = nil
  end

  def self.search(query)
    client.send_request(Request::Search.new(query))
  end

  def self.client
    raise_error "Configure GiantBombApi-module before using" if GiantBombApi.configuration.nil?
    raise_error "Configure 'api_key' first" if GiantBombApi.configuration.api_key.nil?

    @@client ||= Client.new(api_key: GiantBombApi.configuration.api_key)
  end

end