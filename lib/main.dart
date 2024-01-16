import 'package:demo_2/second.dart';
import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(MaterialApp(
    home: Demo(),
  ));
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  TextEditingController t3 = new TextEditingController();
  TextEditingController t4 = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: t1,
              decoration: InputDecoration(hintText: "Enter name :-"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: t2,
              decoration: InputDecoration(hintText: "Enter contact :-"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: t3,
              decoration: InputDecoration(hintText: "Enter email :-"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: t4,
              obscureText: true,
              decoration: InputDecoration(hintText: "Enter pass :-"),
            ),
          ),
          ElevatedButton(onPressed: () {
            String str = "insert into Demo values(NULL, '${t1.text}', '${t2
                .text}', '${t3.text}', '${t4.text}')";
            database!.rawInsert(str).then((value) {
              print(value);
            });
          }, child: Text("Save")),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Second(),));
          }, child: Text("view"))
        ],
      ),
    );
  }
}
