import 'package:flutter/material.dart';


class LineWidget extends StatefulWidget {

  LineWidget(this.totalNumber,this.number,this.color);

  int number;
  int totalNumber;
  Color color;

  _LineWidgetState createState() => new _LineWidgetState();


}

class _LineWidgetState extends State<LineWidget> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var widthSize = MediaQuery.of(context).size.width*0.8;

    return new Container(
      height: 70.0,
      margin: EdgeInsets.only(left: 10.0,right: 10.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
          shape: BoxShape.rectangle
      ),
      child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _line(widget.totalNumber,widthSize,widget.number,widget.color)
      ),
    );
  }
}


class _Line_leo extends StatelessWidget {
  BorderRadiusGeometry border;
  double width;
  Color _color;

  _Line_leo(this.border,this.width,this._color);

  @override
  Widget build(BuildContext context) {
    var circle = Container(
        height: 10.0,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: _color,
          borderRadius: border,
        )
    );
    return circle;
  }
}

class _Circleleo extends StatelessWidget {

  Color _color = Colors.grey.withAlpha(95);


  @override
  Widget build(BuildContext context) {
    Container circle = new Container(
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: new Center(
        child: new Container(
          height: 20.0,
          decoration: new BoxDecoration(
              color: _color,
              shape: BoxShape.circle
          ),
        ),
      ),
    );
    return circle;
  }
}


class _Number extends StatelessWidget {

  int _number = 0;
  _Circleleo _circleleo = new _Circleleo();
  Color _colorText = Colors.grey;



  @override
  Widget build(BuildContext context) {

    Center center = new Center(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 22.5,
            width: 25.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
          ),
          _circleleo,
          new Container(
            height: 22.5,
            width: 25.0,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle
            ),
            child: new Text(
              _number.toString(),
              style: new TextStyle(
                color: _colorText,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );

    return center;
  }
}




List<Widget> _line(int numberOfCircles, double width,int numberFill,Color color) {
  List<Widget> containers = [];

  double widthSpace = (width - numberOfCircles*25)/(numberOfCircles + 1);
  Widget lineLeft = _Line_leo(new BorderRadius.only(topLeft: const Radius.circular(7.0),bottomLeft: const Radius.circular(7.0)),widthSpace,Colors.grey.withAlpha(60));
  containers.add(lineLeft);

  for (var i = 0; i < numberOfCircles; i++) {
    var circle = new _Number();

    containers.add(circle);
    if (i != numberOfCircles - 1) {
      Widget line = _Line_leo(null, widthSpace,Colors.grey.withAlpha(60));
      containers.add(line);
    }
  }

  Widget lineRight = _Line_leo(new BorderRadius.only(
      topRight: const Radius.circular(7.0),
      bottomRight: const Radius.circular(7.0)), widthSpace,Colors.grey.withAlpha(60));
  containers.add(lineRight);

  var number = numberFill*2;
  if (number > numberOfCircles*2) {
    number = numberOfCircles*2;
  }

  var numberInt = 1;
  for (var i = 0; i < containers.length; i++) {
    var container = containers[i];
    if (container is _Number) {
      _Number containe = container;
      containe._number = numberInt;
      numberInt = numberInt + 1;
    }
  }

  for (var i = 0; i <= number; i++) {
    var container = containers[i];
    if (container is _Number) {
      _Circleleo circle = container._circleleo;
      circle._color = color;
      container._colorText = color;

    }

    if (i >= 1) {
      container = containers[i-1];
      if (container is _Line_leo) {
        _Line_leo circle = container;
        circle._color = color;
        if (i == number) {
          container = containers[i];
          _Line_leo circle = container;
          circle._color = color;
        }
      }
    }

  }

  if (numberFill == numberOfCircles) {
    var container2 = containers[containers.length - 1];
    if (container2 is _Line_leo) {
      _Line_leo circle = container2;
      circle._color = color;
    }
  }
  return containers;
}
