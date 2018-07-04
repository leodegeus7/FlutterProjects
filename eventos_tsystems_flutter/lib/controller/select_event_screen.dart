import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_tsystems_flutter/controller/singleton.dart';
import 'package:eventos_tsystems_flutter/controller/loading_screen.dart';

void main() => runApp(
    new SelectEvent()
);


class SelectEvent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var stream =  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('events').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Center(child: Text("Carregando",style: TextStyle(color: Colors.white12,fontSize: 23.0)));

          List<String> map = [];

          for (var doc in snapshot.data.documents) {
            map.add(doc.documentID);
          }

          return new SelectEventPage(map);
        });

    return new MaterialApp(
        title: 'Eventos T-Systems',
        home: stream
    );
  }
}


class SelectEventPage extends StatefulWidget {

  final List<String> events;

  SelectEventPage(this.events);

  @override
  _SelectEventPageState createState() => new _SelectEventPageState();
}

class _SelectEventPageState extends State<SelectEventPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Selecione o evento na lista abaixo",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: new ListView.builder(
          itemCount: widget.events.length,
          itemBuilder: (context, index) {
          final item = widget.events[index];
          return ListTile(
            onTap: () {
              Singleton.instance.idEvent = item;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoadingScreen()),
              );
            },
            title: Text(item,style: Theme.of(context).textTheme.headline,),

          );
      },
    ));

  }
}