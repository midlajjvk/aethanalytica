import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("task_box");

  runApp(MaterialApp(
    home: HiveEx(),
  ));
}   

class HiveEx extends StatefulWidget {
  const HiveEx({super.key});

  @override
  State<HiveEx> createState() => _HiveExState();
}

class _HiveExState extends State<HiveEx> {
  List<Map<String, dynamic>> tasks = [];
  final tbox = Hive.box("task_box");

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() {
    final data = tbox.keys.map((id) {
      final value = tbox.get(id);
      return {
        'key': id,
        'title': value['title'],
        'subtitle': value['subtitle']
      };
    }).toList();

    setState(() {
      tasks = data.toList();
    });
  }

  Future<void> createTask(Map<String, dynamic> task) async {
    await tbox.add(task);
    loadTasks();
  }

  Future<void> updateTask(int key, Map<String, dynamic> upTask) async {
    await tbox.put(key, upTask);
    loadTasks();
  }

  Future<void> deleteTask(int key) async {
    await tbox.delete(key);
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: tasks.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task['title'] ?? ''),
                    subtitle: Text(task['subtitle'] ?? ''),
                    trailing: SizedBox(
                      child: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                showForm(context, task['key']);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                tbox.delete(task['key']);
                                loadTasks();
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  void showForm(BuildContext context, int? id) {
    if (id != null) {
      final existingTask = tasks.firstWhere((element) => element['key'] == id);
      _titleController.text = existingTask['title'];
      _subtitleController.text = existingTask['subtitle'];
    } else {
      _titleController.clear();
      _subtitleController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _subtitleController,
                decoration: InputDecoration(
                  hintText: 'Subtitle',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (id == null) {
                    createTask({
                      'title': _titleController.text,
                      'subtitle': _subtitleController.text
                    });
                  }
                  if (id != null) {
                    updateTask(id, {
                      'title': _titleController.text,
                      'subtitle': _subtitleController.text
                    });
                  }
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}
