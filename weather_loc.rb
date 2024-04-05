require "http"
require "json"

def weather_loc (city_name)
  loc_api = ENV["GMAPS_KEY"]
  loc_base_url = "https://maps.googleapis.com/maps/api/geocode/json?"
  resp_loc = HTTP.get("#{loc_base_url}address=#{city_name}&key=#{loc_api}")

  loc_geom = JSON.parse(resp_loc)["results"][0]["geometry"]["location"]
  lat = loc_geom["lat"]
  lng = loc_geom["lng"]

  puts "Your coordinates are #{lat}, #{lng}\n"

  weather_api =  ENV["PIRATE_KEY"]
  weather_base_url = "https://api.pirateweather.net/forecast/"
  resp_weather = HTTP.get("#{weather_base_url}#{weather_api}/#{lat},#{lng}")

  curr_temp = JSON.parse(resp_weather.to_s)["currently"]["temperature"]

  puts "It is currently: #{curr_temp} Fahrenheit"
  
end

dashes = "=" * 10 + "\n"
title = "Will you need an umbrella today\n"
prompt = "Where are you?"

puts dashes + title + dashes
puts prompt
user_place = gets.chomp
puts "Checking the weather at #{user_place}..."
weather_loc(user_place)
