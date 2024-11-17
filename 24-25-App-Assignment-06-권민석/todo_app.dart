import 'package:flutter/material.dart';
import 'package:flutter_assignment_04/todo.dart';
import 'package:flutter_assignment_04/todo_database.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late TodoDatabase database;
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    database = TodoDatabase.instance;
    _loadTodos();
  }

  /// 데이터베이스에서 모든 할 일 항목을 불러와 리스트에 저장
  Future<void> _loadTodos() async {
    todos = await database.getTodos();
    setState(() {});
  }

  /// 새로운 할 일 항목을 추가하기 위해 다이얼로그를 표시하고, 입력받은 데이터를 데이터베이스에 저장
  Future<void> _addTodo() async {
    String? title;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('목표 추가'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "목표 제목",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '목표를 입력하세요.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop();
                  final todo = Todo(
                    title: title ?? "Untitled",
                    description: "write",
                  );
                  await database.addTodo(todo);
                  await _loadTodos();
                }
              },
              child: const Text("추가하기"),
            ),
          ],
        );
      },
    );
  }

  /// 선택된 할 일 항목을 데이터베이스에서 삭제하고 리스트를 업데이트
  Future<void> _deleteTodo(int id) async {
    await database.deleteTodo(id);
    await _loadTodos();
  }

  Future<void> _changeTodo(int id) async {
    await database.deleteTodo(id);
    await _addTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _addTodo,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 140, top: 55.0, bottom: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  'assets/images/GDG_me.JPG',
                  width: 150.0, // 원하는 width 값
                  height: 150.0, // 원하는 height 값
                  fit: BoxFit.cover, // 이미지를 원하는 방식으로 조정
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 35, bottom: 5.0),
              child: Container(
                height: 1.0,
                width: 360.0,
                color: Colors.grey,
              ),
            ),
            // ----------------- 이름 -----------------
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: 20,
              ),
              child: Text('Name',
                  style: TextStyle(
                    color: Color.fromARGB(255, 111, 111, 111),
                    fontSize: 15,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 5),
              child: Text('Kwon MinSeok',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  )),
            ),
            // ----------------- 깃허브 아이디 -----------------
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text('Github ID',
                  style: TextStyle(
                    color: Color.fromARGB(255, 111, 111, 111),
                    fontSize: 15,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 5),
              child: Text('@staralstjr',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  )),
            ),
            // ----------------- 자기소개 -----------------
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text('My Information',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  )),
            ),
            // ----------------- 전화번호 -----------------
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40, top: 10),
                  child: MaterialApp(
                      home: Icon(
                        Icons.call,
                        color: Color.fromARGB(255, 213, 40, 40),
                      ),
                      debugShowCheckedModeBanner: false),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Text('+82 01023993111',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 111, 111, 111),
                      )),
                ),
              ],
            ),
            // ----------------- 생일 -----------------
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 20, top: 20),
                  child: MaterialApp(
                      home: Icon(
                        Icons.cake,
                        color: Color.fromARGB(255, 177, 54, 147),
                      ),
                      debugShowCheckedModeBanner: false),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 0),
                  child: Text('23, April',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 111, 111, 111),
                      )),
                ),
              ],
              // ----------------- 새해 목표 -----------------
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text('2025 Goals',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: (_, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    trailing: SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _changeTodo(todo.id!);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteTodo(todo.id!),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    database.close();
    super.dispose();
  }
}
