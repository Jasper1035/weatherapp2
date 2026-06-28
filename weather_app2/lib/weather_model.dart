class WeatherModel {
  final String cityName;
  final double temparature;
  final String mainCondition;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temparature,
    required this.mainCondition,
    required this.windSpeed,
  });

  factory WeatherModel.fromjson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temparature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
