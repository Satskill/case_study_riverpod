import 'package:case_study_riverpod/Services/authLocalService.dart';
import 'package:case_study_riverpod/Services/getUsersServices.dart';
import 'package:case_study_riverpod/Widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

class Participants extends StatefulWidget {
  Participants({Key? key}) : super(key: key);

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.8)),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade500.withOpacity(0.8),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(emailProvider.name.toString()),
              MaterialButton(
                onPressed: () async {
                  await authLocalService().ProfileDeleteDB();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                color: Colors.transparent,
                height: 50,
                minWidth: 120,
                child: Text(
                  'Exit',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: getUsersServices().getUsers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return GridView.builder(
              itemCount: (snapshot.data as List).length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                Map data = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/SingleParticipant',
                        arguments: data);
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              data['avatar'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          data['first_name'] + ' ' + data['last_name'],
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(data['email']),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 24),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
