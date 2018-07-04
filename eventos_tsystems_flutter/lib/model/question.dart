import 'package:cloud_firestore/cloud_firestore.dart';

class Question extends Page {
  String quest;
  List<String> answers;
  String documentID;
  List<bool> checkBoxValue = [];

  List<String> toList(List<dynamic> answers) {
    List<String> list = [];
    for (var item in answers) {
      String i = item;
      list.add(i);
    }
    return list;
  }

  Question.fromSnapshot(DocumentSnapshot snapshot) {
    documentID = snapshot.documentID;
    quest = snapshot.data["quest"];
    answers = toList(snapshot.data["answers"]);
  }


}

class Forms extends Page {
  String description;
  List<String> fieldsNames;
  String documentID;


  List<String> toList(List<dynamic> answers) {
    List<String> list = [];
    for (var item in answers) {
      String i = item;
      list.add(i);
    }
    return list;
  }

  Forms.fromSnapshot(DocumentSnapshot snapshot) {
    documentID = snapshot.documentID;
    description = snapshot.data["description"];
    fieldsNames = toList(snapshot.data["fieldsNames"]);
  }

}

class Message extends Page {
  String msg;
  String documentID;

  Message.fromSnapshot(DocumentSnapshot snapshot)
  : documentID = snapshot.documentID,
  msg = snapshot.data["msg"];


}

class Page {

}

