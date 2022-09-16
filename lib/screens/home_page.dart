import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:forecast/models/weather_week_model.dart';
import 'package:forecast/screens/another_day_forecast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:weather_icons/weather_icons.dart';

import '../api/weather_week_api.dart';
import '../utils/location_functionality.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
int numDay = 0;
List colors = [const Color.fromRGBO(244, 173, 177, 100), const Color.fromRGBO(252, 163, 123, 100), const Color.fromRGBO(252, 194, 123, 100), const Color.fromRGBO(123, 198, 252, 100), const Color.fromRGBO(123, 183, 252, 100)];
DateTime date = DateTime.now();
String dateFormat = DateFormat('EEEE').format(date);


String dateWeekName ='';

int index = 0;
String iconNum =  '';

class _HomePageState extends State<HomePage> {


  late Future<Weather5Days> futureWeatherWeek;
  Random random = Random();
  DateTime dateWeek=DateTime.now();
  weekDaysName(int dayCount){
 dateWeek = dateWeek.add(Duration(days: dayCount));
 return dateWeek;
}
  void changeIndex() {
    setState(() => index = random.nextInt(5));
  }
  late VideoPlayerController _controller;

  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  @override
  void initState() {
    super.initState();
    futureWeatherWeek = fetchWeatherForWeek();
    _controller = VideoPlayerController.asset("assets/windy_cloud.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
      });
    _controller1 = VideoPlayerController.asset("assets/rain.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    _controller2 = VideoPlayerController.asset("assets/clouds.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    setState(() {
      serviceEn();
      permissGranted();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          // bottom: MediaQuery.of(context).size.height * 0.02,
        ),
          child: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.width * 1,
                      child: FutureBuilder<Weather5Days>(
                        future: futureWeatherWeek,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return VideoPlayer(
                                snapshot.data!.common_list![0]
                                        ["weather"][0]["description"] ==
                                    "overcast clouds" ? _controller: snapshot.data!.common_list![0]
                            ["weather"][0]["description"] ==
                                "light rain" ? _controller1:_controller2);

                            // return Text("${snapshot.data!.common_list?[0]["weather"][0]["description"]}");
                            // return VideoPlayer(_controller);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FutureBuilder<Weather5Days>(
                        future: futureWeatherWeek,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {

                            var tom =
                                "${snapshot.data?.common_list?[0]["main"]["temp"]?.toInt()}\u2103";
                            return Text(
                              tom,
                              style: GoogleFonts.openSans(
                                fontSize: 64,
                                color: Colors.indigoAccent.withOpacity(0.7),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                '${snapshot.error}${snapshot.data?.common_list}');
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.15,
                  // left: MediaQuery.of(context).size.height * 0.021,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FutureBuilder<Weather5Days>(
                        future: futureWeatherWeek,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {

                            var tom =
                                "${snapshot.data!.common_list?[0]["weather"][0]["description"]}";
                            return Text(
                              tom,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black45,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                '${snapshot.error}${snapshot.data?.common_list}');
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035,
                      right: MediaQuery.of(context).size.height * 0.03),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FutureBuilder<Weather5Days>(
                      future: futureWeatherWeek,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {

                          var tom =
                              "${snapshot.data?.common_list?[0]["main"]["humidity"]}";
                          return Text(
                            tom,
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              color: Colors.black45,
                            ),
                          );


                        } else if (snapshot.hasError) {
                          return Text(
                              '${snapshot.error}${snapshot.data?.common_list}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03,
                      right: MediaQuery.of(context).size.height * 0.08),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(WeatherIcons.humidity,color: Colors.black45,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.085,
                      right: MediaQuery.of(context).size.height * 0.13),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(WeatherIcons.cloudy_windy,color: Colors.black45,size: 20,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.09,
                      right: MediaQuery.of(context).size.height * 0.01),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text("km/h",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.09,
                      right: MediaQuery.of(context).size.height * 0.057),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FutureBuilder<Weather5Days>(
                      future: futureWeatherWeek,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var tom =
                              "${snapshot.data?.common_list?[0]["wind"]["speed"]}";
                          return Text(
                            tom,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.black45,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              '${snapshot.error}${snapshot.data?.common_list}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.035,
                //       right: MediaQuery.of(context).size.height * 0.021),
                //   child: Align(
                //     alignment: Alignment.topRight,
                //     child: FutureBuilder<Weather5Days>(
                //       future: futureWeatherWeek,
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //
                //           var tom =
                //               "${snapshot.data?.common_list?[0]["main"]["humidity"]}%";
                //           return Text(
                //             tom,
                //             style: GoogleFonts.roboto(
                //               fontSize: 24,
                //               color: Colors.black45,
                //             ),
                //           );
                //         } else if (snapshot.hasError) {
                //           return Text(
                //               '${snapshot.error}${snapshot.data?.common_list}');
                //         }
                //
                //         return const CircularProgressIndicator();
                //       },
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: MediaQuery.of(context).size.height * 0.07,
                //       right: MediaQuery.of(context).size.height * 0.021),
                //   child: Align(
                //     alignment: Alignment.topRight,
                //     child: FutureBuilder<Weather5Days>(
                //       future: futureWeatherWeek,
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           var tom =
                //               "${snapshot.data?.common_list?[0]["wind"]["speed"]} km/h";
                //           return Text(
                //             tom,
                //             style: GoogleFonts.roboto(
                //               fontSize: 18,
                //               color: Colors.black45,
                //             ),
                //           );
                //         } else if (snapshot.hasError) {
                //           return Text(
                //               '${snapshot.error}${snapshot.data?.common_list}');
                //         }
                //
                //         return const CircularProgressIndicator();
                //       },
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: FutureBuilder<Weather5Days>(
                        future: futureWeatherWeek,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {

                            var tom =
                                "${snapshot.data?.city?.name}";
                            return Text(
                              tom,
                              style: GoogleFonts.roboto(
                                fontSize: 28,
                                color: Colors.black45,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                '${snapshot.error}${snapshot.data?.common_list}');
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.22,
                  ),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        dateFormat,
                        style: GoogleFonts.roboto(
                          fontSize: 28,
                          color: Colors.indigoAccent.withOpacity(0.7),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.55,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FutureBuilder<Weather5Days>(
                      future: futureWeatherWeek,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {

                          var tom =
                              "${snapshot.data?.common_list?[0]["dt_txt"].toString().substring(0,4)}.${snapshot.data?.common_list?[0]["dt_txt"].toString().substring(5,7)}.${snapshot.data?.common_list?[0]["dt_txt"].toString().substring(8,10)}";
                          return Text(
                            tom,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black45,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              '${snapshot.error}${snapshot.data?.common_list}');
                        }

                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.65),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MaterialButton(
                            onPressed: (){
                              dateWeekName = DateFormat('EEEE').format(weekDaysName(1));
                              numDay = 8;
                              changeIndex();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AnotherDayForecast()),
                              );
                            },
                              child: Column(
                                children: [
                                    FutureBuilder<Weather5Days>(
                                      future: futureWeatherWeek,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          var tom =
                                              "${snapshot.data?.common_list?[8]["dt_txt"].toString().substring(5, 7)}.${snapshot.data?.common_list?[8]["dt_txt"].toString().substring(8, 11)}";
                                          return Text(
                                            tom,
                                            style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              color: Colors.black45,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              '${snapshot.error}${snapshot.data?.common_list}');
                                        }

                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  FutureBuilder<Weather5Days>(
                                    future: futureWeatherWeek,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ImageIcon(
                                          size: 60,
                                          NetworkImage(
                                            'http://openweathermap.org/img/wn/${snapshot.data!.common_list?[8]["weather"][0]["icon"]}@2x.png',
                                          ),
                                          color: numDay==8?colors[index]:Colors.black45,
                                        );

                                      } else if (snapshot.hasError) {
                                        return Text(
                                            '${snapshot.error}${snapshot.data?.common_list}');
                                      }

                                      return const CircularProgressIndicator();
                                    },
                                  ),

                                  Text(
                                    DateFormat('EEEE').format(weekDaysName(1)),
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  FutureBuilder<Weather5Days>(
                                    future: futureWeatherWeek,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {

                                        var tom =
                                            "${snapshot.data?.common_list?[8]["main"]["temp"]?.toInt()}\u2103";
                                        return Text(
                                          tom,
                                          style: GoogleFonts.fredoka(
                                            fontSize: 18,
                                            color: Colors.black45,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            '${snapshot.error}${snapshot.data?.common_list}');
                                      }

                                      return const CircularProgressIndicator();
                                    },
                                  ),

                                ],
                              ),

                          ),
                        MaterialButton(
                          onPressed: (){
                            dateWeekName = DateFormat('EEEE').format(weekDaysName(2));
                            numDay = 16;
                            changeIndex();

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AnotherDayForecast()),
                            );
                          },
                          child: Column(
                            children: [
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[16]["dt_txt"].toString().substring(5, 7)}.${snapshot.data?.common_list?[16]["dt_txt"].toString().substring(8, 11)}";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ImageIcon(
                                      size: 60,

                                      NetworkImage(
                                        'http://openweathermap.org/img/wn/${snapshot.data!.common_list?[16]["weather"][0]["icon"]}@2x.png',
                                      ),
                                      color: Colors.black45,
                                    );

                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),

                              Text(
                                DateFormat('EEEE').format(weekDaysName(2)),
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[16]["main"]["temp"]?.toInt()}\u2103";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 18,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),

                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: (){
                            dateWeekName = DateFormat('EEEE').format(weekDaysName(3));
                            numDay = 24;
                            changeIndex();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AnotherDayForecast()),
                            );
                          },
                          child: Column(
                            children: [
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[24]["dt_txt"].toString().substring(5, 7)}.${snapshot.data?.common_list?[24]["dt_txt"].toString().substring(8, 11)}";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ImageIcon(
                                      size: 60,

                                      NetworkImage(
                                        'http://openweathermap.org/img/wn/${snapshot.data!.common_list?[24]["weather"][0]["icon"]}@2x.png',
                                      ),
                                      color: Colors.black45,
                                    );

                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
                              Text(
                                DateFormat('EEEE').format(weekDaysName(3)),
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[24]["main"]["temp"]?.toInt()}\u2103";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 18,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),

                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: (){
                            dateWeekName = DateFormat('EEEE').format(weekDaysName(4));
                            numDay = 32;
                            changeIndex();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AnotherDayForecast()),
                            );
                          },
                          child: Column(
                            children: [
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[32]["dt_txt"].toString().substring(5, 7)}.${snapshot.data?.common_list?[32]["dt_txt"].toString().substring(8, 11)}";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ImageIcon(
                                      size: 60,

                                      NetworkImage(
                                        'http://openweathermap.org/img/wn/${snapshot.data!.common_list?[32]["weather"][0]["icon"]}@2x.png',
                                      ),
                                      color: Colors.black45,
                                    );

                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
                              Text(
                                DateFormat('EEEE').format(weekDaysName(4)),
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[32]["main"]["temp"]?.toInt()}\u2103";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 18,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),

                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: (){
                            dateWeekName = DateFormat('EEEE').format(weekDaysName(5));
                            numDay = 39;
                            changeIndex();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AnotherDayForecast()),
                            );
                          },
                          child: Column(
                            children: [
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[39]["dt_txt"].toString().substring(5, 7)}.${snapshot.data?.common_list?[39]["dt_txt"].toString().substring(8, 11)}";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ImageIcon(
                                      size: 60,

                                      NetworkImage(
                                        'http://openweathermap.org/img/wn/${snapshot.data!.common_list?[39]["weather"][0]["icon"]}@2x.png',
                                      ),

                                      color: Colors.black45,
                                    );

                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),
                              Text(
                                DateFormat('EEEE').format(weekDaysName(5)),
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                              FutureBuilder<Weather5Days>(
                                future: futureWeatherWeek,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    var tom =
                                        "${snapshot.data?.common_list?[39]["main"]["temp"]?.toInt()}\u2103";
                                    return Text(
                                      tom,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 18,
                                        color: Colors.black45,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        '${snapshot.error}${snapshot.data?.common_list}');
                                  }

                                  return const CircularProgressIndicator();
                                },
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

      ),
    );
  }
}
