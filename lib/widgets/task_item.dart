import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/extensions/string_extensions.dart';

typedef CheckChanged(bool? checked);

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final CheckChanged? checkChanged;

  const TaskItem(this.task, {this.checkChanged}) : super();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title.trim().length != 0
                        ? task.title.capitalise()
                        : 'Unnamed task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.completed ? Colors.grey : Colors.black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      task.description.trim().length != 0
                          ? task.description.length < 137
                              ? task.description
                              : task.description.substring(0, 136) + '...'
                          : 'No description added',
                      style: TextStyle(
                        decoration: task.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: task.completed,
              onChanged: checkChanged,
              shape: CircleBorder(side: BorderSide(style: BorderStyle.solid)),
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
