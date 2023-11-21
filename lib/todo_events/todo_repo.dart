// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoRepo {
  final graphql = "http://192.168.1.5:2000/graphql";

  fetchTodos() async {
    final request = {
      'query': '''
       query {
        todos {
          id
          content
          title
        }
      }
      
      '''
    };

    final response = await http.post(Uri.parse(graphql),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      final todos = result['data']['todos'];

      return todos;
    } else {
      print(response.statusCode);
    }
  }

  addTodo({
    required String id,
    required String title,
    required String content,
  }) async {
    final request = {
      'query': '''
  mutation AddTodo(\$id: String, \$title: String, \$content: String){
    addTodo(id: \$id, title: \$title, content: \$content){
      id
      title
      content
    }
  }
  ''',
      'variables': {'id': '${id}', 'title': '$title', 'content': '$content'}
    };

    final response = await http.post(Uri.parse(graphql),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode == 200) {
      print('Insert Successfull');
    } else {
      print(response.statusCode);
      print(jsonEncode(request));
      print(response.body);
    }
  }

  deleteTodo({
    required String id,
  }) async {
    final request = {
      'query': '''
       mutation DeleteTodo(\$id:String){
        deleteTodo(id: \$id){
          id
          title
          content
        }
       }
      
      
      ''',
      'variables': {'id': '${id}'}
    };

    final response = await http.post(Uri.parse(graphql),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode == 200) {
      print('delete Successfull');
    } else {
      print(response.statusCode);
      print(id);
    }
  }
}
