import 'dart:convert';

import 'package:weather_app/model/hourly_forecast_model%20.dart';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final int currentPressure;
  final double currentWindSpeed;
  final int currentHumidity;
  final List<HourlyForecast> hourlyForecasts;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecasts,
  });

  // Factory method to create WeatherModel from API response
  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];

    return WeatherModel(
      currentTemp: (currentWeatherData['main']['temp'] as num).toDouble(),
      currentSky: currentWeatherData['weather'][0]['main'] as String,
      currentPressure: (currentWeatherData['main']['pressure'] as num).toInt(),
      currentWindSpeed: (currentWeatherData['wind']['speed'] as num).toDouble(),
      currentHumidity: (currentWeatherData['main']['humidity'] as num).toInt(),
      hourlyForecasts: List<HourlyForecast>.from(map['list'].map((forecast) {
        return HourlyForecast(
          time: DateTime.parse(forecast['dt_txt']),
          temperature: (forecast['main']['temp'] as num).toDouble(),
          weatherCondition: forecast['weather'][0]['main'] as String,
        );
      })),
    );
  }

  // Method to convert WeatherModel to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
    };
  }

  // Method to convert WeatherModel to JSON
  String toJson() => json.encode(toMap());

  // Factory method to create WeatherModel from JSON
  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Override toString() for better representation
  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity)';
  }

  // Override equality and hashCode for comparison
  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode;
  }
}
