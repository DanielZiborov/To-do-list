import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/domain/entity/group.dart';
import 'package:to_do_list/domain/entity/task.dart';



class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;

  var _tasks = <Task>[];
 
  List<Task> get tasks => _tasks.toList();

  Group? _group;
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    setUp();
  }

  void loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void setUpListenTasks() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: [groupKey]).addListener(_readTasks);
  }

  void deleteTask(int groupIndex) async {
    await _group?.tasks?.deleteFromHive(groupIndex);
    _group?.save();
  }

  void setUp() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }

    _groupBox = Hive.openBox<Group>('groups_box');
    Hive.openBox<Task>('tasks_box');
    loadGroup();
    setUpListenTasks();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/tasks/form', arguments: groupKey);
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
