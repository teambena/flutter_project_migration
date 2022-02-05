import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detailsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _saved = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: Text('EHE COOKING',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.amber[800],
                fontWeight: FontWeight.bold,
                fontSize: 25.0)),
        actions: [
          IconButton(
            color: Colors.amber[800],
            icon: Icon(Icons.home),
            onPressed: () {
            },
          ),
          IconButton(
            color: Colors.amber[800],
            icon: Icon(Icons.list),
            onPressed: () {
              _pushSaved();
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0.0, 1.0),
                end: Alignment(0.0, -1.0),
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark,
                ]
            )
        ),
        child: ListView(
          children: <Widget>[

            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Text('Food',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0)),
                  SizedBox(width: 10.0),
                  Text('Menu',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 25.0))
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height - 180.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 45.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height - 300.0,
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              var data = json.decode(snapshot.data.toString());
                              return ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildFoodItem(
                                      data[index]['id'],
                                      data[index]['imgPath'],
                                      data[index]['name'],
                                      data[index]['price']);
                                },
                                itemCount: data.length,
                              );
                            },
                            future: DefaultAssetBundle.of(context)
                                .loadString('assets/data.json'),
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(int id, String imgPath, String foodName, String price) {
    final alreadySaved = _saved.contains(foodName);

    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsPage(
                    id: id,
                    heroTag: imgPath,
                    foodName: foodName,
                    foodPrice: price)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Row(children: [
                    Hero(
                        tag: imgPath,
                        child: Image(
                            image: AssetImage(imgPath),
                            fit: BoxFit.cover,
                            height: 75.0,
                            width: 75.0)),
                    SizedBox(width: 10.0),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(foodName,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold)),
                    ])
                  ])),
              IconButton(
                  icon: Icon(
                      alreadySaved ? Icons.favorite : Icons.favorite_border,
                      color: alreadySaved ? Colors.red : null),
                  onPressed: () {
                    setState(() {
                      if (alreadySaved) {
                        _saved.remove(foodName);
                      } else {
                        _saved.add(foodName);
                      }
                    });
                  })
            ],
          )),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final tiles = _saved.map((String foodName) {
        return ListTile(title: Text(foodName, style: TextStyle(fontSize: 16)));
      });

      final divided =
      ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.amber[800], title: Text('Favorite Menu')),
          body: ListView(children: divided));
    }));
  }


}
