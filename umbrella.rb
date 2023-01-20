require("open-uri")
require("json")


line_width = 40

puts "*"*line_width
puts "Umbrella, sire?".center(line_width)
puts "Where are you right now?".center(line_width)
puts "*"*line_width

#------------------------------------- Grab User Location -------------------------------------#
user_location = gets.chomp
#------------------------------------------------ End ------------------------------------------#


#------------------------------------- Find Latitude and Longitude -------------------------------------#

#Using Google Maps API to determine L&L of user location
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"

#Reading JSON file
raw_data = URI.open(gmaps_url).read
parsed_data = JSON.parse(raw_data)

#Traveling through the Grapevine 
results_array = parsed_data.fetch("results")
only_result = results_array[0]
geo = only_result.fetch("geometry")
loc = geo.fetch("location")

#latitude and longitude
latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

#------------------------------------------------ End ---------------------------------------------------#



#------------------------------------- Find Weather -------------------------------------#

#Using Google Maps API to determine L&L of user location
darksky_url = "https://api.darksky.net/forecast/71174c5d293588d2f0ba4c0c7448bcfb/#{latitude},#{longitude}"

#Reading JSON file
weather_data = URI.open(darksky_url).read
parsed_weather_data = JSON.parse(weather_data)

# Traveling through the Grapevine for Current Temp
weather = parsed_weather_data.fetch("currently")
temperature = weather.fetch("temperature")

# Traveling through the Grapevine for Weather for Next Hour
weather_next_hour = parsed_weather_data.fetch("minutely")
next_hour = weather_next_hour.fetch("summary")

#------------------------------------------------ End ------------------------------------#


#------------------------------------- Summary -------------------------------------#
p "Checking the weather at #{user_location}...."
p "Your coordinates are #{latitude}, #{longitude}"
p "It is currently #{temperature}°F."
p "Next hour: #{next_hour}"
#---------------------------------------- End ---------------------------------------#


#------------------------------------- Hourly Forecast -------------------------------------#

#data for hourly weather
weather_hourly_data = parsed_weather_data.fetch("hourly")
hourly_weather = weather_hourly_data.fetch("data")

hour = 1
count = 0

while (hour <= 12)
  hour_data = hourly_weather[hour]
  precip_chance = (hour_data.fetch("precipProbability") * 100).to_i
   if(precip_chance > 10)
    p "In #{hour} hours, there is a #{precip_chance}% of precipitation"
    count += 1
   end
   hour += 1
end

#------------------------------------------- End -------------------------------------------#

#------------------------------------- Under my Umbrella, ella, ella -------------------------------------#
if (count == 0)
  p "You probably won't need an umbrella"
elsif
  p "You probably should ask Rihanna to borrow something (aka her umbrella)"
end
#------------------------------------------------- End ---------------------------------------------------#
