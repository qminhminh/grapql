import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_grapql/bloc/todo_bloc.dart';
import 'package:todo_grapql/bloc/todo_events.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

var idController = TextEditingController();
var titleController = TextEditingController();
var contentController = TextEditingController();

Widget addTodoWidget() => Builder(builder: (context) {
      final todoBloc = BlocProvider.of<TodoBloc>(context);

      return FloatingActionButton(onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Todo'),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: idController,
                        decoration: const InputDecoration(labelText: 'ID'),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: contentController,
                        decoration: const InputDecoration(labelText: 'Content'),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Empty';
                          } else {
                            return null;
                          }
                        },
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancle'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          todoBloc.add(AddTodo(idController.text,
                              titleController.text, contentController.text));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add'))
                ],
              );
            });
      });
    });
