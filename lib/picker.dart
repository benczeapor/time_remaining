import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_remaining/main.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:time_remaining/file_manager.dart';

class Editor extends StatefulWidget
{
  Editor({required this.index});

  @override
  int index;
  _Editor createState() => _Editor();
}

class _Editor extends State<Editor>
{
  String tName = "";
  DateTime ?tDate;
  DateTime ?tTime;
  int tPriority = 0;
  int tColor = -1;

  @override
  void initState()
  {
    super.initState();
    if(widget.index != -1)
    {
      tDate = events[widget.index].time;
      tTime = events[widget.index].time;
      tName = events[widget.index].name;
      tPriority = events[widget.index].priority;
      tColor = events[widget.index].color;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog
    (
      scrollable: true,
      title: const Center(child : Text("Event")),
      content: Form
      (
        child: Column
        (
          
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>
          [
            Container // Az esemény neve
            (
              padding:  const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child:TextFormField
              (
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration
                (
                  border: OutlineInputBorder(),
                  labelText: "Name"
                ),
                initialValue: (widget.index != -1) ? events[widget.index].name : null,
                onChanged: (text)
                {
                  tName = text;
                },
              ), 
            ),

            Container // Az esemény dátuma
            (
              padding:  const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child:DateTimeField
              (
                decoration: const InputDecoration
                (
                  border: OutlineInputBorder(),
                  labelText: "Date"
                ),
                mode: DateTimeFieldPickerMode.date,
                onDateSelected: (date) 
                {
                  setState(() 
                  {
                    tDate = date;
                  });
                  
                },
                selectedDate: tDate,
                firstDate: DateTime.now(),
              ), 
            ),

            Container // Az esemény időpontja (óra, perc)
            (
              padding:  const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child:DateTimeField
              (
                decoration: const InputDecoration
                (
                  border: OutlineInputBorder(),
                  labelText: "Time"
                ),
                mode: DateTimeFieldPickerMode.time,
                use24hFormat: true,
                dateFormat: DateFormat("HH:mm"),
                onDateSelected: (time) 
                {
                  setState(() 
                  {
                    tTime = time;  
                  });
                },
                selectedDate: tTime,
                firstDate: DateTime.now(),
              )
            ),
            Container // Az esemény fontossága
            (
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: TextFormField
              (
                decoration: const InputDecoration
                (
                  labelText: "Priority",
                  border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) 
                {
                  if(value != "")
                  {
                    tPriority = int.parse(value);
                  }
                  else
                  {
                    tPriority = 0;
                  }
                    
                },
                initialValue: (widget.index != -1) ? tPriority.toString() : null

              ),
            ),
          ],
        ),
      ),
      actions:
      [
        //
        Row
        (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>
          [
            ElevatedButton
            (
              onPressed: () 
              {
                Navigator.pop(context, true);
              }, 
              child: const Text("Cancel")
            ),
            ElevatedButton
            (
              onPressed: () 
              {
                if((tName != "" && tDate != null && tTime != null) || widget.index != -1)
                {
                  setState(() 
                  {
                    if(widget.index != -1)
                    {
                      events[widget.index] = Event(tName, DateTime(tDate?.year ?? 1970, tDate?.month ?? 01, tDate?.day ?? 01, tTime?.hour ?? 0, tTime?.minute ?? 0, tTime?.second ?? 0), tPriority, tColor);
                    }
                    else
                    {
                      events.add(Event(tName, DateTime(tDate?.year ?? 1970, tDate?.month ?? 01, tDate?.day ?? 01, tTime?.hour ?? 0, tTime?.minute ?? 0, tTime?.second ?? 0), tPriority, tColor)); // TEMP ONLY, CHANGE!!!!!!!
                    }
                    updateEvents();
                    Navigator.pop(context, true);
                  });
                }
              },
              child: const Text("Done")
            ),

          ],
        ),
        
        
      ],
    );
  }
}