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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.member.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.network(widget.member.avatarUrl),
      ),
    );
  }
}
