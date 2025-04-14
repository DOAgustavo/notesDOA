import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
   TodoListPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16), // Corrigido aqui
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                 controller: emailController,
                 decoration: InputDecoration(
                 labelText: "email",
                
                 border: OutlineInputBorder(),
               
                ),
              ),
              ElevatedButton(onPressed: login, child: Text("entrar"))
            ],
          ),
        ),
      ),
    );
  }
  void login(){
 String text = emailController.text;
 print(text);
 emailController.clear();
 

}
}
