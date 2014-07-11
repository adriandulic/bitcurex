module Bitcurex
  module API
    class Base
      include HTTParty
      headers 'User-Agent' => "Mozilla/4.0 (compatible; Bitcurex ruby client; #{RUBY_PLATFORM}; ruby/#{RUBY_VERSION})"
      default_timeout 30
      debug_output $stdout if Bitcurex.verbose?

      class OjParser < HTTParty::Parser
        def parse
          processed = Oj.load(body)
          processed.is_a?(Hash) ? symbolize_keys(processed) : processed
        end

        private

          def symbolize_keys(hash)
            hash.inject({}) do |options, (key, value)|
              options[(key.to_sym rescue key) || key] = value
              options
            end
          end
      end

      parser(OjParser)
    end

    module Market
      class EUR < Base
        base_uri 'https://bitcurex.com/data'
      end

      class PLN < Base
        base_uri 'https://pln.bitcurex.com/data'
      end
    end

    class Account < Base
      base_uri 'https://pln.bitcurex.com/api/0'
    end
  end
end
