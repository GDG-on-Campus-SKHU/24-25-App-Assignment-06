class Goal {
  // 변수 선언
  final int? id;
  final String title;

  // 생성자
  Goal({
    this.id,
    required this.title,
  });

  //객체를 Map으로 변환하여 데이터베이스에 저장
  Map<String, dynamic> toMap() {
    return{
      'id' : id,
      'title' : title,
    };
  }

  //데이터를 불러옴
  factory Goal.fromMap(Map<String, dynamic> map){
    return Goal(
      id: map['id'] as int?,
      title: map['title'] as String,
    );
  }
}