import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';
import 'counter_page.dart';

//main is where everything is ran from?

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) { //this is a widget
    return MaterialApp( //MaterialApp is the foundation of the app
      title: 'Counter App', //title of the app can be changed here
      home: BlocProvider(
        create: (_) => CounterCubit(), //create a CounterCubit
        child: CounterPage(), //child widget of CounterPage
      ),
    );
  }
}

