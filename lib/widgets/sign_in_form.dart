import 'package:books/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:books/res/custom_colors.dart';
import 'package:books/screens/register_screen.dart';

import 'package:books/utils/authentication.dart';
import 'package:books/utils/validator.dart';

import 'custom_form_field.dart';

class SignInForm extends StatefulWidget {
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const SignInForm({
    Key key,
    @required this.emailFocusNode,
    @required this.passwordFocusNode,
  }) : super(key: key);
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signInFormKey = GlobalKey<FormState>();

  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _emailController,
                  focusNode: widget.emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateEmail(
                    email: value,
                  ),
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                SizedBox(height: 16.0),
                CustomFormField(
                  controller: _passwordController,
                  focusNode: widget.passwordFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validatePassword(
                    password: value,
                  ),
                  isObscure: true,
                  label: 'Password',
                  hint: 'Enter your password',
                ),
              ],
            ),
          ),
          _isSigningIn
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          CustomColors.firebaseOrange,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        widget.emailFocusNode.unfocus();
                        widget.passwordFocusNode.unfocus();

                        setState(() {
                          _isSigningIn = true;
                        });

                        if (_signInFormKey.currentState.validate()) {
                          User user =
                              await Authentication.signInUsingEmailPassword(
                            context: context,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        }

                        setState(() {
                          _isSigningIn = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.firebaseGrey,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 16.0),
          _isSigningIn
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      CustomColors.firebaseOrange,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isSigningIn = true;
                    });
                    User user =
                        await Authentication.signInWithGoogle(context: context);

                    setState(() {
                      _isSigningIn = false;
                    });

                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/google_logo.png"),
                          height: 35.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(),
                ),
              );
            },
            child: Text(
              'Don\'t have an account? Sign up',
              style: TextStyle(
                color: CustomColors.firebaseGrey,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
