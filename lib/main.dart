import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/user_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
       routes: <String, WidgetBuilder> {
        '/user_profile': (BuildContext context) => new UserProfile(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    Firestore.instance
        .collection('books') //.add({'title': 'title', 'author': 'author'})
        .document()
        .setData({'title': 'Asd', 'author': 'author'})
        
        
        .then((value) {
      print("completed ");
    }).catchError((onError) {
      print(" asd" + onError.message);
    });

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('books').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 32));
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...', style: TextStyle(fontSize: 32));
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return new ListTile(
                      title: new Text(document['title']),
                      subtitle: new Text(document['author']),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                print("object");
                Navigator.of(context).pushNamed("/user_profile");
              },
              child: UserAccountsDrawerHeader(
                
                onDetailsPressed: () {
                  print("onDetailsPressed");
                },
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                    
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Text(
                      "C",
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ],
                accountName: Text("Mustafa Gamal "),
                accountEmail: Text("Mustafapiso@outlook.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "M",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
