import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; // location name for the UI
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDaytime; // true or false if daytime or not


  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try {

      var response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      var data = jsonDecode(response.body) as Map;
      //print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      //print(datetime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime =  now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e) {
print('caught error: $e');
time = 'Could not get time data';
    }

  }

}

WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: '/Europe/Berlin');