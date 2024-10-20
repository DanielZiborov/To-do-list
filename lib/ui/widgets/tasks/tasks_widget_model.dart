import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/domain/data_provider/box_manager.dart';
import 'package:to_do_list/domain/entity/task.dart';
import 'package:to_do_list/ui/navigation/main_navigation.dart';
import 'package:to_do_list/ui/widgets/tasks/tasks_widget.dart';

class TasksWidgetModel extends ChangeNotifier {
  TasksWidgetConfiguration configuration;
  late final Future<Box<Task>> _box;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  TasksWidgetModel({required this.configuration}) {
    setUp();
  }

  Future<void> _readTasksFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  Future<void> setUp() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    await _readTasksFromHive();
    (await _box).listenable().addListener(_readTasksFromHive);
  }

  void showForm(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.tasksForm, arguments: configuration.groupKey);
  }

  Future<void> doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(notifier: model);

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TasksWidgetModelProvider oldWidget) {
    return true;
  }
}
