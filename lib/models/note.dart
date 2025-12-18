class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime updatedAt;
  final int isPinned;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
    this.isPinned = 0,
  });

  // Convierte una Nota en un Map para guardar en la DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'updatedAt': updatedAt.toIso8601String(),
      'isPinned': isPinned,
    };
  }

  // Convierte un Map de la DB en un objeto Nota
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      updatedAt: DateTime.parse(map['updatedAt']),
      isPinned: map['isPinned'] ?? 0,
    );
  }
}