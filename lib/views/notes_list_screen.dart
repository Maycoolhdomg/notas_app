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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NoteSearchDelegate(),
              );
            },
          ),
        ],
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
                        return Dismissible(
                          key: ValueKey(note.id),
                          direction: DismissDirection.endToStart, // Solo deslizar de derecha a izquierda
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Icon(Icons.delete, color: Colors.white, size: 30),
                          ),
                          // Esto muestra el diálogo de confirmación antes de borrar
                          confirmDismiss: (direction) {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('¿Estás seguro?'),
                                content: const Text('¿Deseas eliminar esta nota permanentemente?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(false),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(true),
                                    child: const Text('Sí, eliminar', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                          onDismissed: (direction) {
                            // Llama al ViewModel para borrar de la base de datos
                            Provider.of<NoteProvider>(context, listen: false).deleteNote(note.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Nota eliminada')),
                            );
                          },
                          child: Card( // Añadimos un Card para que se vea más limpio
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            child: ListTile(
                              title: Text(note.title),
                              subtitle: Text(note.content),
                              // Icono indicador si ya tiene pin
                              leading: note.isPinned == 1
                                  ? const Icon(Icons.push_pin, color: Colors.blue)
                                  : null,
                              // Botón para poner/quitar pin
                              trailing: IconButton(
                                icon: Icon(
                                  note.isPinned == 1 ? Icons.push_pin : Icons.push_pin_outlined,
                                  color: note.isPinned == 1 ? Colors.blue : Colors.grey,
                                ),
                                onPressed: () async {
                                  try {
                                    await Provider.of<NoteProvider>(context, listen: false).togglePin(note);
                                  } catch (error) {
                                    // Mostrar error si ya hay 2 notas ancladas
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error.toString())),
                                    );
                                  }
                                },
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctx) => NoteDetailScreen(note: note)),
                                );
                              },
                            ),
                          ),
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
class NoteSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final results = noteProvider.searchNotes(query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, i) {
        final note = results[i];
        return ListTile(
          title: Text(note.title),
          subtitle: Text(note.content),
          onTap: () {
            close(context, null);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => NoteDetailScreen(note: note)),
            );
          },
        );
      },
    );
  }
}