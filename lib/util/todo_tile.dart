import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
    ToDoTile({Key? key, required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteFunction}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left:25,top: 25, right: 25),

      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete_forever,
                backgroundColor: Colors.black,
                borderRadius: BorderRadius.circular(12),),


          ],
        ),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              //chechbox
              Checkbox(value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,),
              //task name
              Text(
                  taskName,
                  style: TextStyle(decoration:taskCompleted? TextDecoration.lineThrough : TextDecoration.none, color: Colors.black)),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.brown[200],
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
