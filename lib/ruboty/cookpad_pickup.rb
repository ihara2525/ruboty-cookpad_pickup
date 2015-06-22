require 'open-uri'
require 'nokogiri'

module Ruboty
  module Handlers
    class CookpadPickup < Base
      on /cookpad_pickup/i, name: 'cookpad_pickup', description: "COOKPAD today's pickup recipe"

      def cookpad_pickup(message)
        charset = nil
        html = open('http://cookpad.com') do |f|
          charset = f.charset
          f.read
        end

        doc = Nokogiri::HTML.parse(html, nil, charset)

        pickup_url = 'http://cookpad.com' + doc.css('.pickup_recipe').first['href']

        message.reply pickup_url
      end
    end
  end
end
