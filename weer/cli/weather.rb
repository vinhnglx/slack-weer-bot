module Weer
  module CLI
    class Weather < SlackRubyBot::Commands::Base
      match /^[w|W]eather in (?<location>.*)$/ do |client, data, match|
        city = match[:location]
        results = ''

        wetter = Wetter.new(city)
        response = wetter.connect

        client.say(channel: data.channel, text: "Looks like your city is not right! :wink: ", gif: 'wink') if response['query']['results'].nil?

        unless response['query']['results'].nil?
          forecast = wetter.forecast response
          wind = wetter.wind response
          atmosphere = wetter.atmosphere response

          results << "The forecast of #{city.upcase!} in the next coming days\n"
          results << wetter.parse_forecast(forecast).render
          results << "\n"*2

          results << "The wind power of #{Date.today.to_s}\n"
          results << wetter.parse_wind(wind).render
          results << "\n"*2

          results << "The atmosphere of #{Date.today.to_s}\n"
          results << wetter.parse_atmosphere(atmosphere).render

          client.say(channel: data.channel, text: "```#{results}```", gif: 'have a nice day')
        end
      end
    end
  end
end
