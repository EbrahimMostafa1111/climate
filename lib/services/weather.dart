import 'package:flutter/material.dart';
import 'package:testing/services/location.dart';
import 'package:testing/services/networking.dart';
const  apikey = 'a134c8c31b86d12f0db00d328a1229dc';
const openWeatherMapUrl='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel{
  Future getCityWeather(String cityName)async{
    NetworkHelper networkHelper= NetworkHelper(Uri.parse('$openWeatherMapUrl?q=$cityName&appid=$apikey&units=metric'));
    var weatherData= await networkHelper.getData();
    return weatherData;

  }
  Future<dynamic> getLocationWeather()async{
    //getting our location
    Location location = Location();
    await location.getCurrentLocation();
    //fetch data from api based on our current location
    NetworkHelper networkHelper=NetworkHelper(Uri.parse('$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric'));
    // weather data object
    var weatherData= await networkHelper.getData();
    return weatherData;


  }
  String getWeatherIcon(int condition) {

    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}