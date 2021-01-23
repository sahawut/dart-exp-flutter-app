import 'package:bloc/bloc.dart'; //* Business Logic Component (BLoC)
import 'package:flutter/material.dart'; //* Google Material Design Implementation
import 'package:flutter_bloc/flutter_bloc.dart'; //* Flutter BLoC
//* comment like this line will be removed in production code (prod); it is for education only.
void main() { //* Entry point
  Bloc.observer = PrintObserver(); //* register global observer
  runApp(App()); //* run app with the App instance
}
//* I don't know the best way to split this file yet. However, it is nice to have all in a file.
class App extends MaterialApp { //* inherit from Material Design App
  App() : super(
      title: 'Flutter Counter Demo', //* e.g. HTML title
      theme: ThemeData(
        brightness: Brightness.dark, //* use dark mode theme
        visualDensity: VisualDensity.adaptivePlatformDensity, //* see doc by hitting F1 in IntelliJ
      ), //* Dart allows tailing comma (,). See the comma after child in HomeBloc.build().
      home: HomeBloc() //* default route of the app
  );
}
//* Using BLoC pattern will extend StatelessWidget (not StatefulWidget) because BLoC classes manage states.
class HomeBloc extends StatelessWidget { //* A class ending with Bloc is a container Widget providing Cubit
  @override
  Widget build(BuildContext _) => BlocProvider( //* Use _ if the parameter will not be used; actually BuildContext can be omitted.
    create: (_) => CounterCubit(),  //* (...) => ... is like JS => function, a shorthand of function
    child: CounterView(), //* provide a CounterCubit instance to the child.
  );
}
//* /// is doc of the below code, i.e. CounterUI. Note: No comment unless it is absolutely needed because comments are hard to update/maintain. The below doc will be removed in prod. It is for education only.
/// provided [CounterCubit] and notifies it in response to user input.
class CounterView extends StatelessWidget { //* A class ending with View is a class render UI from out put of the state only (no logic)
  @override
  Widget build(context) {
    return Scaffold( // See what we can change UI in doc of Scaffold, AppBar, etc.
      appBar: AppBar(title: const Text('Counter')), //* 'Counter' will show at the top banner in UI
      body: Center(
        child: BlocBuilder<CounterCubit, int>( //* instantiate CounterCubit consumer; unfortunately, dart requires a redundant int (which is declared in CounterCubit)
          builder: (context, state) => //* state is the state of CounterCubit
              Text('$state', style: Theme.of(context).textTheme.headline2), // '$state' is a string value of the state variable (an int)
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}

// Business Logic Classes
////////////////////////////////////////////////////////////////////////////////
class PrintObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType}: $change'); //* print to both server console and browser console
    super.onChange(cubit, change);
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1); //* notify the observer (in CounterView) the state changed
  void decrement() => emit(state - 1);
}
