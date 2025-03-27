import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Para codificar e decodificar JSON
import 'pasta_selecionada.dart'; // Importa a página PastasSelecionadaPage

class DarkThemePage extends StatefulWidget {
  const DarkThemePage({super.key});

  @override
  _DarkThemePageState createState() => _DarkThemePageState();
}

class _DarkThemePageState extends State<DarkThemePage> {
  List<String> _folders = []; // Lista para armazenar os nomes das pastas

  @override
  void initState() {
    super.initState();
    _loadFolders(); // Carrega as pastas ao abrir a página
  }

  // Carrega as pastas do armazenamento local
  Future<void> _loadFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? foldersJson = prefs.getString(
      'folders',
    ); // Carrega as pastas salvas
    if (foldersJson != null) {
      setState(() {
        _folders = List<String>.from(
          jsonDecode(foldersJson),
        ); // Decodifica as pastas
      });
    }
  }

  // Salva as pastas no armazenamento local
  Future<void> _saveFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final String foldersJson = jsonEncode(
      _folders,
    ); // Codifica as pastas em JSON
    await prefs.setString('folders', foldersJson); // Salva as pastas
  }

  void _addFolder(String folderName) {
    setState(() {
      _folders.add(folderName); // Adiciona o nome da nova pasta à lista
    });
    _saveFolders(); // Salva as pastas no armazenamento local
  }

  void _showAddFolderDialog() {
    final TextEditingController _textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Pasta'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Digite o nome da pasta',
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
                  _addFolder(_textController.text); // Adiciona a nova pasta
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
        title: const Text('All Files'), // Barra superior com "All Files"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _folders.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navega para a página PastasSelecionadaPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PastasSelecionadaPage(
                          folderName: _folders[index], // Passa o nome da pasta
                        ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 82, 82, 82), // Fundo cinza
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _folders[index], // Nome da pasta
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed:
            _showAddFolderDialog, // Mostra o diálogo para adicionar pasta
        tooltip: 'Add Folder',
        child: const Icon(Icons.add), // Ícone de "+"
      ),
    );
  }
}
