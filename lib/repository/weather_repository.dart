import 'dart:convert';

import 'package:convert/convert.dart' as convert;
import 'package:get/get_connect/http/src/response/response.dart';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather/data/location_data.dart';
import 'package:weather/data/weather_data.dart';

class WeatherRepository {
  final apiKey = "82cf3e607c66ea7ef15fde3cb6019720";

  Future<LocationData?> getCurrentLocation() async {
    LocationData? locationData;
    final url = Uri.http('ip-api.com', '/json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      locationData = LocationData.fromJson(jsonResponse);
      print('Request succesful: $jsonResponse');
      return locationData;
    } else {
      print("Request failed with status: ${response.statusCode}");
      return locationData;
    }
  }

  Future<WeatherData?> getWeatherForLocation(LocationData location) async {
    WeatherData? weather;

    final params = {
      'lat': location.lat.toString(),
      'lon': location.lon.toString(),
      'city': location.regionName,
      'appId': apiKey,
    };
    final url = Uri.http('api.openweathermap.org', '/data/2.5/weather', params);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      weather = WeatherData.fromJson(jsonResponse);
      return weather;
    } else {
      log("Request Failed with Status: ${response.statusCode}");
      return weather;
    }
  }
}
