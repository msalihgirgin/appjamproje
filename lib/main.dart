

import 'package:appjamproje/data/database.dart';
import 'package:appjamproje/util/dialog_box.dart';
import 'package:appjamproje/util/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async {

 await Hive.initFlutter();
 var box = await Hive.openBox("mybox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const  MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {

    //uygulama ilk defa açıldığında ilk yaratılacak data
    if(_myBox.get("TODOLIST")==null ){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }
  final _controller = TextEditingController();
  //todolist in listesi

  //checkbox işaretli
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] =! db.toDoList[index][1];

    });
    db.updateDataBase();
  }
  //yeni görevi kaydet
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  //yeni görev yarat
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel:()=>Navigator.of(context).pop(),
      );
    });
  }
  //mevcut görevi sil
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("AppJam Yapılacaklar Listesi"),
        centerTitle: true,
        elevation: 20,


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add)
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context,index) {
          return ToDoTile(taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) =>checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
          );
        }

      ),
    );

  }

}