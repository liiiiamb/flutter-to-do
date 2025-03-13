import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/counter_cubit.dart';
import 'counter/counter_page.dart';

//main is where everything is ran from?

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget{
  const CounterApp({super.key});


  @override
  Widget build(BuildContext context) { //this is a widget
    return const MaterialApp( //MaterialApp is the foundation of the app
      debugShowCheckedModeBanner: false,
      home: CounterPage(), //when app starts up go to counterpage - which provides cubit to counter view (UI)
    );
  }
}

