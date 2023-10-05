import 'package:case_study_riverpod/Services/Auth%20Network/authHttpServices.dart';
import 'package:case_study_riverpod/Services/Auth%20Local/authLocalService.dart';
import 'package:case_study_riverpod/Widgets/RiverPod/riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  String? mailError = null;
  String? passwordError = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: authLocalService().ProfileGetInfos(),
          builder: (context, snapshot) {
            // Kayıtlı olan mail var mı kontrol ediliyor
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                (snapshot.data as Map).length != 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Map data = snapshot.data as Map;
                mailRiverPod().setEmail(data['mail']);
                Navigator.pushReplacementNamed(context, '/Participants');
              });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // yeni giriş için login ekranı
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.grey,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'WELCOME',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      color: Color.fromARGB(255, 49, 49, 49),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            decoration: textViewStyle(
                                errorMessage: mailError, 'E-Mail'),
                            controller: mail,
                            style: TextStyle(fontSize: 18),
                          ),
                          TextField(
                            decoration: textViewStyle(
                                errorMessage: passwordError, 'Password'),
                            controller: password,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.green.shade300.withOpacity(
                      0.3,
                    ),
                    minWidth: 240,
                    height: 50,
                    onPressed: () async {
                      // login aşamalarına geçmeden önce textediting kontrolleri
                      if (EmailValidator.validate(mail.text)) {
                        Map response = await authHttpServices()
                            .login(mail.text, password.text);
                        if (response['code'] == '200') {
                          await authLocalService().ProfileInsertDB(
                              {'token': response['body'], 'mail': mail.text});
                          final emailProvider =
                              StateProvider((ref) => mail.text);
                          mailRiverPod().setEmail(mail.text);
                          Navigator.pushNamed(context, '/Participants',
                              arguments: emailProvider);
                        } else {
                          await ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response['body']),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                        mailError = null;
                        if (password.text.characters.length <= 0)
                          passwordError = "Field can't be empty";
                        else
                          passwordError = null;
                      } else {
                        mailError = 'Please enter a valid email';
                        if (password.text.characters.length <= 0) {
                          passwordError = "Field can't be empty";
                        } else {
                          passwordError = null;
                        }
                      }
                      setState(() {});
                    },
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  textViewStyle(
    String hint, {
    String? errorMessage,
  }) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          gapPadding: 8,
          borderSide: BorderSide(
            color: Colors.green.shade300.withOpacity(
              0.6,
            ),
          )),
      errorText: errorMessage,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        gapPadding: 8,
      ),
      hintText: hint,
    );
  }
}
