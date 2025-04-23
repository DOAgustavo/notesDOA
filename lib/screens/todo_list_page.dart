import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
   TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController todoController = TextEditingController();

  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        labelText: 'adicione uma tarefa',
                        hintText: 'Ex.: Comprar leite',
                       
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed:() {
                     String text = todoController.text;
                     
                     setState(() {
                       todos.add(text);
                     });
                     todoController.clear();

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Define o raio do botão
                      ),
                      padding: EdgeInsets.all(16),
                    ),
                      child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                      
                      ),
                    ),
                    
                    
                  
                ],
              ),

              SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for(String todo in todos)
                   ListTile(
                      title: Text(todo),
                      subtitle: Text('Descrição da tarefa 1'),
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      onTap: (){
                        print('Tarefa: $todo ');
                      },
                   ),
                   
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'voce tem tarefas 0 pendentes',
                      style: TextStyle(
                        fontSize: 16,
                        
                      ),
                     
                    ),
                  ),
               

                  

                   SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('limpar tudo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Define a cor de fundo do botão
                      foregroundColor: Colors.white, // Define a cor do texto do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Define o raio do botão
                      ),
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
