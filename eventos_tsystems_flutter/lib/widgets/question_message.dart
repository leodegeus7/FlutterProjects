import 'package:flutter/material.dart';
import 'package:eventos_tsystems_flutter/model/question.dart';

class QuestionMessage extends StatefulWidget {

  QuestionMessage(this.message);

  final Message message;

  @override
  _QuestionMessageState createState() => new _QuestionMessageState();
}

class _QuestionMessageState extends State<QuestionMessage> {
  @override
  Widget build(BuildContext context) {

    return createMessage(context,widget.message.msg);
  }
}

Center createMessage(BuildContext context,String message) {


  return Center(
    child: new Text(message,textAlign: TextAlign.center,style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor)),
  );


}
