import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'notes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, updatedAt TEXT, isPinned INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertNote(Note note) async {
    final db = await DBHelper.database();
    await db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Note>> getNotes() async {
    final db = await DBHelper.database();
    // Ordena primero por isPinned (descendente, 1 antes que 0) 
    // y luego por fecha (más reciente arriba)
    final List<Map<String, dynamic>> maps = await db.query(
      'notes', 
      orderBy: 'isPinned DESC, updatedAt DESC'
    );
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }
}