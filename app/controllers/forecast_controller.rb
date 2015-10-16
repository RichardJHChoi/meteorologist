require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url="https://api.forecast.io/forecast/4ff32fffe9acf236b67dffbae36a5cbd/#{@lat},#{@lng}"
    raw_data=open(url).read
    require 'JSON'
    parsed_data=JSON.parse(raw_data)

    currently=parsed_data["currently"]
    @current_temperature = currently["temperature"]
    @current_summary = currently["summary"]

    
    minutely=parsed_data["minutely"]
    @summary_of_next_sixty_minutes = minutely["summary"]

    hourly=parsed_data["hourly"]
    @summary_of_next_several_hours = hourly["summary"]

    daily=parsed_data["daily"]
    @summary_of_next_several_days = daily["summary"]

    render("coords_to_weather.html.erb")
  end
end
