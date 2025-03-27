import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotaSelecionadaPage extends StatefulWidget {
  final String noteName; // Nome da nota

  const NotaSelecionadaPage({
    super.key,
    required this.noteName,
    required String folderName,
  });

  @override
  _NotaSelecionadaPageState createState() => _NotaSelecionadaPageState();
}

class _NotaSelecionadaPageState extends State<NotaSelecionadaPage> {
  final TextEditingController _textController =
      TextEditingController(); // Controlador do campo de texto
  String _noteContent = ''; // Conteúdo da nota

  @override
  void initState() {
    super.initState();
    _loadNoteContent(); // Carrega o conteúdo da nota ao abrir a página
  }

  // Carrega o conteúdo da nota do armazenamento local
  Future<void> _loadNoteContent() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedContent = prefs.getString(
      widget.noteName,
    ); // Carrega o conteúdo salvo
    if (savedContent != null) {
      setState(() {
        _noteContent = savedContent;
        _textController.text =
            savedContent; // Preenche o campo de texto com o conteúdo salvo
      });
    }
  }

  // Salva o conteúdo da nota no armazenamento local
  Future<void> _saveNoteContent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      widget.noteName,
      _textController.text,
    ); // Salva o conteúdo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteName), // Exibe o nome da nota no topo
        actions: [
          IconButton(
            icon: const Icon(Icons.save), // Ícone de salvar
            onPressed: () {
              _saveNoteContent(); // Salva o conteúdo da nota
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Nota salva!')));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _textController,
          maxLines: null, // Permite múltiplas linhas
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white, // Define a cor do texto como branco
          ),
          decoration: const InputDecoration(
            hintText: null, // Remove o placeholder
            border: InputBorder.none, // Remove a borda
            fillColor: Color.fromARGB(
              50,
              0,
              0,
              0,
            ), // Fundo levemente transparente
            filled: true, // Ativa o fundo
          ),
          keyboardType: TextInputType.multiline, // Permite múltiplas linhas
          textInputAction:
              TextInputAction.newline, // Quebra de linha ao pressionar Enter
          onChanged: (value) {
            _noteContent =
                value; // Atualiza o conteúdo da nota conforme o texto é digitado
          },
        ),
      ),
    );
  }
}
