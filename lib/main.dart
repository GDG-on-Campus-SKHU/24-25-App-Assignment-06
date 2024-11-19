import 'package:flutter/material.dart';

void main() {
  runApp(MyProfileApp());
}

class MyProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyProfile(),
    );
  }
}

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  
  List<Map<String, String>> goals = [
   
  ];

 
  void _addGoal(String goalText) {
    setState(() {
      goals.add({'icon': 'Icons.star', 'text': goalText});
    });
  }

  
  void _deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  
  void _showAddGoalDialog() {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('새 Goal 추가'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Goal 입력'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _addGoal(_controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyProfile'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 76, 109, 138),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddGoalDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage('assets/images/KakaoTalk_20241022_235349121.png'),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'NAME',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '이민용',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'GITHUB ID',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '@myllli',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Introduce Me,,',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+82 010-4312-6243'),
            ),
            ListTile(
              leading: Icon(Icons.cake),
              title: Text('25, September'),
            ),
            SizedBox(height: 20),
            Text(
              '2025 Goals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.check),
                    title: Text(goals[index]['text']!),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteGoal(index),
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
}
