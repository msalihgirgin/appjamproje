  import 'package:hive_flutter/hive_flutter.dart';

  class ToDoDataBase {
    List toDoList=[];
    final _myBox = Hive.box("mybox");

    // uygulama ilk çalıştığında bu metodu çalıştır
    void createInitialData(){
      toDoList = [
        ["Akademi gorevlerini kontorl et", false],
        ["Slack' i kontrol et", false],
      ];
    }
      void loadData(){
        toDoList = _myBox.get("TODOLIST");

      }

      void updateDataBase(){
        _myBox.put("TODOLIST", toDoList);
      }

  }