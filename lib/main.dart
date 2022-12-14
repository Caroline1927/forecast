import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:forecast/api/weather_week_api.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
  CacheManager.logLevel = CacheManagerLogLevel.verbose;
  fetchWeatherForWeek();
}



