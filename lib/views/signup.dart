import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_messenger/helper/helperfunctions.dart';
import 'package:flutter_messenger/services/auth.dart';
import 'package:flutter_messenger/services/database.dart';
import 'package:flutter_messenger/widget/widget.dart';

import 'chatrooms.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  AuthFirebase authService = new AuthFirebase();
  bool isLoading = false;

  signUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((val) {
        if (val != null) {
          Map<String, String> userDataMap = {
            "userName": userNameController.text,
            "userEmail": emailController.text,
          };

          databaseMethods.addUserInfo(userDataMap);

          HelperFunctions.saveUserLoggedState(true);
          HelperFunctions.saveUserName(userNameController.text);
          HelperFunctions.saveUserEmail(emailController.text);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(children: [
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty || val.length < 2
                                  ? "username must contain at least 3 characters"
                                  : null;
                            },
                            controller: userNameController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("user name"),
                          ),
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Enter correct email";
                            },
                            controller: emailController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("email"),
                          ),
                          TextFormField(
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Enter Password 6+ characters";
                            },
                            controller: passwordController,
                            obscureText: true,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration('password'),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                              style: simpleTextStyle(),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              gradient: LinearGradient(colors: [
                                const Color(0xff007EFF4),
                                const Color(0xff2A75BC)
                              ])),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Sign up",
                            style: biggerTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Sign up with Google",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "already have an account? ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggleView();
                              },
                              child: Text(
                                "Sign in.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
