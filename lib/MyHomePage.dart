import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listview_filter/services/Services.dart';

import 'model/User.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class DelayClass {
  int milliseconds;
  VoidCallback action;
  Timer _timer;

  DelayClass(this.milliseconds, this.action, this._timer);

  run(VoidCallback action) {
    _timer.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final _delayClass =
      DelayClass(100, () {}, Timer(Duration(milliseconds: 1), () {}));
  List<User> users = [];
  List<User> filteredUsers = [];

  @override
  void initState() {
    dymmuList();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Filter by name or email',
            ),
            onChanged: (string) {
              _delayClass.run(() {
                setState(() {
                  filteredUsers = users
                      .where((u) => (u.name!
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.email!
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          filteredUsers[index].name.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          filteredUsers[index].email!.toLowerCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final myStyle = TextStyle(fontSize: 25);

  void dymmuList() {}
}
