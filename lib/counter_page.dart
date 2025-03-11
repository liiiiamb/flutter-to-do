import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/counter_cubit.dart';

class CounterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')), //set app bar title
      body: BlocBuilder<CounterCubit, int>(builder: (context, count) => Center (child: Text('$count')),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(), //increment counter when button is clicked
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 4),
        FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(), //decrement counter when button is clicked
        ),
    ]
    ));
  }
}