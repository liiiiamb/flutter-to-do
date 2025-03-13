/*

Counter view - responsible for UI

- use BlocBuilder


- make checkboxes be a list of checkboxes - each checkbox should have a title
- add button - have input box, after completing the input box, add checkbox with title to list
- rebuild?
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart'; //import lottie for animations


import 'counter_cubit.dart';

class CounterView extends StatefulWidget {
  //as there is a checkbox which changes, this now has state and is a stateful widget

  const CounterView({super.key});

  @override
  State<StatefulWidget> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  bool _isChecked = false;
  final List<Map<String, dynamic>> _checkboxes =
      []; //creating a list of checkboxes to append to
  final TextEditingController _controller = TextEditingController();

  void _addCheckbox() {
    //method to add a new checkbox
    if (_controller.text.isNotEmpty) {
      //if text has been entered
      setState(() {
        //setting state again - notifies the framework that the internal state of this object has changed in a way that might impact the user interface in this subtree - causes the UI to be rebuilt
        _checkboxes.add({
          'title': _controller.text,
          'isChecked': false
        }); //adds a new checkbox with the entered text, and a default state of not checked
        _controller.clear(); //clears the input box after adding the checkbox
      });
    }
  }

  Future<void> _displayTextInput(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Add a new item'),
              content: TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Add a new item'),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _addCheckbox(); //when the add button is pressed, add the checkbox
                    Navigator.pop(context); //close the dialog
                  },
                  child: const Text('Add'),
                )
              ]);
        });
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterCubit, int>(builder: (context, state) {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center, //this centers the column
                children: [
              const Padding(
                  padding: EdgeInsets.all(50),
                  child: Text("To-Do",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ))),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: _checkboxes
                        .length, //the number of items in the list is equal to the length of the checkboxes list
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          title: Text(_checkboxes[index]['title']),
                          value: _checkboxes[index]['isChecked'],
                          onChanged: (value) {
                            setState(() {
                              _checkboxes[index]['isChecked'] =
                                  value ?? false; //null safety
                            });
                            if (value == true) {
                              context.read<CounterCubit>().increment();
                              showDialog(
                                context: context,
                                barrierDismissible: false, // Prevent user from dismissing animation early
                                builder: (BuildContext context) {
                                  Future.delayed(const Duration(seconds: 1), () { //delay the closing of the dialog
                                    Navigator.pop(context); // Close animation dialog
                                    setState(() {
                                      _checkboxes.removeAt(index); //remove the checked checkbox
                                    });
                                  });

                                  return Dialog(
                                    backgroundColor: Colors.transparent, //shows the lottie animation
                                    child: Center(
                                      child: Lottie.asset('assets/bin.json'),
                                    ),
                                  );
                                },
                              );

                            } else {
                              context
                                  .read<CounterCubit>()
                                  .decrement(); //if checkbox is unchecked, decrement the counter
                            }
                          });
                    }),
              ),
            ]));
      }),
      /*
      BUTTONS GO BELOW THE BLOCBUILDER
       */
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //add new item button
          FloatingActionButton(
            onPressed: () => _displayTextInput(context),
            child: const Icon(Icons.add),
          ),

          //spacing
          const SizedBox(height: 30),

          BlocBuilder<CounterCubit, int>(//use BlocBuilder to access the state
              builder: (context, state) {
            return Text(
              'Completed: $state', //this will show the current state of the counter
              // state.toString(),
              style: const TextStyle(fontSize: 25),
            );
          })
        ],
      ),
    );
  }
}
