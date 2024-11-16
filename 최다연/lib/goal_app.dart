import 'package:flutter/material.dart';
import 'package:flutter_assignment_04/goal.dart';
import 'package:flutter_assignment_04/goal_database.dart';

class GoalApp extends StatefulWidget {
  const GoalApp({super.key});

  @override
  State<GoalApp> createState() => _GoalAppState();
}

class _GoalAppState extends State<GoalApp> {
  late GoalDatabase database;
  List<Goal> goals = [];

  @override
  void initState() {
    super.initState();
    database = GoalDatabase.instance;
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    goals = await database.getGoals();
    setState(() {});
  }

  Future<void> _addGoal() async {
    String title = "";
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('목표 추가'),
        content: Form(
          key: formKey,
          child: TextFormField(
            onChanged: (value) {
              title = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '목표를 입력하세요';
              }
              return null;
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final goal = Goal(title: title);
                await database.addGoal(goal);
                await _loadGoals();
                Navigator.of(context).pop();
              }
            },
            child: const Text("추가하기"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteGoal(int id) async {
    await database.deleteGoal(id);
    await _loadGoals();
  }

  Future<void> _editGoal(int id) async {
    String title = "";
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('목표 수정'),
        content: Form(
          key: formKey,
          child: TextFormField(
            onChanged: (value) {
              title = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '목표를 입력하세요';
              }
              return null;
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final goal = Goal(id: id, title: title);
                await database.editGoal(id, goal);
                await _loadGoals();
                Navigator.of(context).pop();
              }
            },
            child: const Text("수정하기"),
          ),
        ],
      ),
    );
  }

  static const TextStyle style15 = TextStyle(fontSize: 18.0, color: Colors.grey);
  static const TextStyle style20 = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  Widget _myGoals() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (_, index) {
          final goal = goals[index];
          return ListTile(
            title: Text(goal.title),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit), 
                    onPressed: () => _editGoal(goal.id!),),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteGoal(goal.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyProfilePage',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 133, 220, 255),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _addGoal,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/miu.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(color: Colors.grey, thickness: 2),
                const SizedBox(height: 15),
                const Text('name', style: style15),
                const Text('Choi DaYeon', style: style20),
                const SizedBox(height: 15),
                const Text('Github ID', style: style15),
                const Text('@choi-day', style: style20),
                const SizedBox(height: 15),
                const Text('Introduce Me,,,', style: style20),
                SizedBox(
                  height: 80,
                  child: ListView(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.call, color: Colors.grey, size: 15.0),
                        title: Text('+82 0107xxx5xxx'),
                      ),
                      ListTile(
                        leading: Icon(Icons.cake, color: Colors.grey, size: 15.0),
                        title: Text('18, July'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const Text('2025 Goals', style: style20),
                _myGoals(),
              ],
            ),
          ),
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