import 'dart:convert';

import 'package:flutter/material.dart';
class Temp extends StatefulWidget {
  
  final int id;

  Temp(this.id);

  @override
  _TempState createState() => _TempState();
}


class _TempState extends State<Temp> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
                .loadString('assets/data.JSON'),
        builder: (context, snapshot) {

          var newData = json.decode(snapshot.data.toString());
        return Center(
          
          child: 
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
                 Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    newData[widget.id]['name'],textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 30),
                                  ),
                                Container(
                              height: 500,
                              width: 500,
                              child: Image.asset(newData[widget.id]['image']),
                            ),
                                
                              ],
                            ),
                            

            ],
        ),);
        },),
   );
    
  }
}