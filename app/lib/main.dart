import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = PrintObserver();
  runApp(App());
}

class PrintObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }
}

class App extends MaterialApp {
  App() : super(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocWidget()
  );
}

class BlocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext _) => BlocProvider(
    create: (_) => IntCubit(),
    child: CounterView(),
  );
}

class IntCubit extends Cubit<int> {
  IntCubit() : super(0);
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

/// provided [IntCubit] state and notifies it in response to user input.
class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<IntCubit, int>(
          builder: (context, state) => Text('$state', style: Theme.of(context).textTheme.headline2),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<IntCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<IntCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}
