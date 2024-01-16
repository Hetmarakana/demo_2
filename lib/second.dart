import 'package:demo_2/data.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  List l = [];

  get() async {
    String sql = "select * from Demo";
    l = await database!.rawQuery(sql);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    return ListTile(trailing: IconButton(onPressed: () {
                      String sql="delete from Demo where id=${l[index]['id']}";
                      database!.rawDelete(sql).then((value) {
                        print("delete the recode ${l[index]['id']}");
                      });
                      setState(() {

                      });
                    }, icon: Icon(Icons.delete)),
                      title: Text("${l[index]['name']}"),
                    );
                  },
                );
              }
              return LoadingIndicator(
                  indicatorType: Indicator.pacman,
                  colors: const [Colors.white],
                  strokeWidth: 2,
                  backgroundColor: Colors.black,
                  pathBackgroundColor: Colors.black);
            } else {
              return Center(
                child: LoadingIndicator(
                    indicatorType: Indicator.triangleSkewSpin,
                    colors: const [
                      Colors.lightBlueAccent,
                      Colors.red,
                      Colors.black
                    ],
                    strokeWidth: 100,
                    // backgroundColor: Colors.black,
                    pathBackgroundColor: Colors.black),
              );
            }
          },
          future: get(),
        ));
  }
}
