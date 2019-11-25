import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("User Profile"),
      ),
      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document("mustafagamal")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError)
              return  Text('Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 32));
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...', style: TextStyle(fontSize: 32));
              default:
                print(snapshot);
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: new Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: CircleAvatar(
                            radius: 50,
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
                        new Text(
                          snapshot.data['name'].toString(),
                          style: TextStyle(fontSize: 32),
                        ),
                        new Text(snapshot.data['Age'].toString(),
                            style: TextStyle(fontSize: 24))
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
