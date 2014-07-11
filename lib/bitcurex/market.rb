module Bitcurex
  class Market
    class << self
      def orderbook(cur = nil)
        res = market(cur).get("/orderbook.json")
        {
          :bids => res.fetch(:bids).map { |b| [b[0].to_f, b[1].to_f] }.sort_by { |b| b[0] }.reverse,
          :asks => res.fetch(:asks).map { |a| [a[0].to_f, a[1].to_f] }.sort_by { |b| b[0] }
        }
      end

      def trades(cur = nil)
        res = market(cur).get("/trades.json")
        res.map do |trade|
          trade.tap { |t|
            t.store('date', Time.at(t.fetch('date')))
            t.store('price', Float(t.fetch('price')))
            t.store('amount', Float(t.fetch('amount')))
            t.store('type', Bitcurex::TYPES.fetch(t.fetch('type')))
          }
        end.sort_by { |t| t.fetch('date') }.reverse
      end

      def ticker(cur = nil)
        market(cur).get("/ticker.json").tap { |t|
          t.store(:time, Time.at(t.fetch(:time)))
        }
      end

      private

        def market(cur)
          API::Market.const_get(cur || Bitcurex::PLN)
        end
    end
  end
end
