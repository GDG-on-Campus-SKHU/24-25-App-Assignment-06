import 'package:flutter_assignment_04/goal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GoalDatabase {
  static final GoalDatabase instance = GoalDatabase._init();
  static Database? _database;
  
  GoalDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB('goals.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async{
    await db.execute('''
      CREATE TABLE goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL
      )
    ''');
  }

  Future<int> addGoal(Goal goal) async{
    final db = await instance.database;
    return await db.insert('goals', goal.toMap());
  }

  Future<List<Goal>> getGoals() async{
    final db = await instance.database;
    final result = await db.query('goals');
    return result.map((json) => Goal.fromMap(json)).toList();
  }
  
  Future<int> deleteGoal(int id) async{
    final db = await instance.database;
    return await db.delete('goals', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editGoal(int id, Goal goal) async {
    final db = await instance.database;
    return await db.update('goals', goal.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}