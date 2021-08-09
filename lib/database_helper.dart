import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task_model.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          TaskModel.tableDefinition,
        );
      },
      version: 2,
    );
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await database();

    await db.insert(
      TaskModel.tableName,
      task.toMap(),
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(TaskModel.tableName);
    return List.generate(
      maps.length,
      (index) => TaskModel(
          id: maps[index]['id'],
          title: maps[index]['title'],
          description: maps[index]['description'],
          completed: maps[index]['completed'] == 1),
    );
  }

  Future<void> updateTask(TaskModel task) async {
    if (task.id != null) {
      final db = await database();
      await db.update(
        TaskModel.tableName,
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    }
  }
}

class Table {
  final String task = 'tasks';
}
