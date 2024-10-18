import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/domain/data_provider/box_manager.dart';
import 'package:to_do_list/domain/entity/group.dart';
import 'package:to_do_list/ui/navigation/main_navigation.dart';

class GroupsWidgetModel extends ChangeNotifier {
  late final Future<Box<Group>> _box;
  var _groups = <Group>[];

  GroupsWidgetModel() {
    setUp();
  }

  List<Group> get groups => _groups.toList();

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.groupsForm);
  }

  Future<void> showTasks(BuildContext context, int groupIndex) async {

    final groupKey = (await _box).keyAt(groupIndex) as int;

    await Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.tasks, arguments: groupKey);
  }

  Future<void> _readGroupsFromHive() async {
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> setUp() async {
    _box = BoxManager.instance.openGroupBox();
    await BoxManager.instance.openTaskBox();
    await _readGroupsFromHive();

    (await _box).listenable().addListener(_readGroupsFromHive);
  }

  Future<void> deleteGroup(int groupIndex) async {
    final box = await _box;
    await BoxManager.instance.openTaskBox();
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);
  }
}

class GroupsWidgetModelProvider extends InheritedNotifier {
  final GroupsWidgetModel model;
  const GroupsWidgetModelProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(notifier: model);

  static GroupsWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }

  static GroupsWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()
        ?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GroupsWidgetModelProvider oldWidget) {
    return true;
  }
}
