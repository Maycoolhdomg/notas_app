import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _items = [];

  // Getter para obtener las notas
  List<Note> get items => [..._items];

  // Metodo para cargar notas de la base de datos
  Future<void> fetchAndSetNotes() async {
    _items = await DBHelper.getNotes();
    notifyListeners(); // Notifica a la UI que hay nuevos datos
  }

  // Metodo para agregar o actualizar
  Future<void> addOrUpdateNote(Note note) async {
    await DBHelper.insertNote(note);
    await fetchAndSetNotes(); // Recarga la lista local
  }

  // Metodo para eliminar
  Future<void> deleteNote(int id) async {
    final db = await DBHelper.database();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    _items.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  // Logica para marcar como favorito
  Future<void> togglePin(Note note) async {
    // 1. Contar cuántas notas tienen pin actualmente
    final pinnedCount = _items.where((n) => n.isPinned == 1).length;

    // 2. Si intentamos poner pin y ya hay 2, mostrar un aviso (lanzar error)
    if (note.isPinned == 0 && pinnedCount >= 2) {
      throw Exception("Solo puedes anclar hasta 2 notas");
    }

    // 3. Crear la nota actualizada invirtiendo el valor de isPinned
    final updatedNote = Note(
      id: note.id,
      title: note.title,
      content: note.content,
      updatedAt: DateTime.now(),
      isPinned: note.isPinned == 0 ? 1 : 0,
    );

    // 4. Guardar en DB y refrescar
    await DBHelper.insertNote(updatedNote);
    await fetchAndSetNotes();
  }

  List<Note> searchNotes(String query) {
    if (query.isEmpty) {
      return _items;
    }

    return _items.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}