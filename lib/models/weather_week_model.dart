class Weather5Days {
  String? cod;
  int? message;
  int? cnt;
  List? common_list;
  City? city;
  Weather5Days({this.cod, this.message, this.cnt, this.common_list, this.city});

  Weather5Days.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];

      common_list =
      json['list'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

}

class CommonList {
  int? dt;
  Main? main;
  List? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  // double? pop;
  Sys? sys;
  String? dtTxt;
  // Rain? rain;

  CommonList(
      {this.dt,
        this.main,
        this.weather,
        this.clouds,
        this.wind,
        this.visibility,
        // this.pop,
        this.sys,
        this.dtTxt,
        // this.rain
      });

  CommonList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;

      weather = json['weather'];

    clouds =
    json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    // pop = json['pop'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
    // rain = json['rain'] != null ? new Rain.fromJson(json['rain']) : null;
  }

}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  Main(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.seaLevel,
        this.grndLevel,
        this.humidity,
        this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'];
  }

}

class WeatherWeek {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherWeek({this.id, this.main, this.description, this.icon});

  WeatherWeek.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

}

class Sys {
  String? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }

}

// class Rain {
//   double? d3h;
//
//   Rain({this.d3h});
//
//   Rain.fromJson(Map<String, dynamic> json) {
//     d3h = json['3h'];
//   }
//
//
// }

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City(
      {this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone,
        this.sunrise,
        this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Coord {
  double? lat;
  double? lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

}

// class List {
//   int? dt;
//   Main? main;
//   String? dtTxt;
//
//
//   List(
//       {required this.dt,
//         required this.main,
//         required this.dtTxt,
//       });
//
//   factory List.fromJson(Map<String, dynamic> json) {
//     return List(
//         dt: json['dt'],
//     main: json['main'] != null ? new Main.fromJson(json['main']) : null,
//     dtTxt:json['dt_txt']
//     );
//   }
// }
//
// class Main {
//   double? temp;
//
//   Main(
//       {required this.temp,
//       });
//
//   Main.fromJson(Map<String, dynamic> json) {
//     temp = json['temp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['temp'] = this.temp;
//     return data;
//   }
// }
//
// class WeatherWeek {
//   int? id;
//   String? main;
//   String? description;
//   String? icon;
//
//   WeatherWeek({required this.id, required this.main, required this.description, required this.icon});
//
//   WeatherWeek.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     main = json['main'];
//     description = json['description'];
//     icon = json['icon'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['main'] = this.main;
//     data['description'] = this.description;
//     data['icon'] = this.icon;
//     return data;
//   }
// }

// class Weather5Days {
//   // final String? today_description;
//   // final double? today_temp;
//   final String? tomorrow;
//
//   Weather5Days({
//     // required this.today_description,
//     // required this.today_temp,
//     required this.tomorrow,
//   });
//
//   factory Weather5Days.fromJson(Map<String, dynamic> json) {
//     return Weather5Days(
//       // today_description: json["list"][1]["weather"]["description"],
//       // today_temp: json["list"][1]["main"]["temp"],
//       tomorrow: json['list'][7]["dt_txt"]
//     );
//   }
// }


