import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatefulWidget {
  final id;
  final heroTag;
  final foodName;
  final foodPrice;
  final videoId;

  DetailsPage({this.id, this.heroTag, this.foodName, this.foodPrice, this.videoId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late List data;

  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/data.json');
    setState(() => data = json.decode(jsonText));
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  var selectedCard = 'WEIGHT';

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController (
        initialVideoId:  data[widget.id]['videoId'],
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ));
    return Scaffold(
        backgroundColor: Color(0xFF474973),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Details',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height + 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 75.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height + 200,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Hero(
                    tag: widget.heroTag,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.heroTag),
                                fit: BoxFit.cover)),
                        height: 200.0,
                        width: 200.0))),
            Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.foodName,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        height: 150.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildInfoCard(
                                'CALORIES', data[widget.id]['calories'], 'CAL'),
                            SizedBox(width: 10.0),
                            _buildInfoCard(
                                'PREP', data[widget.id]['prep'], 'Mins'),
                            SizedBox(width: 10.0),
                            _buildInfoCard(
                                'COOK', data[widget.id]['cook'], 'Mins'),
                            SizedBox(width: 10.0),
                            _buildInfoCard(
                                'TOTAL', data[widget.id]['total'], 'Hrs'),
                            SizedBox(width: 10.0),
                            _buildInfoCard(
                                'SERVINGS', data[widget.id]['servings'], ''),
                          ],
                        )),
                    SizedBox(height: 40.0),
                    Text('Ingredients',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Container(
                        height: 150.0,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            // CheckboxListTile(
                            //   title: Text(
                            //     data[widget.id]['ingredients']['1'],
                            //   ),
                            //   value: this.value1,
                            //   onChanged: (bool value1) {
                            //     setState(() {
                            //       this.value1 = value1;
                            //     });
                            //   },
                            //   controlAffinity: ListTileControlAffinity
                            //       .leading, //  <-- leading Checkbox
                            // ),
                            // IconButton
                            Text(
                              data[widget.id]['ingredients']['1'],
                            ),
                            Text(""),
                            // SizedBox(width: 40.0),
                            // CheckboxListTile(
                            //   title: Text(
                            //     data[widget.id]['ingredients']['2'],
                            //   ),
                            //   value: this.value2,
                            //   onChanged: (bool value2) {
                            //     setState(() {
                            //       this.value2 = value2;
                            //     });
                            //   },
                            //   controlAffinity: ListTileControlAffinity
                            //       .leading, //  <-- leading Checkbox
                            // ),
                            Text(
                              data[widget.id]['ingredients']['2'],
                            ),
                            Text(""),

                            Text(
                              data[widget.id]['ingredients']['3'],
                            ),
                            Text(""),

                            Text(
                              data[widget.id]['ingredients']['4'],
                            ),
                            Text(""),

                            Text(
                              data[widget.id]['ingredients']['5'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['6'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['7'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['8'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['9'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['10'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['11'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['12'],
                            ),
                            Text(""),
                            Text(
                              data[widget.id]['ingredients']['13'],
                            ),
                            Text(""),
                            SizedBox(width: 10.0),
                          ],
                        )),
                    SizedBox(height: 40.0),

                    //--------------Video------------------
                    Text('Video',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 40.0),
                    YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                    ),

                  ],
                ))
          ])
        ]));
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
              cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(unit,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12.0,
                              color: cardTitle == selectedCard
                                  ? Colors.white
                                  : Colors.black,
                            ))
                      ],
                    ),
                  )
                ])));
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.grey.withOpacity(0.3),
        width: 0.75,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(16.0),
    );
  }
}
