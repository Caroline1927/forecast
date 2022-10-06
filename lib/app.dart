import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:forecast/api/weather_week_api.dart';
import 'package:forecast/screens/main_page.dart';
import 'package:forecast/screens/offline_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
    ),
    home: AnimatedSplashScreen(
    splash: 'assets/forecast_logo.png',
    splashIconSize: 180,
    nextScreen: OfflineBuilder(
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        final bool connected = connectivity != ConnectivityResult.none;
        // fetchWeatherForWeek();
        return connected ? MainPage() :OfflineScreen();
      },
      child: Container(),
    ),
    splashTransition: SplashTransition.sizeTransition,
    duration: 3000,
    ));
  }
}