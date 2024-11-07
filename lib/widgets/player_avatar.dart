import 'package:flutter/material.dart';

class PlayerAvatar extends StatelessWidget {
  final String name;
  final Color backgroundColor;

  const PlayerAvatar({
    required this.name,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _getInitials(name),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final names = name.split(' ');
    return names.length > 1
        ? '${names.first[0]}${names.last[0]}'
        : name[0];
  }
}