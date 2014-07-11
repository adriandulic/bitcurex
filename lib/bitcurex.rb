require "bitcurex/version"
require "httparty"
require "oj"

module Bitcurex
  autoload :API, 'bitcurex/api'
  autoload :Market, 'bitcurex/market'
  autoload :Account, 'bitcurex/account'

  ASK = 1
  BID = 2
  PLN = 'PLN'
  EUR = 'EUR'
  BTC = 'BTC'
  TYPES = { 1 => 'ASK', 2 => 'BID' }

  class << self
    attr_accessor :key, :secret, :verbose

    def configure(options = {})
      options.each { |k,v| send("#{k}=", v) if respond_to?(k) }
    end

    def configured?
      !!(key && secret)
    end

    def verbose?
      !!verbose
    end
  end
end
