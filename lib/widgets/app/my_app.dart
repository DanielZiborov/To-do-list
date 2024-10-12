import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/groups': (context) => const GroupsWidget(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/groups',
    );
  }
}
