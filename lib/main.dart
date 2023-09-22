import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_parse_demo/HttpHelper.dart';
import 'package:json_parse_demo/model/todos.dart';
import 'package:json_parse_demo/model/users_list.dart';
import 'package:json_parse_demo/peoples.dart';
import 'package:json_parse_demo/pixabay_page.dart';
import 'package:json_parse_demo/student.dart';
import 'package:http/http.dart' as http;

late HttpHelper helper;

void main() {
  helper = HttpHelper("https://pixabay.com/");

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
  bool isLoading = false;

  // List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PixabayPage(),
                    ));
              },
              icon: Icon(Icons.add)),
        ],
      ),
      // body: isLoading ? CircularProgressIndicator() :ListView.builder(
      //   itemCount: users.length,
      //   itemBuilder: (context, index) {
      //     var user = users[index];
      //   return Container(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text(user.name??""),
      //   );
      // },),
      body: Column(
        children: [
          FutureBuilder(
            future: Future.delayed(Duration(seconds: 3), () => true),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return Text("Okay Done");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Expanded(
            child: FutureBuilder<http.Response>(
              future: http.get(Uri.parse("https://jsonplaceholder.typicode.com/users")),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var body = snapshot.data?.body ?? "";
                  List<User> users = userFromJson(body);
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index];
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(user.name ?? ""),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Map<String, dynamic> respose = await helper.httpGet("todos/1");
          // var todos = Todos.fromJson(respose);

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
