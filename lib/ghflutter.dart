import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'strings.dart';
import 'member.dart';

class GHFlutter extends StatefulWidget {
  @override
  createState() => GHFlutterState();
}

class GHFlutterState extends State<GHFlutter> {
  var _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  _loadData() async {
    String dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    http.Response response = await http.get(dataUrl);
    // print(response.body);
    setState(() {
      final membersJson = json.decode(response.body);

      for (var memberJson in membersJson) {
        final member = Member(memberJson['login'], memberJson['avatar_url']);
        _members.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(
          '${_members[i].login}',
          style: _biggerFont,
        ),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(
            _members[i].avatarUrl,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appTitle),
      ),
      body: ListView.builder(
        // padding: const EdgeInsets.all(16.0),
        itemCount: _members.length * 2,
        itemBuilder: (BuildContext context, int position) {
          if (position.isOdd) return Divider();

          final index = position ~/ 2;

          return _buildRow(index);
        },
      ),
    );
  }
}
