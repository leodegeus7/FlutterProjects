import 'package:flutter/material.dart';
import 'package:eventos_tsystems_flutter/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_tsystems_flutter/controller/singleton.dart';

var formKey = GlobalKey<FormState>();

class QuestionUserWidget extends StatefulWidget {

  QuestionUserWidget(this.form,this.widgetName);

  final Forms form;

  final String widgetName;

  bool sendInfo() {
    final form = formKey.currentState;

    form.save();

    print(data);

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

  @override
  _QuestionWidgetState createState() => new _QuestionWidgetState();
}

Map<String,String> data = new Map<String,String>();

class _QuestionWidgetState extends State<QuestionUserWidget> {
  @override
  Widget build(BuildContext context) {
    List<TextFormField>  fields = [];
    for (var entry in widget.form.fieldsNames) {
      var text = new TextFormField(
        decoration: InputDecoration(
            labelText: entry,
            labelStyle: TextStyle(color: Colors.grey),
            border: new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.redAccent)),

        ),
        onSaved:(String value){ data[entry] = value;},

        onFieldSubmitted: (String value){ print("value"); },
      );
      fields.add(text);
    }
    return questionUser(context,widget.form.description, fields);
  }

  Column questionUser(BuildContext context,String description,List<TextFormField> fields) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(description,style: TextStyle(fontSize:21.0,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor)),
        new Expanded(
          child: new Container(
            child: new Center(
              child: new Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 5.0,bottom: 20.0),
                  child: new Form(
                    key: formKey,
                    child: new Column(
                      children: fields,
                    ),
                  )
              ),
            ),
          ),
        )
      ],
    );
  }
}




