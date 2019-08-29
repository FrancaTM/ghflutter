import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'strings.dart';
import 'member.dart';
import 'member_widget.dart';

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
        onTap: () {
          _pushMember(_members[i]);
        },
      ),
    );
  }

  // _pushMember(Member member) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MemberWidget(member),
  //     ),
  //   );
  // }

  _pushMember(Member member) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (context, _, __) => MemberWidget(member),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
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
