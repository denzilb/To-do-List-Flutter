class TaskModel {
  int? id;
  String title;
  String description;
  bool completed;

  static const String tableName = 'tasks';
  static const String tableDefinition = '''CREATE TABLE tasks(
          id INTEGER PRIMARY KEY, 
          title TEXT, 
          description TEXT,
          completed INTEGER)''';

  TaskModel({
    this.id,
    this.title = '',
    this.description = '',
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed
    };
  }
}
