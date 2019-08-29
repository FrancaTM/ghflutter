import 'package:flutter/material.dart';

import 'member.dart';

class MemberWidget extends StatefulWidget {
  final Member member;

  MemberWidget(this.member) {
    if (member == null) {
      throw ArgumentError(
          "member of MemberWidget cannot be null. Received: '$member'");
    }
  }

  @override
  _MemberWidgetState createState() => _MemberWidgetState();
}

class _MemberWidgetState extends State<MemberWidget> {
  _showOKScreen(BuildContext context) async {
    bool value = await Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Text('OK'),
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                ),
                GestureDetector(
                  child: Text('NOT OK'),
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );

    var alert = AlertDialog(
      content: Text((value != null && value)
          ? 'OK was pressed'
          : 'NOT OK or BACK was pressed'),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      child: alert,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.member.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.network(widget.member.avatarUrl),
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.green,
                size: 48,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('Press me'),
              onPressed: () {
                _showOKScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
