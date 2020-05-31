import 'package:flutter/material.dart';
import 'package:random_joker_app/databaselocal.dart';
import 'package:random_joker_app/joker.dart';
import 'package:random_joker_app/prefere_joker.dart';
import 'package:random_joker_app/router_simple.dart';
import 'package:random_joker_app/service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String jokerResponse;
  Future<Joker> _joker;
  bool isSwitched = false;

  @override
  void initState() {
    _joker = Service.getJoker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () {
          Navigator.push(context, RouterSimple(widget: PrefereJoker()));
        },
      )),
      body: Container(
        child: FutureBuilder(
            future: _joker,
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              jokerResponse = snapshot.data.joker;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 2,
                    runSpacing: 40,
                    children: <Widget>[
                      Center(
                        child: IconButton(
                          iconSize: 40,
                          onPressed: _passJoker,
                          color: Colors.black,
                          icon: Icon(Icons.clear),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.comment),
                            ),
                            title: Text(
                              jokerResponse,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: IconButton(
                          iconSize: 40,
                          onPressed: _getJoker,
                          color: Colors.black,
                          icon: Icon(Icons.check),
                        ),
                      )
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  _getJoker() {
    setState(() {
      DataBaseLocal.db.insert(jokerResponse);
      _joker = Service.getJoker();
    });
  }

  _passJoker() {
    setState(() {
      _joker = Service.getJoker();
    });
  }
}
