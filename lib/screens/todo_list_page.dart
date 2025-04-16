import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
   TodoListPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'adicione uma tarefa',
                    hintText: 'Ex.: Comprar leite',
                   
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed:() {},
                child: Text('+'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
