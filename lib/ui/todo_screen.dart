import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_grapql/bloc/todo_bloc.dart';
import 'package:todo_grapql/bloc/todo_states.dart';
import 'package:todo_grapql/ui/widgets/add_todo_widgets.dart';
import 'package:todo_grapql/ui/widgets/card_widgets.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('ToDo'),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoadedState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return cardWidget(state.todos![index]);
              },
              itemCount: state.todos!.length,
            );
          } else {
            return Container();
          }
        },
        listener: (context, state) {
          if (state is TodoErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.msg)));
          }
        },
      ),
      floatingActionButton: addTodoWidget(),
    );
  }
}
