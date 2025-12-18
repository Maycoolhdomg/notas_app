import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './viewmodels/note_provider.dart';
import './views/notes_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => NoteProvider(),
      child: MaterialApp(
        title: 'Mis Notas',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const NotesListScreen(),
      ),
    );
  }
}