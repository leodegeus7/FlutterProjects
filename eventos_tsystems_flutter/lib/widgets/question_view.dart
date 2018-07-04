import 'package:flutter/material.dart';
import 'package:eventos_tsystems_flutter/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_tsystems_flutter/controller/singleton.dart';

class QuestionWidget extends StatefulWidget {

  QuestionWidget(this.question,this.widgetName);

  final Question question;
  final String widgetName;

  bool sendInfo() {
    var i = 0;
    for (var answer in question.answers) {
      data[answer] = question.checkBoxValue[i];
      i = i + 1;
    }

    Firestore.instance
        .collection('events')
        .document(Singleton.instance.idEvent)
        .collection("records")
        .document(Singleton.instance.idPerson)
        .collection("pages")
        .document(widgetName)
        .setData(data);
    return true;
  }

  resetView() {
    question.checkBoxValue = [];
    for (var _ in question.answers) {
      question.checkBoxValue.add(false);
    }
  }


  @override
  _QuestionWidgetState createState() => new _QuestionWidgetState();
}

Map<String,bool> data = new Map<String,bool>();


class _QuestionWidgetState extends State<QuestionWidget> {
  @override


  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(widget.question.quest,style: TextStyle(fontSize:21.0,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor)),
          new Expanded(
            flex: 130,
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: buildCheckbox(widget.question),
            ),
          ),
        ],
      );
  }


  Column buildCheckbox(Question question) {
    List<Widget> checks = [];
    for (var _ in question.answers) {
      question.checkBoxValue.add(false);
    }

    var index = 0;
    for (var quest in question.answers) {
      var check = createCheckbox(index,false, quest);
      index = index + 1;
      checks.add(check);
    }
    int xCount = 2;
    double yCount =  checks.length / xCount.toDouble();
    int yCountInt = yCount.toInt() + 1;
    var count = 0;

    List<Row> columns = [];
    for (var i = 0; i < yCountInt; i++) {
      List<Widget> widgets = [];
      for (var j = 0; j < xCount; j++) {
        if (checks.length > count) {
          widgets.add(checks[count]);
        }
        count = count + 1;
      }
      var row = new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets,
      );
      columns.add(row);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: columns,
    ) ;
  }

  Row createCheckbox(int number,bool fill, String text) {
    return new Row(
      children: <Widget>[
        new Checkbox(
          key: Key(text.toString()),
          activeColor: Colors.pink,
          value: widget.question.checkBoxValue[number],
          onChanged: (bool value) {
            setState(() {
              widget.question.checkBoxValue[number] = value;
            });
          },
        ),
        new Container(
          width: 110.0,
          child: new Text(
            text,
            style: TextStyle(color: Colors.black38),
            maxLines: 4,
          ),
        )
      ],
    );
  }
}