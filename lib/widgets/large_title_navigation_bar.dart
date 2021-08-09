import 'package:flutter/material.dart';

class LargeTitleNavigationBar extends StatelessWidget {
  final String title;
  const LargeTitleNavigationBar({Key? key, this.title = 'Title'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
