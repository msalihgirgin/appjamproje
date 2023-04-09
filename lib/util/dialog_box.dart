import 'package:appjamproje/util/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({Key? key, required this.controller, required this.onSave, required this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.brown[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          //kullanıcıdan veri al
          TextField(
            controller: controller,
            decoration: InputDecoration(border: OutlineInputBorder(),
            hintText: "Yeni bir görev ekle"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //kaydet butonu
              MyButton(text: "Kaydet", onPressed: onSave),
              const SizedBox(width: 20,),

              //iptal butonu
              MyButton(text: "İptal", onPressed: onCancel),
            ],
          ),

          //butonlar =>kaydet veya sil
        ],),
      ),
    );
  }
}
