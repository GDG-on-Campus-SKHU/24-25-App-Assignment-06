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
  List<Goal> goals = [
  ];

  @override
  void initState() { //초기에 실행하는 부분
    super.initState();
    database = GoalDatabase.instance;
    _loadGoals(); //이 화면이 실행될 때마다 로딩
  }

  /// 데이터베이스에서 모든 할 일 항목을 불러와 리스트에 저장
  Future<void> _loadGoals() async {
    goals = await database.getGoals();
    setState(() {});
  }

  /// 새로운 할 일 항목을 추가하기 위해 다이얼로그를 표시하고, 입력받은 데이터를 데이터베이스에 저장
  Future<void> _addGoal() async {
    String title = "";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('목표 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: const InputDecoration(hintText: "목표 제목"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (title.isNotEmpty) {
                  final goal = Goal(title: title,);
                  await database.addGoal(goal);
                  await _loadGoals();
                  Navigator.of(context).pop();
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
  Future<void> _deleteGoal(int id) async {
    await database.deleteGoal(id);
    await _loadGoals();
  }

  static const TextStyle style15 = TextStyle(
    fontSize: 15.0,
    color: Colors.grey,
  ); //크기가 15인 텍스트스타일

  static const TextStyle style20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ); //크기가 20인 텍스트 스타일
  
  Widget _myGoals() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (_, index) {
          final goal = goals[index];
          return ListTile(
            title: Text(goal.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteGoal(goal.id!),
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
          title: const Text('My Profile', style: TextStyle(color: Colors.white),),
          actions: [
          IconButton(
            onPressed: _addGoal,
            icon: const Icon(Icons.add),
          ),
        ],
          backgroundColor: const Color.fromARGB(255, 133, 220, 255),
          centerTitle: true,
        ),
        body: Padding( //여백 넣기
            padding: const EdgeInsets.all(16.0),
            child: Column( //전체 위젯을 세로로 구성
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container( //프로필 이미지
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/miu.jpeg"),
                        fit: BoxFit.fill)
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const Divider( // 수평선
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  const SizedBox(height: 15,),
                  Column( // text 왼쪽 정렬
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'name',
                        style: style15,
                        textAlign: TextAlign.start,
                      ), // name
                      const Text(
                        'Choi DaYeon',
                        style: style20,
                        textAlign: TextAlign.start,
                      ),// myname
                      const SizedBox(height: 15),
                      const Text(
                        'Github ID',
                        style: style15,
                        textAlign: TextAlign.start,
                      ), // git id
                      const Text(
                        '@choi-day',
                        style: style20,
                        textAlign: TextAlign.start,
                      ), // mygit id
                      const SizedBox(height: 15,),
                      const Text(
                        'Introduce Me,,,',
                        style: style20,
                        textAlign: TextAlign.start,
                      ), // intro~
                      SizedBox( //listview 크기 조절
                        height: 80,
                        child: ListView(
                          children: const <Widget>[
                            SizedBox(
                              height: 40,
                              child: ListTile(
                                leading: Icon(
                                    Icons.call,
                                    color: Colors.grey,
                                    size: 15.0
                                  ),
                                  title: Text(
                                    '+82 0107xxx5xxx',
                                    style: TextStyle(
                                      fontSize: 15.0
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: ListTile(
                                  leading: Icon(
                                    Icons.cake,
                                    color: Colors.grey,
                                    size: 15.0,
                                  ),
                                  title: Text(
                                    '18, July',
                                    style: TextStyle(
                                      fontSize: 15.0
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                              ),
                            )
                          ],
                        ),
                      ), //자기소개
                      const SizedBox(height: 25,),
                      const Text(
                        '2025 Goals',
                        style: style20,
                        textAlign: TextAlign.start,
                      ), 
                      _myGoals(),
                    ],
                  ) //mygoals
                ]
              )
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