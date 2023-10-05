import 'package:case_study_riverpod/Widgets/All%20Users/participants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String emailPermanent = '';

final riverPodMail = ChangeNotifierProvider((_) => mailRiverPod());

class RiverPod extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watch = ref.watch(riverPodMail);
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        emailPermanent,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class mailRiverPod extends ChangeNotifier {
  String _mail = '';
  String get mail => _mail;
  set mail(String value) {
    _mail = value;
    notifyListeners();
  }

  void setEmail(String mail) {
    emailPermanent = mail;
    notifyListeners();
  }
}
