import 'package:flutter/material.dart';
import 'package:to_do_list/ui/navigation/main_navigation.dart';
import 'package:to_do_list/ui/widgets/group_form/group_form_widget.dart';
import 'package:to_do_list/ui/widgets/groups/groups_widget.dart';
import 'package:to_do_list/ui/widgets/task_form/task_form_widget.dart';
import 'package:to_do_list/ui/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
        MainNavigationRouteNames.groupsForm: (context) => const GroupFormWidget(),
        MainNavigationRouteNames.tasks: (context) => const TasksWidget(),
        MainNavigationRouteNames.tasksForm: (context) => const TaskFormWidget(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: MainNavigationRouteNames.groups,
    );
  }
}
