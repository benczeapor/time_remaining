import 'package:flutter/material.dart';
import 'package:time_remaining/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:time_remaining/file_manager.dart';
import 'package:time_remaining/picker.dart';

void selectEvents(DateTime day, List<int> eventsOnDay)
{
  eventsOnDay.clear();

  for(int i=0; i<events.length; i++)
  {
    if(events[i].time.year == day.year && events[i].time.month == day.month && events[i].time.day == day.day)
    {
      eventsOnDay.add(i);
    }
  }
}

class Calendar extends StatefulWidget
{
  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar>
{

  void delete(int index)
  { 
    setState(() {
      events.removeAt(index);
      updateEvents();
    });
    
  }

  DateTime _selectedDate = DateTime.now();
  List<int> eventsOnDay = [];
  List<int> eventsOnSelectedDay = [];
  Map<DateTime, List<dynamic>> _events = {};
  @override
  void initState()
  {
    super.initState();

    _events[DateTime.now()] = ["asd"];
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.grey[600],
      body: Column(
        children:
        [
          Container
          (
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: TableCalendar
            ( 
              headerStyle: const HeaderStyle
              (
                formatButtonVisible: false
              ),
              calendarBuilders: CalendarBuilders
              (
                singleMarkerBuilder: (context, day, event) 
                {
                  
                },
                
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              firstDay: DateTime.parse("${DateTime.now().year}-01-01"),
              lastDay: DateTime.parse("${DateTime.now().year}-12-31"),
              focusedDay: _selectedDate,
              selectedDayPredicate: (day)
              {
                return isSameDay(_selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay)
              {
                setState(() 
                {
                  _selectedDate = selectedDay;
                  eventsOnSelectedDay.clear();
                  selectEvents(selectedDay, eventsOnSelectedDay);
                });
              },
              eventLoader: (day) 
              {
                eventsOnDay.clear();

                selectEvents(day, eventsOnDay);

                return eventsOnDay;
              },
            )
          ),
          Expanded
          (
            child:ListView.builder
            (
              itemCount: eventsOnSelectedDay.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index)
              {
                return Card
                (
                  elevation: 10,
                  child: ListTile
                  (
                    tileColor: Colors.grey[400],
                    title: Text(events[eventsOnSelectedDay[index]].name),
                    subtitle: Text(DateFormat('kk:mm').format(events[eventsOnSelectedDay[index]].time)),
                    trailing: Row
                    (
                      mainAxisSize: MainAxisSize.min,
                      children: 
                      [
                        IconButton
                        (
                          onPressed: () 
                          {
                            showDialog(context: context, builder: (BuildContext builder) => Editor(index: eventsOnSelectedDay[index])).then((value) => setState(()
                            {
                              selectEvents(_selectedDate, eventsOnSelectedDay);
                            }));
                          }, 
                          icon: const Icon(Icons.edit)
                        ),
                        IconButton
                        (
                          onPressed: () 
                          {
                            setState(() 
                            {
                              delete(eventsOnSelectedDay[index]);
                              selectEvents(_selectedDate, eventsOnSelectedDay);
                            });
                          }, 
                          icon: const Icon(Icons.delete)
                        )
                      ],
                    ),
                  ),
                );
              }
            )
          ),
        ]
      )
    );
  }
}