import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo App",
      home: ToDo(),
    );
  }
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

List<Task> taskLists = [];

TextEditingController taskController = TextEditingController();

class _ToDoState extends State<ToDo> {
  Color bgColor = const Color(0xFFEEEFF5);
  Color blueColor = const Color(0xFF5F52EE);

  addTasks(String task) {
    setState(() {
      taskLists.add(Task(
        taskText: task,
      ));
      taskController.clear();
    });
  }

  deleteTask(int index) {
    setState(() {
      taskLists.removeAt(index);
    });
  }

  toggle(int index) {
    setState(() {
      taskLists[index].isCompleted = !taskLists[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          //Also If Don't wanna use the Container then use ClipRRect.
          SizedBox(
            height: 40,
            width: 40,
            // color: Colors.amber,
            child: Image.asset("assets/images/Profilee.png"),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: taskController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.notes),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      filled: true,
                      fillColor: bgColor,
                      label: const Text("Task"),
                      hintText: "Enter Task",
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    if (taskController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Your task field is Empty!")));
                    } else {
                      addTasks(taskController.text);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "All ToDo's",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskLists.length,
              itemBuilder: (context, index) {
                final task = taskLists[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    tileColor: Colors.white,
                    title: Text(
                      task.taskText,
                      style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        toggle(index);
                      },
                      child: Icon(
                        task.isCompleted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: blueColor,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        deleteTask(index);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  String taskText;
  bool isCompleted;
  Task({required this.taskText, this.isCompleted = false});
}
