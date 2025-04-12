import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:time_remaining/main.dart';

Future<File> getFile(String name) async
{
  final dir = await getApplicationDocumentsDirectory();
  final path = dir.path;
  return File('$path/$name');
}

Future<void> createFile(String name, String defaultData) async
{
  final file = await getFile(name);

  file.writeAsString(defaultData, mode: FileMode.append);
}

Future<String> readFile(String name) async
{
  final file = await getFile(name);

  return await file.readAsString();
}

void updateEvents() async // method that is called every time a new event is created, it saves events to the file
{

  final file = await getFile("events.json");

  final count = events.length;
  String out = '{"count": '; // building output string manually

  out += count.toString();

  out += ', "showPriority": ';
  out += '$showPriority';

  out += ', "events": [';

  for(int i=0; i<count; i++)
  {
    if(i != 0)
    {
      out += ',';
    }

    out += '{"name": "${events[i].name}", "date": "${events[i].time}", "priority": "${events[i].priority}", "color": "${events[i].color}"}';
  }

  out += ']}';

  file.writeAsString(out);

}

Future<int> loadEvents() async // method that is called at the start, loads events from the file
{
  String sData = await readFile(eventsFile);

  if(sData.isEmpty
  )
  {
    return 1;
  }


  final data = jsonDecode(sData);

  final count = data["count"];
  showPriority = data["showPriority"];

  for(int i=0; i<count; i++)
  {
    events.add(Event(data["events"][i]["name"], DateTime.parse(data["events"][i]["date"]), int.parse(data["events"][i]["priority"]), int.parse(data["events"][i]["color"])));
  }

  return 1;
}

String remaining(DateTime input)
{
  DateTime now = DateTime.now();

  if(input.isBefore(now))
  {
    return "Event is happening or has happened";
  }

  int sec = input.difference(now).inSeconds;

  int days = ((sec - sec % 86400) / 86400).floor();
  sec -= days * 86400;
  int hr = ((sec - sec % 3600) / 3600).floor();
  sec -= hr * 3600;
  int min = ((sec - sec % 60) / 60).floor();
  sec -= min * 60;

  String out = "";

  if(days >=  7)
  {
    out += "${(days/7).floor()} week";
    if((days/7).floor() > 1)
    {
      out += "s";
    }
    out += ", ";
  }

  if(days > 0)
  {
    out += "${days % 7} days, ";
  }
  out += "$hr hr";

  if(hr > 1)
  {
    out += "s";
  }
  out += ", ";
  out += "$min min";

  if(min > 1)
  {
    out += "s";
  }

  out += ", ";
  out += "${sec}s";

  return out;
}