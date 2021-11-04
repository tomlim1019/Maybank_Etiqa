import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() {
  runApp(const MyApp());
}

class ToDo {
  String title;
  String startDate;
  String endDate;
  String timeLeft = "";
  String status = "Incomplete";
  bool isChecked = false;

  ToDo(this.title, this.startDate, this.endDate) {
    String time =
        DateTime.parse(endDate).difference(DateTime.now()).toString();
    int dot = time.indexOf(".");
    time = time.substring(0, dot);
    List<String> splitTime = time.split(":");
    int hrs = int.parse(splitTime[0]) % 24;
    int days = int.parse(splitTime[0]) ~/ 24;

    if (days > 0) {
      timeLeft = days.toString() +
          " days " +
          hrs.toString() +
          " hrs " +
          splitTime[1] +
          " mins ";
    }
  }

  updateTime() {
    String time = DateTime.parse(endDate).difference(DateTime.now()).toString();
    int dot = time.indexOf(".");
    time = time.substring(0, dot);
    List<String> splitTime = time.split(":");
    int hrs = int.parse(splitTime[0]) % 24;
    int days = int.parse(splitTime[0]) ~/ 24;

    if (days > 0) {
      timeLeft = days.toString() +
          " days " +
          hrs.toString() +
          " hrs " +
          splitTime[1] +
          " mins ";
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'To-Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color yellow = const Color(0xFFFEBD23);

  List<ToDo> todoList = [
    ToDo("Automated Testing Script", "2021-11-04", "2021-11-20")
  ];

  addToDo(int index, String title, String startDate, String endDate) {
    setState(() {
      todoList.add(ToDo(title, startDate, endDate));
    });
  }

  editToDo(int index, String title, String startDate, String endDate) {
    setState(() {
      todoList[index].title = title;
      todoList[index].startDate = startDate;
      todoList[index].endDate = endDate;

      todoList[index].updateTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: yellow,
        elevation: 0,
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        children: todoList
            .asMap()
            .map(
              (i, todo) => MapEntry(
                i,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToDoPage(
                            title: "Edit To-Do",
                            todoTitle: todo.title,
                            startDate: todo.startDate,
                            endDate: todo.endDate,
                            notifyParent: editToDo,
                            index: i),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xFFE7E3CF),
                    margin: const EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 8.0),
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: Column(
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 14.0, 10.0, 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todo.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Start Date",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFC5C5C5),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          todo.startDate,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "End Date",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFC5C5C5),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          todo.endDate,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Time Left",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFC5C5C5),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          todo.timeLeft,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          elevation: 0,
                          margin:
                              const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Status",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF99968A),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    todo.status,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Tick if completed",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF99968A),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    height: 14,
                                    width: 14,
                                    color: Colors.white,
                                    margin: EdgeInsets.zero,
                                    child: Transform.scale(
                                      scale: 0.7,
                                      child: Checkbox(
                                        activeColor: const Color(0xFFEB5820),
                                        value: todo.isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            todo.isChecked = value!;
                                            todo.status = (todo.isChecked)
                                                ? "Completed"
                                                : "Incomplete";
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDoPage(
                title: "Add new To-Do List",
                todoTitle: "",
                startDate: "Select a date",
                endDate: "Select a date",
                index: 0,
                notifyParent: addToDo,
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFEB5820),
        elevation: 5,
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFEFEFEF),
    );
  }
}

class AddToDoPage extends StatefulWidget {
  final Function(int, String, String, String) notifyParent;
  AddToDoPage(
      {Key? key,
      required this.title,
      required this.todoTitle,
      required this.startDate,
      required this.endDate,
      required this.index,
      required this.notifyParent})
      : super(key: key);

  final String title;
  String startDate;
  String endDate;
  String todoTitle;
  int index;
  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  Color yellow = const Color(0xFFFEBD23);
  var textController = TextEditingController();
  Color startDateColor = const Color(0xFFE1E1E1);
  Color endDateColor = const Color(0xFFE1E1E1);
  @override
  Widget build(BuildContext context) {
    String buttonText =
        (widget.title == "Edit To-Do") ? "Save Changes" : "Create Now";
    if (widget.title == "Edit To-Do") {
      textController.text = widget.todoTitle;
      textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
      startDateColor = Colors.black;
      endDateColor = Colors.black;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 16,
          color: Colors.black,
        ),
        titleSpacing: 0.0,
        backgroundColor: yellow,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 16, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "To-Do Title",
              style: TextStyle(
                color: Color(0xFFA6A6A6),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              height: 5 * 24.0,
              child: TextField(
                controller: textController,
                onChanged: (value) {
                  setState(() {
                    widget.todoTitle = value;
                  });
                },
                maxLines: 5,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: "Please key in your To-Do title here",
                  hintStyle: TextStyle(color: Color(0xFFE1E1E1)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
            const Text(
              "Start Date",
              style: TextStyle(
                color: Color(0xFFA6A6A6),
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                DatePicker.showDatePicker(
                  context,
                  currentTime: DateTime.now(),
                  minTime: DateTime(2020, 1, 1),
                  maxTime: DateTime(2025, 12, 31),
                  onConfirm: (date) {
                    setState(() {
                      widget.startDate = date.toString().substring(0, 10);
                      startDateColor = Colors.black;
                    });
                  },
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.startDate,
                      style: TextStyle(color: startDateColor),
                    ),
                    const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF6C6C6C), size: 20)
                  ],
                ),
              ),
            ),
            const Text(
              "Estimate End Date",
              style: TextStyle(
                color: Color(0xFFA6A6A6),
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                DatePicker.showDatePicker(
                  context,
                  currentTime: DateTime.now(),
                  minTime: DateTime(2020, 1, 1),
                  maxTime: DateTime(2025, 12, 31),
                  onConfirm: (date) {
                    setState(() {
                      widget.endDate = date.toString().substring(0, 10);
                      endDateColor = Colors.black;
                    });
                  },
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.endDate,
                      style: TextStyle(color: endDateColor),
                    ),
                    const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF6C6C6C), size: 20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          widget.notifyParent(
              widget.index, widget.todoTitle, widget.startDate, widget.endDate);
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          color: Colors.black,
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
