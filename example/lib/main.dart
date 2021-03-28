import 'package:flutter/material.dart';
import 'package:number_transcriber/number_transcriber.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                NumberTranscriber().transcribe(123),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
