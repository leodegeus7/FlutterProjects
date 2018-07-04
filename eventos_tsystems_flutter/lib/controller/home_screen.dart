import 'package:flutter/material.dart';
import 'package:eventos_tsystems_flutter/model/question.dart';
import 'package:eventos_tsystems_flutter/widgets/question_view.dart';
import 'package:eventos_tsystems_flutter/widgets/line_widget.dart';
import 'package:eventos_tsystems_flutter/widgets/question_user_view.dart';
import 'package:eventos_tsystems_flutter/widgets/question_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventos_tsystems_flutter/model/appConfig.dart';
import 'package:eventos_tsystems_flutter/controller/singleton.dart';



class MyApp extends StatelessWidget {
  final AppConfig appConfig;
  MyApp(AppConfig appConfig) :
        this.appConfig = appConfig;


  @override
  Widget build(BuildContext context) {

    Color color = appConfig.color;

    var stream =  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('events').document("vw").collection("pages").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Center(child: Text("Carregando",style: TextStyle(color: color,fontSize: 23.0)));
          return new MyHomePage(title: appConfig.titleLabel,pages: getPages(snapshot),appConfig: appConfig);
        });

    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: color
        ),
        home: stream
    );
  }

  List<Page> getPages(AsyncSnapshot<QuerySnapshot> snapshots) {
    var docs = snapshots.data.documents;
    return docs.map((document) {
      String type = document.data["type"];
      switch (type) {
        case "forms":
          return Forms.fromSnapshot(document);
        case "question":
          return Question.fromSnapshot(document);
        case "message":
          return Message.fromSnapshot(document);
          break;
        default:
      }
    }).toList();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.pages,this.appConfig}) : super(key: key);

  final String title;
  final List<Page> pages;
  final AppConfig appConfig;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double widthSize = 0.0;
  int number = 1 ;

  Widget widgetBody;

  @override
  Widget build(BuildContext context) {

    Page page = widget.pages[number - 1];
    if (page is Forms) {
      Forms formAux = page;
      widgetBody = QuestionUserWidget(formAux,formAux.documentID);
    } else if (page is Question) {
      Question question = page;
      widgetBody = QuestionWidget(widget.pages[number - 1],question.documentID);
    } else if (page is Message) {
      widgetBody = QuestionMessage(widget.pages[number - 1]);
    }
    widthSize = MediaQuery.of(context).size.width*0.8;
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 30.0,
                ),
                new Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Text(
                    widget.appConfig.descriptionLabel,
                    style: TextStyle(fontSize: 20.0,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600),
                  ),
                ),


              ],
            ),
          ),

          LineWidget(widget.pages.length,number,Theme.of(context).primaryColor),

          new Container(
            height: 30.0,
          ),
          new Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.grey.withAlpha(60),
                  blurRadius: 2.0,
                  offset: new Offset(0.0, 0.0),
                ),
              ],
            ),
            child: new Center(
              child: new Container(
                  height: widthSize,

                  margin: EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0,bottom: 15.0),
                  child: widgetBody
              ),
            ),
          ),
          new Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 30.0,right: 30.0,top: 30.0),
              alignment: Alignment.bottomRight,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: getBottomItems()
              )
          ),
          buttonRestart()
        ],
      ),
    );
  }

  Widget buttonRestart() {
    if (testIfIsLastPage()) {
      return new Container(
          height: 50.0,
          margin: EdgeInsets.only(top: 10.0),
          alignment: Alignment.center,
          child: new FlatButton(
            onPressed: () {
              reloadWidgets();
            },
            child: new Text(widget.appConfig.restartLabel,style: TextStyle(fontSize: 17.0),),
            textTheme: ButtonTextTheme.primary,
          )
      );
    } else {
      return new Container(

      );
    }
  }

  List<Widget> getBottomItems() {
    List<Widget> list = [];
    var imageNext = new AssetImage('images/Shape@3x.png');
    var nextIcon = ImageIcon(imageNext,color: widget.appConfig.color);

    var imageBack = new AssetImage('images/ShapeInversed@3x.png');
    var backIcon = ImageIcon(imageBack, color: widget.appConfig.color);

    var backButton = new FlatButton(
      onPressed: (){
        changeQuestionDown();
      },
      child: new Text(widget.appConfig.backLabel),
      textTheme: ButtonTextTheme.primary,
    );

    var nextButton = new FlatButton(
      onPressed: () {
        changeQuestionUp();
      },
      child: new Text(widget.appConfig.nextLabel),
      textTheme: ButtonTextTheme.primary,
    );

    var expanded = new Expanded(
      child: new Container(
      ),
    );


    if (number != 1) {
      list.add(backIcon);
      list.add(backButton);
    }
    list.add(expanded);
    if (number != widget.pages.length) {
      list.add(nextButton);
      list.add(nextIcon);
    }
    return list;
  }

  reloadWidgets() {
    setState(() {
      number = 1;
      Singleton.instance.idPerson = "";
    });
  }

  changeQuestionUp() {
    setState(() {
      if (number == 1) {
        Singleton.instance.idPerson = Firestore.instance
            .collection('events')
            .document(Singleton.instance.idEvent)
            .collection("records").document().documentID;
        print(Singleton.instance.idPerson);
      }
      if (sendSubmitToWidget(widgetBody)) {
        if (number < widget.pages.length)
          number = number + 1;
      }
      testIfIsLastPage();
    });
  }

  changeQuestionDown() {
    setState(() {
      if (number > 1)
        number = number - 1;
    });
  }

  bool testIfIsLastPage() {
    if (number == widget.pages.length) {
      return true;
    } else {
      return false;
    }
  }

  bool sendSubmitToWidget(Widget widgetBody) {
    if (widgetBody is QuestionUserWidget) {
      QuestionUserWidget widget2 = widgetBody;
      return widget2.sendInfo();
    } else if (widgetBody is QuestionWidget) {
      QuestionWidget widget2 = widgetBody;
      return widget2.sendInfo();
    } else if (widgetBody is QuestionMessage) {
      QuestionMessage widget2 = widgetBody;
      return true;
    } else {
      return false;
    }
  }

}





