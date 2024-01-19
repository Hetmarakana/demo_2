// import 'dart:html';

import 'dart:io';

import 'package:demo_2/second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'data.dart';

void main() {
  print("dsjjc");
  runApp(MaterialApp(
    home: Demo(),
  ));
}

class Demo extends StatefulWidget {
  Map? m;

  Demo([this.m]);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  TextEditingController t3 = new TextEditingController();
  TextEditingController t4 = new TextEditingController();
  final ImagePicker picker = new ImagePicker();
  XFile? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.m != null) {
      t1.text = widget.m!['name'];
      print(t1.text);
      t2.text = widget.m!['contact'];
      t3.text = widget.m!['email'];
      t4.text = widget.m!['pass'];
    }

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
          ElevatedButton(
              onPressed: () {
                if (widget.m != null) {
                  widget.m!['name'] = t1.text;
                  print(widget.m!['name'] = t1.text);
                  widget.m!['contact'] = t2.text;
                  widget.m!['email'] = t3.text;
                  widget.m!['pass'] = t4.text;
                  String sql =
                      "UPDATE `demo` SET `name`='${t1.text}',`contact`='${t2.text}',`email`='${t3.text}',`pass`='${t4.text}' WHERE id=${widget.m!['id']}";

                  database!.rawUpdate(sql);
                } else {
                  String str =
                      "insert into Demo values(NULL, '${t1.text}', '${t2.text}', '${t3.text}', '${t4.text}', '${image!.path})";
                  database!.rawInsert(str).then((value) {
                    print(value);
                  });
                }
              },
              child: Text("Save")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Second(),
                    ));
              },
              child: Text("view")),
          Row(
            children: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("Please upload your profile picture"),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    image = await picker.pickImage(
                                        source: ImageSource.camera);
                                  },
                                  child: Text("Camera")),
                              TextButton(
                                  onPressed: () async {
                                    image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                  },
                                  child: Text("Gallery")),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Profile Photo")),
              ),
              (image!=null)?Container(
                height: 100,
                width: 100,
                child: Image.file(File(image!.path)),
              )
                  :
                  Container(),
            ],
          ),
        ],
      ),
    );
  }
}
