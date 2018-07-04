import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_tsystems_flutter/controller/home_screen.dart';
import 'package:eventos_tsystems_flutter/model/appConfig.dart';
import 'package:eventos_tsystems_flutter/controller/singleton.dart';


class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('events').document(Singleton.instance.idEvent).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return new Center(child: Text("Carregando",style: TextStyle(color: Colors.black38,fontSize: 23.0)));
          return new MyApp(AppConfig(snapshot));
        });
  }
}