import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/widgets/large_title_navigation_bar.dart';
import 'package:todo_list/widgets/task_item.dart';

import '../database_helper.dart';
import 'task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TaskModel> tasks = [];
  void showTask(TaskModel task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskScreen(task: task),
      ),
    ).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LargeTitleNavigationBar(title: 'Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new task',
        onPressed: () {
          showTask(TaskModel());
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: SafeArea(
          bottom: false,
          child: FutureBuilder<List<TaskModel>>(
            future: databaseHelper.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                tasks = snapshot.data!;
                if (snapshot.data!.length != 0) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 8, bottom: 115),
                    itemCount: snapshot.data!.length + 1,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 8.0),
                          child: Text(
                            '${tasks.where((element) => element.completed).length} of ${tasks.length} task${tasks.length > 1 ? 's' : ''} completed',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }
                      TaskModel task = snapshot.data![index - 1];
                      return GestureDetector(
                        onTap: () {
                          showTask(task);
                        },
                        child: TaskItem(
                          task,
                          checkChanged: (checked) async {
                            task.completed = checked!;
                            databaseHelper.updateTask(task);
                            setState(() {});
                          },
                        ),
                      );
                    },
                  );
                }
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Icon(
                        Icons.add_task,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'You do not have any tasks.\nCreate your first task by tapping the + button below.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
