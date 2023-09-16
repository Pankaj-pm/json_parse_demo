import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_parse_demo/peoples.dart';
import 'package:json_parse_demo/student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Map<String, dynamic>? jsonData;
  Student? student;
  Peoples? peoples;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 22),
                children: [
                  TextSpan(text: "First Name :\t", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(text: "${student?.firstName}\n"),
                  TextSpan(text: "Last Name :\t", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(text: "${student?.lastName}\n"),
                  TextSpan(
                      text: "Address :\t\t\t\t\t", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(text: "${student?.address}\n"),
                  TextSpan(
                      text: "id :\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(text: "${student?.id}\n"),
                  TextSpan(
                      text: "AGe :\t\t\t\t\t\t\t\t\t\t\t\t\t",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(text: "${student?.age}\n"),
                ],
              ),
            ),
            Expanded(child: ListView.builder(
              itemBuilder: (context, index) {
                Person person=peoples!.people![index];
                return Container(
                  color: Colors.black12,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name : ${person.firstName}"),
                      Text("Last Name : ${person.lastName}"),
                      Text("Gender : ${person.gender}"),
                      Text("Age : ${person.age}"),
                      Text("Number : ${person.number}"),
                    ],
                  ),
                );
              },
              itemCount: peoples?.people?.length??0,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String data =
              "{\"first_name\":\"Meettt\",\"last_name\":\"patel\",\"address\":\"150ringroadrajkot\",\"id\":0,\"age\":22.5}";
          // Map<String,dynamic> jsonData = jsonDecode(data);
          student = Student.fromRawJson(data);

          rootBundle.loadString("assets/sample4.json").then((value) {
            print("value $value");
            peoples = Peoples.fromRawJson(value);
            setState(() {});
          });
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
