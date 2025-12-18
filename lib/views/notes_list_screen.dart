import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_provider.dart';
import 'note_detail_screen.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Notas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // FutureBuilder carga las notas la primera vez que se abre la app
      body: FutureBuilder(
        future: Provider.of<NoteProvider>(context, listen: false).fetchAndSetNotes(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<NoteProvider>(
                builder: (ctx, noteData, child) => noteData.items.isEmpty
                    ? const Center(child: Text('No hay notas aún. ¡Crea una!'))
                    : ListView.builder(
                        itemCount: noteData.items.length,
                        itemBuilder: (ctx, i) {
                          final note = noteData.items[i];
                          return ListTile(
                            title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
                            trailing: note.isPinned == 1 ? const Icon(Icons.push_pin, color: Colors.blue) : null,
                            onTap: () {
                              // Navegar para editar
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => NoteDetailScreen(note: note)),
                              );
                            },
                          );
                        },
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para crear nueva nota
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const NoteDetailScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}