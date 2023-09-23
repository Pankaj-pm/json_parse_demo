import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_parse_demo/main.dart';
import 'package:json_parse_demo/model/phones_model.dart';

class PostApiDemo extends StatefulWidget {
  const PostApiDemo({Key? key}) : super(key: key);

  @override
  State<PostApiDemo> createState() => _PostApiDemoState();
}

class _PostApiDemoState extends State<PostApiDemo> {
  late Future<http.Response> future;
  StreamController<Phones> _controller=StreamController();

  @override
  void initState() {
    // var httpGet = helper.httpGet("objects");
    future = http.get(Uri.parse("https://api.restful-api.dev/objects"));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PostApiDemo")),
      body: Column(
        children: [
          StreamBuilder<Phones>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              Phones phoneItem =snapshot.data??Phones();
              return Column(
                children: [
                  Text(
                    phoneItem.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text("year = ${phoneItem.data?.year ?? ""}"),
                  Text("price = ${phoneItem.data?.price ?? ""}"),
                  Text("CPU model = ${phoneItem.data?.cpuModel??""}"),
                  Text("Hard disk size = ${phoneItem.data?.hardDiskSize??""}"),
                ],
              );
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data?.body != null) {
                  var phonesList = phonesFromJson(snapshot.data?.body ?? "");
                  return ListView.builder(
                    itemCount: phonesList.length,
                    itemBuilder: (context, index) {
                      var phoneItem = phonesList[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              phoneItem.name ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            if (phoneItem.data?.color != null) Text("Color = ${phoneItem.data?.color ?? "-"}"),
                            if (phoneItem.data?.capacity != null) Text("Capacity = ${phoneItem.data?.capacity ?? ""}"),
                            if (phoneItem.data?.capacityGb != null) Text("capacity GB = ${phoneItem.data?.capacityGb}"),
                            if (phoneItem.data?.price != null) Text("price = ${phoneItem.data?.price}"),
                            if (phoneItem.data?.generation != null) Text("generation = ${phoneItem.data?.generation}"),
                            if (phoneItem.data?.year != null) Text("year = ${phoneItem.data?.year}"),
                            if (phoneItem.data?.cpuModel != null) Text("CPU model = ${phoneItem.data?.cpuModel}"),
                            if (phoneItem.data?.hardDiskSize != null)
                              Text("Hard disk size = ${phoneItem.data?.hardDiskSize}"),
                          ],
                        ),
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
        onPressed: () async{
          Map<String,dynamic> map={
            "name": "Apple MacBook Pro 16",
            "data": {
              "year": 2019,
              "price": 1849.99,
              "CPU model": "Intel Core i9",
              "Hard disk size": "1 TB"
            }
          };

          Map<String,dynamic> responseMap = await helper.httpPost("objects", jsonEncode(map));
          var phones = Phones.fromJson(responseMap);
          _controller.add(phones);
          print(responseMap);
        },
      ),
    );
  }
}
