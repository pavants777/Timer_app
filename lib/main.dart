import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  value: seconds == 0 ? 0 : seconds / 60,
                  strokeWidth: 20,
                ),
              ),
              Positioned(
                  bottom: 130,
                  left: 60,
                  child: Text(
                    '${hours <= 9 ? '0$hours' : hours} : ${minutes <= 9 ? '0$minutes' : minutes} : ${seconds <= 9 ? '0$seconds' : seconds}',
                    style: TextStyle(fontSize: 40),
                  ))
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  timer = Timer.periodic(Duration(seconds: 1), (timer) {
                    int secondref = seconds;
                    int minutesref = minutes;
                    int hoursref = hours;

                    secondref = (seconds + 1) % 60;

                    if (secondref == 0) {
                      minutesref = (minutes + 1) % 60;
                    }
                    if (minutes == 59 && seconds == 59) {
                      hoursref = (hours + 1) % 24;
                    }
                    setState(() {
                      seconds = secondref;
                      minutes = minutesref;
                      hoursref = hoursref;
                    });
                  });
                },
                child: Text('Start'),
              ),
              SizedBox(
                width: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    timer!.cancel();
                  },
                  child: Text('Stop')),
            ],
          ),
        ],
      )),
    );
  }
}
