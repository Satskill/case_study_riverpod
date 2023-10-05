import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingleParticipant extends StatefulWidget {
  Map data;
  SingleParticipant({required this.data, Key? key}) : super(key: key);

  @override
  State<SingleParticipant> createState() => _SingleParticipantState();
}

class _SingleParticipantState extends State<SingleParticipant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.8)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 180,
              width: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.data['avatar'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              widget.data['first_name'] + ' ' + widget.data['last_name'],
              style: TextStyle(fontSize: 26),
            ),
            Text(
              widget.data['email'],
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
