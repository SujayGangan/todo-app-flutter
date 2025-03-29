import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> toDos = [
    'Create Flutter Project',
    'Create Progress Report',
    'Complete Assignment'
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController todo = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-do App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: (toDos.isEmpty)
          ? Center(
              child: Text(
                'No tasks available,\nTry adding some.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: toDos.length,
              itemBuilder: (context, index) => Dismissible(
                key: Key(toDos[index]),
                onDismissed: (direction) {
                  setState(() {
                    toDos.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task removed')),
                  );
                },
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(201, 255, 193, 7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 56,
                  width: double.infinity,
                  child: Text(
                    toDos[index],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 28,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 246, 200, 31)),
                  child: Column(
                    children: [
                      TextField(
                        controller: todo,
                        decoration:
                            InputDecoration(labelText: 'Enter task\'s title'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (todo.text.trim().isNotEmpty) {
                            setState(() {
                              toDos.add(todo.text);
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Add task'),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
