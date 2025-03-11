import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

//manages the state of our counter
//initial state is set to zero, incremenet and decrement functions (based on checked box - updates state)

class CounterCubit extends Cubit<int> {
  CounterCubit(): super(0);

  void increment() => emit (state + 1); //adds 1 to the current state value
  void decrement() => emit (state - 1); //removes 1 from the current state value

}
