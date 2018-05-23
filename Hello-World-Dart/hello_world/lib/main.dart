import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter is cool'),
          leading: new Icon(
            Icons.cake,
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.sd_card),
              tooltip: 'Mil 1',  // se ficar segurando ele mostra o que é
              onPressed: () => {},
            ),
            new IconButton(
              icon: new Icon(Icons.settings_input_hdmi),
              tooltip: 'Mil 2',  // se ficar segurando ele mostra o que é
              onPressed: () => {},
            ),
          ],
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: new Text('Teste')),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.schedule),
              title: new Text('Teste 2')),
              
          ],
        ),
        body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new Text('Hello World'),
              new TextField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please enter text here'
                ),
              ),
              new Checkbox(
                value: true,
                onChanged: (bool value) => {

                },
              ),
              new Radio<int>(
                value: 0,
                groupValue: 0,
                onChanged: (_) => {

                },
              ),
              new Switch(
                value: false,
                onChanged: (bool value) => {

                },
              ),
              new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new RaisedButton(
                    child: const Text('Raised'),
                    onPressed: () => {},
                  ),
                  new RaisedButton(
                    child: const Text('disabled'),
                    onPressed: () => {},
                  )
                ],
              ),
              new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new FlatButton(
                    child: const Text('Raised'),
                    onPressed: () => {},
                  ),
                  new FlatButton(
                    child: const Text('disabled'),
                    onPressed: () => {},
                  )
                ],
              ),
              new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new OutlineButton(
                    child: const Text('Raised'),
                    onPressed: () => {},
                  ),
                  new OutlineButton(
                    child: const Text('disabled'),
                    onPressed: () => {},
                  )
                ],
              ),
              new Image.network(
                'http://thecatapi.com/api/images/get?formet=src&type=gif'
              ),
            ],
          ),
        ),
      ),
    );
  }
}