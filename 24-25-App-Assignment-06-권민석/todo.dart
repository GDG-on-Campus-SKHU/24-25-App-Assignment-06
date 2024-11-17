/// Todo 클래스는 각 할 일 항목을 나타내며, SQLite 데이터베이스와의 호환성을 위해
/// toMap 및 fromMap 메서드를 제공합니다.
class Todo {
  final int? id;
  final String title;
  final String description;

  Todo({
    this.id,
    required this.title,
    required this.description,
  });

  /// 객체를 Map으로 변환하여 데이터베이스에 저장
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  /// Map을 객체로 변환하여 데이터베이스로부터 데이터를 불러옴
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}
