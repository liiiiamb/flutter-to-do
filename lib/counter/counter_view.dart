/*

Counter view - responsible for UI

- use BlocBuilder
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';

class CounterView extends StatefulWidget {
  //as there is a checkbox which changes, this now has state and is a stateful widget

  const CounterView({super.key});

  @override
  State<StatefulWidget> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  bool _isChecked = false;

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterCubit, int>(builder: (context, state) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center, //this centers the column
            children: [
          Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value ?? false; //handles null safety
                  if (_isChecked == true){
                    //if checkbox is checked, increment the counter
                    context.read<CounterCubit>().increment();
                  }
                });
              }),
          Text(
            state.toString(),
            style: const TextStyle(fontSize: 50),
          )
        ]);
      }),
      /*
      BUTTONS GO BELOW THE BLOCBUILDER
       */
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //increment button
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),

          //spacing
          const SizedBox(height: 50),

          //decrement button

          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
