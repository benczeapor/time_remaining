import 'package:flutter/material.dart';
import 'package:time_remaining/calendar.dart';
import 'package:time_remaining/counter.dart';
import 'package:time_remaining/events.dart';
import 'package:time_remaining/main.dart';

class Home extends StatefulWidget
{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
{
  int _currentIndex = 1;

  _HomeState()
  {
    // setState(() {_currentIndex = 1;});
    _currentIndex = 1;
  }

  final List _children = 
  [
    Calendar(),
    Counter(),
    Events()
  ];

  @override

  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: barColor,

        title: const Text("Time Remaining"),
        centerTitle: true,

        actions: <Widget> 
        [
          IconButton
          (
            icon: const Icon
            (
              Icons.settings,
            ),
            onPressed: ()
            {
              setState(() 
              {
                Navigator.pushNamed(context, '/settings').then((value) => setState(()
                {
                  _children[1] = Counter();
                  _children[2] = Events();
                }));
              });
            }
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar
      (
        backgroundColor: barColor,
        unselectedItemColor: Colors.grey.shade500,
        fixedColor: Colors.grey.shade200,

        currentIndex: _currentIndex,
        onTap: (int index)
        {
          setState(() 
          {
            _currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>
        [
          BottomNavigationBarItem
          (
            icon: Icon((_currentIndex == 0) ? Icons.calendar_today : Icons.calendar_today_outlined),
            label: 'Calendar'
          ),
          BottomNavigationBarItem
          (
            icon: Icon((_currentIndex == 1) ? Icons.home : Icons.home_outlined),
            label: 'Home'
          ),
          BottomNavigationBarItem
          (
            icon: Icon((_currentIndex == 2) ? Icons.view_list : Icons.list),
            label: 'Events'
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}