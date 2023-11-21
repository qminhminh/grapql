// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_grapql/bloc/todo_bloc.dart';
import 'package:todo_grapql/bloc/todo_events.dart';
import 'package:todo_grapql/todo_events/todo_repo.dart';
import 'package:todo_grapql/ui/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider<TodoRepo>(
        create: (context) => TodoRepo(),
        child: BlocProvider<TodoBloc>(
          create: (context) =>
              TodoBloc(context.read<TodoRepo>())..add(FetchTodos()),
          child: const TodoScreen(),
        ),
      ),
    );
  }
}
