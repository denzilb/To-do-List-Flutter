import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';

import '../database_helper.dart';

class TaskScreen extends StatefulWidget {
  final TaskModel task;
  TaskScreen({required this.task, Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String _title = '';
  String _description = '';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    log('Task id: ${widget.task.id}');
    _title = widget.task.title;
    _description = widget.task.description;
    _titleController.text = _title;
    _descriptionController.text = _description;
    super.initState();
  }

  void saveTask() async {
    if (_titleController.text.trim() != "") {
      DatabaseHelper databaseHelper = DatabaseHelper();
      widget.task.title = _titleController.text.trim();
      widget.task.description = _descriptionController.text.trim();
      if (widget.task.id == null) {
        await databaseHelper.insertTask(widget.task);
        log("Task has been created!");
      } else {
        await databaseHelper.updateTask(widget.task);
        log("Task has been updated!");
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                Spacer(),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Enter task title *',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 26,
                          ),
                          onSubmitted: (value) => saveTask(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: 'Enter description',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.task.id == null
                                  ? 'Add new task'
                                  : 'Update task',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            saveTask();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
