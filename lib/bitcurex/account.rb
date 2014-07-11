module Bitcurex
  class Account
    attr_accessor :key, :secret, :params, :headers

    def self.setup(params = {})
      new(params[:key] || Bitcurex.key, params[:secret] || Bitcurex.secret)
    end

    def initialize(key, secret)
      @key, @secret = key, secret
      @params = { :nonce => nonce }
      @headers = { 'Rest-Key' => @key }
    end

    def balance
      send('/getFunds')
    end

    def orders
      send('/getOrders')
    end

    def transactions
      send('/getTransactions')
    end

    def bid(amount, price)
      send('/buyBTC', :amount => amount, :price => price)
    end

    def ask(amount, price)
      send('/sellBTC', :amount => amount, :price => price)
    end

    def cancel(oid, type = Bitcurex::ASK)
      send('/cancelOrder', :oid => oid, :type => type)
    end

    def withdraw(type, amount)
      send('/withdraw', :type => type, :amount => amount)
    end

    def address
      { :address => balance.fetch(:address) }
    end

    private

      def send(path, params = {})
        @params = @params.merge(params)
        @headers = @headers.merge({ 'Rest-Sign' => signature })
        API::Account.post(path, { :body => @params, :headers => @headers })
      end

      def nonce
        (t = Time.now; t.to_i.to_s + t.usec.to_s)
      end

      def signature
        Base64.strict_encode64(hash_hmac)
      end

      def hash_hmac
        OpenSSL::HMAC.digest('sha512', decoded_secret, encoded_params)
      end

      def encoded_params
        URI.encode_www_form(@params)
      end

      def decoded_secret
        Base64.decode64(@secret)
      end
  end
end
