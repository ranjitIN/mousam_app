

import 'package:mousam_app/services/location.dart';
import 'package:mousam_app/services/networking.dart';

class WeatherModel {
  final String apiKey = '5f5b5775a5300c9a4752861513c5d398';

  Future getwatherByCity(String city_name) async {
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$city_name&appid=$apiKey&units=metric');
    var weatherreport = await networkhelper.getWeatherData();
    return weatherreport;
  }

  Future getWeatherReport() async {
    // getting the location using Location class that uses a geolocter package
    Location location = Location();
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;
    //get weather report according the location
    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherreport = await networkhelper.getWeatherData();

    return weatherreport;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
