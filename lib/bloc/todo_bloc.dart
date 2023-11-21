import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_grapql/bloc/todo_events.dart';
import 'package:todo_grapql/bloc/todo_states.dart';
import 'package:todo_grapql/todo_events/todo_repo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo repo;

  TodoBloc(this.repo) : super(TodoLoadingState()) {
    on<FetchTodos>((event, emit) async {
      emit(TodoLoadingState());
      try {
        final todos = await repo.fetchTodos();
        emit(TodoLoadedState(todos));
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });

    on<AddTodo>((event, emit) async {
      emit(TodoLoadingState());
      try {
        await repo.addTodo(
            id: event.id, title: event.title, content: event.content);
        add(FetchTodos());
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });

    on<DeleteTodo>((event, emit) async {
      emit(TodoLoadingState());
      try {
        await repo.deleteTodo(id: event.id);
        add(FetchTodos());
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });
  }
}
