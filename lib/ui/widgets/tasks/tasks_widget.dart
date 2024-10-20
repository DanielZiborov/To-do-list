import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/ui/widgets/tasks/tasks_widget_model.dart';

class TasksWidgetConfiguration {
  final int groupKey;
  final String title;

  TasksWidgetConfiguration(
    this.groupKey,
    this.title,
  );
}

class TasksWidget extends StatefulWidget {
  final TasksWidgetConfiguration configuration;
  const TasksWidget({super.key, required this.configuration});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TasksWidgetModel _model;

  @override
  void initState() {
    _model = TasksWidgetModel(configuration: widget.configuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
      model: _model,
      child: const TasksWidgetBody(),
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.configuration.title ?? "Tasks";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
      body: const _TaskListWidget(),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget();
  @override
  Widget build(BuildContext context) {
    final groupsCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 3);
      },
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(indexInList: index);
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({required this.indexInList});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)?.model;
    final task = model?.tasks[indexInList];

    final icon = task!.isDone ? Icons.done : null;
    final style = task.isDone
        ? const TextStyle(
            decoration: TextDecoration.lineThrough,
          )
        : null;

    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => model?.deleteTask(indexInList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(
            task.text,
            style: style,
          ),
          trailing: Icon(icon),
          onTap: () => model?.doneToggle(indexInList),
        ),
      ),
    );
  }
}
