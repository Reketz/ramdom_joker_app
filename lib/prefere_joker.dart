import 'package:flutter/material.dart';
import 'package:random_joker_app/databaselocal.dart';
import 'package:random_joker_app/joker.dart';

class PrefereJoker extends StatefulWidget {
  @override
  _PrefereJokerState createState() => _PrefereJokerState();
}

class _PrefereJokerState extends State<PrefereJoker> {
  Future<List<Joker>> _listJoker;

  @override
  void initState() {
    _listJoker = DataBaseLocal.db.getAllJokers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: _listJoker,
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Joker joker = snapshot.data[index];
                    return _item(joker);
                  });
            }),
      ),
    );
  }

  _item(joker) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (_) => DataBaseLocal.db.delete(joker.id),
      child: Card(
        elevation: 2.0,
        child: ListTile(
            onTap: () {},
            trailing: Icon(Icons.star_border),
            title: Text(
              joker.joker.toString(),
              style: TextStyle(fontSize: 22),
            )),
      ),
    );
  }
}
