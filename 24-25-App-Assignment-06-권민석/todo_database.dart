import 'package:flutter_assignment_04/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;

  TodoDatabase._init();

  /// 데이터베이스 인스턴스를 초기화하여 Singleton 패턴으로 관리
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  /// 데이터베이스 파일을 생성하고, 테이블을 설정
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// todos 테이블을 생성하는 메서드
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  /// 새 할 일 항목을 데이터베이스에 추가
  Future<int> addTodo(Todo todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }

  /// 데이터베이스에서 모든 할 일 항목을 조회하여 리스트로 반환
  Future<List<Todo>> getTodos() async {
    final db = await instance.database;
    final result = await db.query('todos');
    return result.map((json) => Todo.fromMap(json)).toList();
  }

  /// 특정 id에 해당하는 할 일 항목을 삭제합
  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  /// 데이터베이스 연결을 닫기
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
