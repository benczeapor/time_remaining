import 'package:flutter/material.dart';
import 'package:time_remaining/main.dart';
import 'package:intl/intl.dart';
import 'package:time_remaining/picker.dart';
import 'package:time_remaining/file_manager.dart';

class Events extends StatefulWidget
{
  @override
  _Events createState() => _Events();
}

class _Events extends State<Events>
{
  final controller = TextEditingController();

  @override void initState()
  {
    super.initState();
    // print("innit");
  }

  void delete(int index)
  { 
    setState(() {
      events.removeAt(index);
      updateEvents();
    });
    
  }
  
  static void anyad()
  {
    print("kecske");
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      
      backgroundColor: bgColor,

      body: ListView.builder
      (
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index)
        {
          return Card
          (
            elevation: 10,
            child: ListTile
            ( 
              isThreeLine: showPriority,
              tileColor: listColor,
              title: Text(events[index].name),
              subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm').format(events[index].time) + ( showPriority ?  "\nPriority: ${events[index].priority}" : "")),
              trailing: Row
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  IconButton(onPressed: () 
                  {
                    showDialog(context: context, builder: (BuildContext builder) => Editor(index: index)).then((value) => setState((){}));
                  }, 
                  icon: const Icon(Icons.edit)),
                  IconButton(onPressed: () {delete(index);}, icon: const Icon(Icons.delete))
                ],
              ),
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: ()
        {
          showDialog(context: context, builder: (BuildContext context) => Editor(index: -1)).then((value) => setState((){})); 
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}