class WeatherData {
  int? temp;

  WeatherData({this.temp});

  WeatherData.fromJson(dynamic json) {
    var tempInKelvin = json['main']['temp'];
    temp = (tempInKelvin - 273.15).round();
  }
}