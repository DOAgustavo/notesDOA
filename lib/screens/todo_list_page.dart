import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16), // Corrigido aqui
          child: TextField(decoration: InputDecoration(
            labelText: "email",
            hintText: "exemplo@gmail.com",
            border: OutlineInputBorder()
            ),
          ),
        ),
      ),
    );
  }
}