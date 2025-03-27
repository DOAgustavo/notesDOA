import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Para codificar e decodificar JSON
import 'nota_selecionada.dart'; // Importa a página NotaSelecionadaPage

class PastasSelecionadaPage extends StatefulWidget {
  final String folderName; // Nome da pasta

  const PastasSelecionadaPage({super.key, required this.folderName});

  @override
  _PastasSelecionadaPageState createState() => _PastasSelecionadaPageState();
}

class _PastasSelecionadaPageState extends State<PastasSelecionadaPage> {
  Map<String, String> _notes = {}; // Mapa para armazenar notas e seus conteúdos

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Carrega as notas ao abrir a página
  }

  // Carrega as notas do armazenamento local
  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesJson = prefs.getString(widget.folderName);
    if (notesJson != null) {
      setState(() {
        _notes = Map<String, String>.from(jsonDecode(notesJson));
      });
    }
  }

  // Salva as notas no armazenamento local
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String notesJson = jsonEncode(_notes);
    await prefs.setString(widget.folderName, notesJson);
  }

  void _addNote(String noteName) {
    setState(() {
      _notes[noteName] = ''; // Adiciona uma nova nota com conteúdo vazio
    });
    _saveNotes();
  }

  void _showAddNoteDialog() {
    final TextEditingController _textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Nota'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Digite o nome da nota',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo sem fazer nada
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  _addNote(_textController.text); // Adiciona a nova nota
                }
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName), // Exibe o nome da pasta no topo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _notes.keys.length,
          itemBuilder: (context, index) {
            final noteName = _notes.keys.elementAt(index);
            return GestureDetector(
              onTap: () {
                // Navega para a página NotaSelecionadaPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotaSelecionadaPage(
                      noteName: noteName, // Passa o nome da nota
                      folderName: widget.folderName, // Passa o nome da pasta
                      noteContent: _notes[noteName] ?? '', // Passa o conteúdo
                      onSave: (updatedContent) {
                        setState(() {
                          _notes[noteName] = updatedContent; // Atualiza o conteúdo
                        });
                        _saveNotes(); // Salva as alterações
                      },
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 71, 71, 71), // Fundo cinza
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  noteName, // Nome da nota
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey, // Cor do botão
        onPressed: _showAddNoteDialog, // Mostra o diálogo para adicionar nota
        tooltip: 'Add Note',
        child: const Icon(Icons.add), // Ícone de "+"
      ),
    );
  }
}