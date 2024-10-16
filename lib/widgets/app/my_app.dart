import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/group_form/group_form_widget.dart';
import 'package:to_do_list/widgets/groups/groups_widget.dart';
import 'package:to_do_list/widgets/task_form/task_form_widget.dart';
import 'package:to_do_list/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/groups': (context) => const GroupsWidget(),
        '/groups/form': (context) => const GroupFormWidget(),
        '/groups/tasks': (context) => const TasksWidget(),
        '/groups/tasks/form': (context) => const TaskFormWidget(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/groups',
    );
  }
}
