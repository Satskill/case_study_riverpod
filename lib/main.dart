import 'dart:io';

import 'package:case_study_riverpod/Routes/route.dart';
import 'package:case_study_riverpod/Widgets/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

String uri = 'https://reqres.in/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  Hive.init((await getApplicationDocumentsDirectory()).path);

  await Hive.openBox('Profile');

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          FocusScope.of(context).requestFocus(new FocusNode());
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
        onGenerateRoute: Routes.routes,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
