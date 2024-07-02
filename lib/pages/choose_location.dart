import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: 'London', flag: 'uk.png', url: 'Europe/London'),
    WorldTime(location: 'Berlin',flag: 'germany.png',url: 'Europe/Berlin'),
    WorldTime(location: 'Cairo',flag: 'egypt.png',url: 'Africa/Cairo'),
    WorldTime(location: 'Chicago',flag: 'usa.png',url: 'America/Chicago'),
    WorldTime(location: 'New York',flag: 'usa.png',url: 'America/New_York'),
    WorldTime(location: 'Kolkata',flag: 'india.png',url: 'Asia/Kolkata'),
    WorldTime(location: 'Seoul',flag: 'south_korea.png',url: 'Asia/Seoul'),
    WorldTime(location: 'Jakarta',flag: 'indonesia.png',url: 'Asia/Jakarta')
  ];

  void updateTime(index) async {
    WorldTime wt = locations[index];
    await wt.getTime();
    Navigator.pop(context, {
      'location' : wt.location,
      'flag' : wt.flag,
      'isDayTime' : wt.isDayTime,
      'time' : wt.time,
    });


  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Text("Choose a Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
