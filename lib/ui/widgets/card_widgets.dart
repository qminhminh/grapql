import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_grapql/bloc/todo_bloc.dart';
import 'package:todo_grapql/bloc/todo_events.dart';

Widget cardWidget(todo) => Builder(builder: (context) {
      final todoBloc = BlocProvider.of<TodoBloc>(context);

      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: Text(todo['id']),
          title: Text(todo['title']),
          subtitle: Text(todo['content']),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              todoBloc.add(DeleteTodo(todo['id']));
            },
          ),
        ),
      );
    });
