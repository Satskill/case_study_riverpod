import 'package:case_study_riverpod/Widgets/Login/login.dart';
import 'package:case_study_riverpod/Widgets/All%20Users/participants.dart';
import 'package:case_study_riverpod/Widgets/User%20Detail/singleParticipant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route _route(Widget widget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
          builder: (context) => widget, settings: settings);
    } else {
      return CupertinoPageRoute(
          builder: (context) => widget, settings: settings);
    }
  }

  static Route? routes(RouteSettings settings) {
    switch (settings.name) {
      case '/Login':
        return _route(Login(), settings);
      case '/Participants':
        return _route(Participants(), settings);
      case '/SingleParticipant':
        return _route(
            SingleParticipant(
              data: settings.arguments as Map,
            ),
            settings);
    }
  }
}
