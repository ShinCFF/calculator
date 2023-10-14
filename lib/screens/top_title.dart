import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const TopTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 5,
      title: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: const TextStyle(fontSize: 45),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
