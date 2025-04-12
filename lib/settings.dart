import 'package:flutter/material.dart';
import 'package:time_remaining/main.dart';

class Settings extends StatefulWidget
{
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State <Settings>
{
  List<String> dateOptions = ["asd1", "asd2", "asd3"];
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text("Settings"),
        backgroundColor: barColor,

      ),
      backgroundColor: bgColor,

      body: Column
      (
        children:
        [
          Flexible
          (
            child: Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: 
              [
                const Text("Show Priority: "),
                Switch
                (
                  value: showPriority, 
                  onChanged: (value) 
                  {
                    setState(() 
                    {
                      showPriority = value;
                    }); 
                  },
                )
              ],
            )
          ),
        ]
      ),
    );
  }
}