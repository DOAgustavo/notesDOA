import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotaSelecionadaPage extends StatefulWidget {
  final String noteName; // Nome da nota
  final String folderName; // Nome da pasta onde a nota está

  const NotaSelecionadaPage({
    super.key,
    required this.noteName,
    required this.folderName, required String noteContent, required Null Function(dynamic updatedContent) onSave,
  });

  @override
  _NotaSelecionadaPageState createState() => _NotaSelecionadaPageState();
}

class _NotaSelecionadaPageState extends State<NotaSelecionadaPage> {
  final TextEditingController _textController = TextEditingController();
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
      '${widget.folderName}_${widget.noteName}', // Chave única para a nota
    );
    if (savedContent != null) {
      setState(() {
        _noteContent = savedContent;
        _textController.text = savedContent; // Preenche o campo de texto
      });
    }
  }

  // Salva o conteúdo da nota no armazenamento local
  Future<void> _saveNoteContent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '${widget.folderName}_${widget.noteName}', // Chave única para a nota
      _textController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nota salva!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteName), // Exibe o nome da nota no topo
        actions: [
          IconButton(
            icon: const Icon(Icons.save), // Ícone de salvar
            onPressed: _saveNoteContent, // Salva o conteúdo da nota
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _textController,
          maxLines: null, // Permite múltiplas linhas
          style: const TextStyle(fontSize: 16.0),
          decoration: const InputDecoration(
            hintText: 'Digite o conteúdo da nota aqui...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            _noteContent = value; // Atualiza o conteúdo da nota em tempo real
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNoteContent, // Salva o conteúdo ao pressionar o botão
        child: const Icon(Icons.save),
      ),
    );
  }
}