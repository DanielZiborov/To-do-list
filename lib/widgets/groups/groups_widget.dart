import 'package:flutter/material.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Группы",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const _GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupListWidget extends StatefulWidget {
  const _GroupListWidget();

  @override
  State<_GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<_GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 100,
      separatorBuilder: (BuildContext context, int index) {
        return _GroupListRowWidget(indexInList: index);
      },
      itemBuilder: (BuildContext context, int index) {
        return const Divider(height: 3);
      },
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({required this.indexInList});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text("sdjvnsdjk vnvjsnvj vehvnjvnsj"),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
