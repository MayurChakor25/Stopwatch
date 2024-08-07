import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StopwatchApp(),
      title: "Stopwatch app by flutter",
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key});

  @override
  State<StopwatchApp> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  String hoursString = "00", minuteString = "00" ,  secondString ="00";
  int hours = 0, minutes = 00, seconds = 00;
  bool isTimerRunning = false;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer(){
    setState(() {
      isTimerRunning=true;
    });
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
      _startSecond();
    });
  }

  void pauseTimer(){
    setState(() {
      isTimerRunning=false;
    });
    _timer.cancel();
  }

  void resetTimer(){
    _timer.cancel();
    setState(() {
      seconds=0;
      minutes=0;
      hours=0;
      secondString="00";
      minuteString="00";
      hoursString="00";
    });
  }

  void _startSecond(){
    setState(() {
      if(seconds< 59){
        seconds++;
        secondString = seconds.toString();
        if(secondString.length==1){
          secondString = "0"+secondString;
        }
      }else{
        _startMinute();
      }
    });
  }

  void _startMinute(){
    setState(() {
      if(minutes< 59){
        seconds=0;
        secondString="00";
        minutes++;
        minuteString = minutes.toString();
        if(minuteString.length==1) {
          minuteString = "0" + minuteString;
        }
      }else{
          _startHours();
        }
    });
  }

  void _startHours(){
    setState(() {
      seconds=0;
      secondString="00";
      minutes=0;
      minuteString="00";
      hours++;
      hoursString = hours.toString();
      if(hoursString.length==1){
        hoursString = "0"+hoursString;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STOPWATCH"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              height: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 4
                )
              ),
              child: Text("$hoursString:$minuteString:$secondString",style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(width: 20),
            ElevatedButton(onPressed: (){
              if(isTimerRunning){
                pauseTimer();
              }else{
                startTimer();
              }
            },
                child: Text(isTimerRunning ? "Pause" : "Start",style: TextStyle(
                  fontSize: 15,
                ),)),
            ElevatedButton(onPressed: (){
              resetTimer();
            },
                child: Text("RESET",style: TextStyle(
                  fontSize: 20
                ),))
          ],
        ),
      ),
    );
  }
}

