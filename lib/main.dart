import 'package:flutter/material.dart';
import 'screens/todas_pastas.dart'; // Importa o arquivo com a classe DarkThemePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Theme Page',
      theme: ThemeData.dark(), // Define o tema escuro
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      home: const DarkThemePage(), // Chama a página DarkThemePage
    );
  }
}
