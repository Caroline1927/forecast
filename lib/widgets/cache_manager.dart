import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:forecast/api/weather_week_api.dart';

import '../models/weather_week_model.dart';
import '../screens/main_page.dart';
import '../screens/today_forecast.dart';
import '../utils/location_functionality.dart';
import 'package:http/http.dart' as http;

class UploadCacheMemoryData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("UploadCacheMemoryData");
    return StreamBuilder<FileResponse>(
      stream: fileStream,
      builder: (_, snapshot) {
        FileInfo fileInfo = snapshot.data as FileInfo;
        return snapshot.hasData
            ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Original Url:${fileInfo.originalUrl}"),
            Text("Valid Till:${fileInfo.validTill}"),
            Text("File address:${fileInfo.file}"),
            Text("File source:${fileInfo.source}"),
            Text("Hash code:${fileInfo.hashCode}"),
            Text("Type:${fileInfo.runtimeType}"),
          ],
        )
            : Center(
          child: Text("Uploading..."),
        );
      },
    );
  }
}
class FetchCacheMemoryData extends StatefulWidget {
  const FetchCacheMemoryData({Key? key}) : super(key: key);

  @override
  State<FetchCacheMemoryData> createState() => _FetchCacheMemoryDataState();
}

var responceCache;
class _FetchCacheMemoryDataState extends State<FetchCacheMemoryData> {
// class FetchCacheMemoryData extends StatelessWidget {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
        fetchWeatherForWeek();
  }
  Future<FileInfo?> fileInfoFuture = DefaultCacheManager().getFileFromCache(url!);

  @override
  Widget build(BuildContext context) {
    print("FetchCacheMemoryData");
    return FutureBuilder(
      future: fileInfoFuture,
      builder: (context, snapshot) {
        FileInfo fileInfo = snapshot.data as FileInfo;

        if(snapshot.hasData) {
          // responceCache = DefaultCacheManager().getFileStream(fileInfo.originalUrl, withProgress: true);
          responceCache = fileInfo.
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Original Url:${fileInfo.originalUrl}"),
              Text("Valid Till:${fileInfo.validTill}"),
              Text("File address:${fileInfo.file}"),
              Text("File source:${fileInfo.source}"),
              Text("Hash code:${fileInfo.hashCode}"),
              Text("Hash code:${fileInfo.runtimeType}"),
            ],
          );
        }
        else{
          return Center(child: Text("Fetching..."));
        }

      },
    );
  }
}

Future<Weather5Days> fetchCache() async {
  var currentLocationData = await location.getLocation();
  url = city!=""?'http://api.openweathermap.org/data/2.5/forecast?q=$city&cnt=40&appid=43ec70748cae1130be4146090de59761&units=metric':'http://api.openweathermap.org/data/2.5/forecast?lat=${currentLocationData.latitude}&lon=${currentLocationData.longitude}&cnt=40&appid=43ec70748cae1130be4146090de59761&units=metric';

  // Dio dio = Dio();
  // dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "city!=""?'http://api.openweathermap.org/data/2.5/forecast?q=$city&cnt=40&appid=43ec70748cae1130be4146090de59761&units=metric':'http://api.openweathermap.org/data/2.5/forecast?lat=${currentLocationData.latitude}&lon=${currentLocationData.longitude}&cnt=40&appid=43ec70748cae1130be4146090de59761&units=metri")).interceptor);

  final response = await http
      .get(Uri.parse(responceCache));
  // .get(Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=Mountain%20View&cnt=40&appid=43ec70748cae1130be4146090de59761&units=metric'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Weather5Days.fromJson(jsonDecode(response.body));
  }
  // } else if (response.statusCode == 404) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.;
  // }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    rightCity = false;
    print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
    print(response.statusCode);
    print(rightCity);

    throw Exception('Error ${response.statusCode}');
  }
}