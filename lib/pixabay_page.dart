import 'package:flutter/material.dart';
import 'package:json_parse_demo/main.dart';
import 'package:json_parse_demo/model/pixabay_model.dart';

class PixabayPage extends StatefulWidget {
  const PixabayPage({Key? key}) : super(key: key);

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  late Future<Map<String, dynamic>> respose;

  Set<Hit> listHit = {};
  int page=1;

  @override
  void initState() {
    super.initState();

    callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PixabayPage")),
      body: FutureBuilder<Map<String, dynamic>>(
          future: respose,
          builder: (context, snap) {
            print(snap);
            if (snap.hasData) {
              var pixabayModel = PixabayModel.fromJson(snap.data ?? {});
              listHit.addAll(pixabayModel.hits ?? []);
              page++;

              return ListView.builder(
                itemCount: listHit.length,
                itemBuilder: (context, index) {
                  Hit hit = listHit.toList()[index];
                  return Container(
                    height: 250,
                    margin: EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(hit.largeImageUrl ?? "", fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(hit.userImageUrl ?? ""),
                            child: Text("$index"),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        callApi();
      }, child: Icon(Icons.refresh)),
    );
  }

  void callApi(){
    Map<String, dynamic> map = {
      "key": "39573727-1ab942b24088b42e3ebb356e6",
      "q": "white",
      "image_type": "illustration",
      "colors": "red",
      "per_page":"3",
      "page": "$page"
    };
    respose = helper.httpGet("", queryParam: map);
    setState(() {
    });
  }
}
