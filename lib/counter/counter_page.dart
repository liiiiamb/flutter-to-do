import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/counter/counter_cubit.dart';

import 'counter_view.dart';

/*
PROVIDES the counter cubit to the UI
 */



class CounterPage extends StatelessWidget{
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CounterCubit(0), //passing through cubit - initial state starts from 0

    //counter view (UI) - you can use BlocListener here that listens for any state changes
    //child: CounterView(),

      child: BlocListener<CounterCubit, int>(
        listener: (context, state) =>  {
          if (state == 10){ //current value of state - number on screen
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text('Congratulations!'),
                content: Text('You reached 10'),
              ),
            )
          }
        },

          child: CounterView(),
      ),
    );
  }
  
}

