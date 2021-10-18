import 'package:books/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:books/res/custom_colors.dart';
import 'package:books/widgets/sign_in_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.firebaseNavy,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Image.asset(
                      'assets/firebase_logo.png',
                      height: 160.h,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'The Book',
                    style: TextStyle(
                      color: CustomColors.firebaseYellow,
                      fontSize: 40.r,
                    ),
                  ),
                  Text(
                    'Finder',
                    style: TextStyle(
                      color: CustomColors.firebaseOrange,
                      fontSize: 40.r,
                    ),
                  ),
                  FutureBuilder(
                    future: _initializeFirebase(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error initializing Firebase');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return SignInForm(
                          emailFocusNode: _emailFocusNode,
                          passwordFocusNode: _passwordFocusNode,
                        );
                      }
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.firebaseOrange,
                        ),
                      );
                    },
                  )
                  // SignInForm(
                  //   emailFocusNode: _emailFocusNode,
                  //   passwordFocusNode: _passwordFocusNode,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
