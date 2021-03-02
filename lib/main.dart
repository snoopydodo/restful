import 'package:flutter/material.dart';
import 'package:restful_test/next.dart';
import 'dart:convert';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Http',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}



Future<ShopingPullData> fetchAlbum() async {
  var http;
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ShopingPullData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ShopingPullData {
  String name;
  String price;
  String image;
  String color;
 
  ShopingPullData({this.name, this.price, this.image, this.color});
 
  ShopingPullData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
    color = json['color'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['color'] = this.color;
    return data;
  }
}
 

 
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping'),
        ),
        body: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data.JSON'),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              var newData = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    //color: Colors.newData['color']),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Temp(index)
                                )
                                );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32, bottom: 32, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    newData[index]['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                
                                Text(
                                  newData[index]['price'],
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(newData[index]['image']),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: newData == null ? 0 : newData.length,
              );
            },
          ),
        ));
  }
}