import 'package:flutter/material.dart';
import 'package:time_remaining/main.dart';
import 'package:time_remaining/file_manager.dart';
import 'dart:async';

List<String> options = ["Creation", "Date", "Priority"];
List<Event> display = [];


void orderDisplay()
{
  switch(sortSelected)
  {
    case 0:
    if(sortOrder == 0)
    {
      display = events;
    }
    else
    {
      display = List.from(events.reversed);
    }
    break;

    case 1:
    if(sortOrder == 0)
    {
      display.sort((a, b) => a.time.compareTo(b.time));
    }
    else
    {
      display.sort((a, b) => b.time.compareTo(a.time));
    }
    break;

    case 2:
    if(sortOrder == 0)
    {
      display.sort((a,b) => a.priority.compareTo(b.priority));
    }
    else
    {
      display.sort((a,b) => b.priority.compareTo(a.priority));
    }
    break;
  }
}

class Counter extends StatefulWidget
{
  @override
  _Counter createState() => _Counter();
}

class _Counter extends State<Counter> // HOME PAGE (list of events with countdown)
{
  @override
  void initState()
  {
    super.initState();

    setState(() {
      timer?.cancel();
    });

    timer = Timer.periodic(const Duration(seconds: 1), (t) 
    {
      if(mounted)
      {
        setState(() {});
      }
    });

    display = events;
  }

  @override
  Widget build(BuildContext context)
  {

    return Scaffold
    (
      backgroundColor: bgColor,
      body: Column
      (
        children:
        [
          Row
          (
            children: 
            [
              const Expanded
              (
                child: Text("Sort By:"),
              ),
              Expanded
              (
                child: DropdownButtonFormField
                (
                  value: options[sortSelected],
                  decoration: const InputDecoration
                  (
                    border: UnderlineInputBorder
                    (
                      borderSide: BorderSide
                      (
                        color: Colors.black,
                      )
                    ),
                    focusedBorder: UnderlineInputBorder
                    (
                      borderSide: BorderSide
                      (
                        color:  Colors.black
                      )
                    )
                  ),
                  onChanged: (value) 
                  {
                    sortSelected = options.indexOf(value);
                    setState(() 
                    {
                      orderDisplay();
                    });
                  },
                  items: options.map<DropdownMenuItem>((String val) 
                  {
                    return DropdownMenuItem
                    (
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                ),
              ),
              Expanded
              (
                child: DropdownButtonFormField
                (
                  value: sortOrder,
                  decoration: const InputDecoration
                  (
                    border: UnderlineInputBorder
                    (
                      borderSide: BorderSide
                      (
                        color: Colors.black,
                      )
                    ),
                    focusedBorder: UnderlineInputBorder
                    (
                      borderSide: BorderSide
                      (
                        color:  Colors.black
                      )
                    )
                  ),
                  onChanged: (value) 
                  {
                    sortOrder = value!;
                    setState(() 
                    {
                      orderDisplay();
                    });
                  },
                  items: const
                  [
                    DropdownMenuItem
                    (
                      value: 0,
                      child: Text("Ascending"),
                    ),
                    DropdownMenuItem
                    (
                      value: 1,
                      child: Text("Descending"),
                    )
                  ],
                )
              )
            ],
          ),

          Expanded
          (
            child:ListView.builder
            (
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: display.length,
              itemBuilder: (BuildContext context, int index)
              {
                return Card
                (
                  elevation: 10,
                  child: StatefulBuilder
                  (
                    builder: (BuildContext context, StateSetter timer)
                    {
                      return ListTile
                      (
                        tileColor: listColor,
                        isThreeLine: showPriority,
                        title: Text(display[index].name),
                        subtitle: Text(remaining(display[index].time) + (showPriority ? "\nPriority: ${display[index].priority}" : "")),
                      );
                    },
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}