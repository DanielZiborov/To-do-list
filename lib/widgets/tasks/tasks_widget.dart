import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
      model: _model!,
      child: const TasksWidgetBody(),
    );
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? "Tasks";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
      body: Container(),
    );
  }
}
