import 'package:flutter/material.dart';
import 'package:time_remaining/home.dart';
import 'package:time_remaining/settings.dart';
import 'package:time_remaining/file_manager.dart';

import "dart:async";
import "package:flutter/services.dart";

final Color placeholder = Colors.amber.shade900;
final Color barColor = Colors.grey.shade900;
final Color bgColor = Colors.grey.shade700;
final Color listColor = Colors.grey.shade400;

int sortSelected = 0;
int sortOrder = 0;
bool showPriority = false;
String dateFormat = "";

const List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.pink, Colors.amber, Colors.cyan, Colors.deepOrange, Colors.deepPurple];

int update = 1;

const String eventsFile = "events.json";
Timer? timer;

class Event // event variables, for storing events at runtime
{
  String name = "";
  DateTime time = DateTime.now();
  int priority = 0;
  int color = 0;

  Event(String n, DateTime d, int pr, int clr) // constructor, so we can use it like "events.add(Event(..., ...));"
  {
    name = n;
    time = d;
    priority = pr;
    color = clr;
  }

  @override
  String toString() => name;
}

List<Event> events = []; // a list of event type variables, for storing events at runtime

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await createFile("events.json", "");

  await loadEvents();

  runApp
  (
    MaterialApp
    (
      debugShowCheckedModeBanner: false,
      routes: 
      {
        '/': (context) => Home(),
        '/settings': (context) => Settings(),
      },
    )
  );
}