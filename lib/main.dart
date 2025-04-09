import'package:flutter/material.dart';
import 'package:notesDOA/screens/todo_list_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: TodoListPage(),
    );
  }
}
