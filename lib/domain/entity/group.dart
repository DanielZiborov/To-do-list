import 'package:hive/hive.dart';
import 'package:to_do_list/domain/entity/task.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  HiveList<Task>? tasks;

  Group({
    required this.name,
  });

  void addTask(Box<Task> tasksBox, Task task) {
    tasks ??= HiveList(tasksBox);
    tasks?.add(task);
    save();
  }
}
