// import 'package:flutter/material.dart';
// import 'package:forecast/api/weather_week_api.dart';
//
// import 'package:google_fonts/google_fonts.dart';
// import 'package:video_player/video_player.dart';
//
// import 'api/weather_daily_api.dart';
// import 'widgets/bottom_widget.dart';
// import 'models/weather_daily_model.dart';
// import 'models/weather_week_model.dart';
// import 'utils/location_functionality.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late VideoPlayerController _controller;
//
//   late VideoPlayerController _controller1;
//
//   late Future<WeatherToday> futureWeather;
//   // late Future<Weather5Days> futureWeatherWeek;
//
//   @override
//   void initState() {
//     super.initState();
//
//     futureWeather = fetchWeather();
//     // futureWeatherWeek = fetchWeatherForWeek();
//     _controller = VideoPlayerController.asset("assets/windy_cloud.mp4")
//       ..initialize().then((_) {
//         _controller.play();
//         _controller.setLooping(true);
//       });
//     _controller1 = VideoPlayerController.asset("assets/rain.mp4")
//       ..initialize().then((_) {
//         _controller.play();
//         _controller.setLooping(true);
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//       });
//
//     setState(() {
//       // futureWeather = fetchWeather();
//       serviceEn();
//       permissGranted();
//       // fetchWeatherForWeek();
//       // getCurrentLocation();
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.1,
//           bottom: MediaQuery.of(context).size.height * 0.02,
//         ),
//         child: Stack(
//           children: [
//             // Padding(
//             //   padding: EdgeInsets.symmetric(
//             //       vertical: MediaQuery.of(context).size.height * 0.17),
//             //   child: FittedBox(
//             //     // If your background video doesn't look right, try changing the BoxFit property.
//             //     // BoxFit.fill created the look I was going for.
//             //     fit: BoxFit.fill,
//             //     child: SizedBox(
//             //       width: MediaQuery.of(context).size.width * 1,
//             //       height: MediaQuery.of(context).size.width * 1,
//             //       child: FutureBuilder<Weather>(
//             //         future: futureWeather,
//             //         builder: (context, snapshot) {
//             //           if (snapshot.hasData) {
//             //             print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
//             //             print(snapshot.data!.description[0]["description"]);
//             //             // return VideoPlayer(snapshot.data!.description[0]["description"]== "clear sky"?_controller:_controller1);
//             //
//             //             return VideoPlayer(_controller);
//             //           } else if (snapshot.hasError) {
//             //             print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
//             //             return Text('${snapshot.error}');
//             //           }
//             //
//             //           // By default, show a loading spinner.
//             //           return Container();
//             //         },
//             //       ),
//             //
//             //
//             //
//             //     ),
//             //   ),
//             // ),
//
//             // Padding(
//             //   padding: EdgeInsets.symmetric(horizontal: 10),
//             //   child: Align(
//             //     alignment: Alignment.topLeft,
//             //     child: FutureBuilder<Weather>(
//             //       future: futureWeather,
//             //       builder: (context, snapshot) {
//             //         if (snapshot.hasData) {
//             //           // print(snapshot.data!.temperature);
//             //           return Text(
//             //             "${snapshot.data!.temperature!.toInt()}\u2103",
//             //             style: GoogleFonts.openSans(
//             //               fontSize: 64,
//             //               color: Colors.indigoAccent,
//             //             ),
//             //           );
//             //         } else if (snapshot.hasError) {
//             //           print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
//             //           return Text('${snapshot.error}');
//             //         }
//             //
//             //         print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
//             //         // print("${snapshot.data!.tomorrow}\u2103");
//             //         // By default, show a loading spinner.
//             //         return const CircularProgressIndicator();
//             //       },
//             //     ),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: EdgeInsets.symmetric(horizontal: 10),
//             //   child: Align(
//             //     alignment: Alignment.topLeft,
//             //     child: Text(
//             //       "18\u2103",
//             //       style: GoogleFonts.openSans(
//             //         fontSize: 64,
//             //         color: Colors.indigoAccent,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             // Positioned(
//             //   top: MediaQuery.of(context).size.height * 0.12,
//             //   // left: MediaQuery.of(context).size.height * 0.021,
//             //   child: Padding(
//             //     padding: const EdgeInsets.symmetric(horizontal: 15),
//             //     child: Align(
//             //       alignment: Alignment.topLeft,
//             //       child: FutureBuilder<Weather>(
//             //         future: futureWeather,
//             //         builder: (context, snapshot) {
//             //           if (snapshot.hasData) {
//             //             print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
//             //             print(snapshot.data!.description[0]["description"]);
//             //             return Text("${snapshot.data!.description[0]["description"]}",
//             //                 style: GoogleFonts.roboto(
//             //                               fontSize: 18,
//             //                               color: Colors.black45,
//             //                             ),);
//             //
//             //           } else if (snapshot.hasError) {
//             //             print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
//             //             return Text('${snapshot.error}');
//             //           }
//             //
//             //           // By default, show a loading spinner.
//             //           return const CircularProgressIndicator();
//             //         },
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             // Positioned(
//             //     top: MediaQuery.of(context).size.height * 0.12,
//             //     // left: MediaQuery.of(context).size.height * 0.021,
//             //     child: Padding(
//             //       padding: const EdgeInsets.symmetric(horizontal: 15),
//             //       child: Align(
//             //         alignment: Alignment.topLeft,
//             //         child: Text(
//             //           "Rainy day",
//             //           style: GoogleFonts.roboto(
//             //             fontSize: 18,
//             //             color: Colors.black45,
//             //           ),
//             //         ),
//             //       ),
//             //     )),
//             // Padding(
//             //   padding: EdgeInsets.only(
//             //       top: MediaQuery.of(context).size.height * 0.035,
//             //       right: MediaQuery.of(context).size.height * 0.021),
//             //   child: Align(
//             //     alignment: Alignment.topRight,
//             //     child: FutureBuilder<Weather>(
//             //       future: futureWeather,
//             //       builder: (context, snapshot) {
//             //         if (snapshot.hasData) {
//             //           print(snapshot.data!.temperature);
//             //           return Text(
//             //             "${snapshot.data!.humidity}%",
//             //               style: GoogleFonts.roboto(
//             //                         fontSize: 24,
//             //                         color: Colors.black45,
//             //                       ),
//             //           );
//             //         } else if (snapshot.hasError) {
//             //           print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
//             //           return Text('${snapshot.error}');
//             //         }
//             //
//             //         // By default, show a loading spinner.
//             //         return const CircularProgressIndicator();
//             //       },
//             //     ),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: EdgeInsets.only(
//             //       top: MediaQuery.of(context).size.height * 0.035,
//             //       right: MediaQuery.of(context).size.height * 0.021),
//             //   child: Align(
//             //     alignment: Alignment.topRight,
//             //     child: Text(
//             //       "50%",
//             //       style: GoogleFonts.roboto(
//             //         fontSize: 24,
//             //         color: Colors.black45,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(top: 150),
//             //   child: FutureBuilder<WeatherToday>(
//             //     future: futureWeather,
//             //     builder: (context, snapshot) {
//             //       if (snapshot.hasData) {
//             //         print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBb");
//             //         print(snapshot.data?.name);
//             //         var tom =snapshot.data?.name;
//             //             // "${snapshot.data?.common_list?[8]["dt_txt"].toString().substring(5, 7)}.${snapshot.data?.common_list?[8]["dt_txt"].toString().substring(8, 11)}";
//             //         return Text(
//             //           "$tom",
//             //           style: GoogleFonts.roboto(
//             //             fontSize: 12,
//             //             color: Colors.black45,
//             //           ),
//             //         );
//             //       } else if (snapshot.hasError) {
//             //         print("ERRRRROOOOOOOOOOOOOOOOOORRRR");
//             //         return Text(
//             //             '${snapshot.error}');
//             //       }
//             //       // print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
//             //       // print(snapshot.data!.city!.name);
//             //       return const CircularProgressIndicator();
//             //     },
//             //   ),
//             // ),
//             // Padding(
//             //   padding: EdgeInsets.only(
//             //       top: MediaQuery.of(context).size.height * 0.07,
//             //       right: MediaQuery.of(context).size.height * 0.021),
//             //   child: Align(
//             //     alignment: Alignment.topRight,
//             //     child: FutureBuilder<Weather5Days>(
//             //       future: futureWeatherWeek,
//             //       builder: (context, snapshot) {
//             //         if (snapshot.hasData) {
//             //           var bob = snapshot.data?.city?.name;
//             //           return Text(
//             //             "${bob} km/h",
//             //             style: GoogleFonts.roboto(
//             //               fontSize: 18,
//             //               color: Colors.black45,
//             //             ),
//             //           );
//             //         } else if (snapshot.hasError) {
//             //           print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
//             //           return Text('${snapshot.error}');
//             //         }
//             //
//             //         print("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
//             //         // print(snapshot.data?.weather?[0]==null?55:snapshot.data!.weather?[0]);
//             //         // By default, show a loading spinner.
//             //         return const CircularProgressIndicator();
//             //       },
//             //     ),
//             //   ),
//             // ),
//             // Padding(
//             //     padding: EdgeInsets.only(
//             //         top: MediaQuery.of(context).size.height * 0.07,
//             //         right: MediaQuery.of(context).size.height * 0.021),
//             //     child: Align(
//             //       alignment: Alignment.topRight,
//             //       child: Text(
//             //         "9 km/h",
//             //         style: GoogleFonts.roboto(
//             //           fontSize: 18,
//             //           color: Colors.black45,
//             //         ),
//             //       ),
//             //     )),
//             // Padding(
//             //   padding: EdgeInsets.only(
//             //     top: MediaQuery.of(context).size.height * 0.17,
//             //   ),
//             //   child: Align(
//             //     alignment: Alignment.topCenter,
//             //     child: FutureBuilder<Weather5Days>(
//             //       future: futureWeatherWeek,
//             //       builder: (context, snapshot) {
//             //         if (snapshot.hasData) {
//             //
//             //           return Text(
//             //             (snapshot.data!.city!.name).toString(),
//             //             style: GoogleFonts.roboto(
//             //               fontSize: 28,
//             //               color: Colors.black45,
//             //             ),
//             //           );
//             //         } else if (snapshot.hasError) {
//             //           print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
//             //           return Text('${snapshot.error}');
//             //         }
//             //         print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPCCCCCCCCCCCCCCCCCCCCCCc");
//             //
//             //         print(snapshot.data!.city);
//             //         // By default, show a loading spinner.
//             //         return const CircularProgressIndicator();
//             //       },
//             //     ),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: EdgeInsets.only(
//             //     top: MediaQuery.of(context).size.height * 0.17,
//             //   ),
//             //   child: Align(
//             //       alignment: Alignment.topCenter,
//             //       child: Text("Slupsk", style: GoogleFonts.roboto(
//             //         fontSize: 28,
//             //         color: Colors.black45,
//             //       ),)),
//             // ),
//             Padding(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.55,
//               ),
//               child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Text(
//                     "Wednesday",
//                     style: GoogleFonts.roboto(
//                       fontSize: 28,
//                       color: Colors.black45,
//                     ),
//                   )),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.6,
//               ),
//               child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Text(
//                     "08.09.2022",
//                     style: GoogleFonts.roboto(
//                       fontSize: 14,
//                       color: Colors.black45,
//                     ),
//                   )),
//             ),
//             BottomWidget()
//           ],
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
