require("open-uri")
require("json")

#------------------------------------- Grab User Location -------------------------------------#
p "Where are you located?"
#user_location = gets.chomp
user_location = "Arcadia"
p user_location
#------------------------------------------------ End ------------------------------------------#



#------------------------------------- Find Latitude and Longitude -------------------------------------#

#Using Google Maps API to determine L&L of user location
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_TOKEN")}"

#Reading JSON file
raw_data = URI.open(gmaps_url).read
parsed_data = JSON.parse(raw_data)

#Traveling through the Grapevine hehe
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
darksky_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("DARK_SKY_KEY")}"

#Reading JSON file
raw_data = URI.open(gmaps_url).read
parsed_data = JSON.parse(raw_data)

#Traveling through the Grapevine hehe
results_array = parsed_data.fetch("results")
only_result = results_array[0]
geo = only_result.fetch("geometry")
loc = geo.fetch("location")
#latitude and longitude
latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

#------------------------------------------------ End ------------------------------------#

# p "Checking the weather at  " + location + "...."
p "Your coordinates are #{latitude}, #{longitude}"
# p "It is currently "
# p "Next hour "
