import 'dart:ffi';

import 'package:get/get.dart';
import 'package:weather/data/location_data.dart';
import 'package:weather/data/weather_data.dart';
import 'package:weather/repository/weather_repository.dart';

class HomeController extends GetxController {
  final WeatherRepository _repository = Get.put(WeatherRepository());
  Rxn<LocationData> locationData = Rxn();
  Rxn<WeatherData> weatherData = Rxn();
  RxString infoText = "...".obs;

  String get address =>
      "${locationData.value?.regionName}, ${locationData.value?.country}";

  String get temperature => "${weatherData.value?.temp}";
  getCurrentLocation() async {
    LocationData? location = await _repository.getCurrentLocation();
    print(location?.regionName);
    locationData.value = location;
  }

  getTemperatureForCurrentLocation() async {
    if (locationData.value != null) {
      weatherData.value =
          await _repository.getWeatherForLocation(locationData.value!);

      _getInfoText(weatherData.value?.temp);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getCurrentLocation();
    await getTemperatureForCurrentLocation();
  }

  void _getInfoText(int? temperature) {
    if (temperature == null) {
      infoText.value = "Unknown";
    } else if (temperature <= 0) {
      infoText.value = "Make sure to dress in warm Clothes";
    } else if (temperature <= 15) {
      infoText.value = "Put on a jacket";
    } else {
      infoText.value = "Savor the Weather";
    }
  }
}
