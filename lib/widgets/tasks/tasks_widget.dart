import 'package:flutter/material.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  void didChangeDependencies() {
    final groupKey = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body: Container(
        
      ),
    );
  }
}