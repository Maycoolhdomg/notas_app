import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _items = [];

  // Getter para obtener las notas
  List<Note> get items => [..._items];

  // Método para cargar notas de la base de datos
  Future<void> fetchAndSetNotes() async {
    _items = await DBHelper.getNotes();
    notifyListeners(); // Notifica a la UI que hay nuevos datos
  }

  // Método para agregar o actualizar
  Future<void> addOrUpdateNote(Note note) async {
    await DBHelper.insertNote(note);
    await fetchAndSetNotes(); // Recarga la lista local
  }

  // Método para eliminar
  Future<void> deleteNote(int id) async {
    final db = await DBHelper.database();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    _items.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  Future<void> togglePin(Note note) async {
    final updatedNote = Note(
      id: note.id,
      title: note.title,
      content: note.content,
      updatedAt: DateTime.now(),
      isPinned: note.isPinned == 0 ? 1 : 0,
    );
    await addOrUpdateNote(updatedNote);
  }
}