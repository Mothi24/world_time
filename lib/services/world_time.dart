import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      final Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      int addHours = int.parse(offset.substring(0,3));
      int addMins = int.parse(offset.substring(4));

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: addHours, minutes: addMins));

      isDayTime = (now.hour > 6 && now.hour < 19) ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print('caught error: $e');
      time = 'Could not get time data';
    }

  }

}