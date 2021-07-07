import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loading.dart';

import 'home_page.dart';
import 'signin_page.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final formKey = GlobalKey<FormState>();
  bool loading = false;
  var _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _repeatPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.6, 0.9],
                    colors: [Colors.teal, Colors.indigo ],
                  )
              ),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 70,),

                      Text("Sign Up", style: TextStyle(color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),),

                      SizedBox(height: 40,),

                      TextFormField(

                        style: TextStyle(fontSize: 18.0, height: 1),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                            hintText: "Email:",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        keyboardType: TextInputType.emailAddress,

                        validator: (email) => !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            :null,

                        controller: _emailController,
                      ),

                      SizedBox(height: 20,),

                      TextFormField(

                        style: TextStyle(fontSize: 18.0, height: 1),

                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 18),

                            hintText: "Password:",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        obscureText: true,
                        controller: _passwordController,

                        validator: (_passwordController) {
                          if (_passwordController == null || _passwordController.length < 5) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20,),

                      TextFormField(

                        controller: _repeatPasswordController,
                        style: TextStyle(fontSize: 18.0, height: 1),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                            hintText: "Re-enter Password:",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        obscureText: true,

                        validator: (_repeatPasswordController) {
                          if (_repeatPasswordController != _passwordController.text) {
                            return "password does not match";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 30,),

                      Padding(

                        padding: EdgeInsets.only(left: 10, right: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            onPressed: () {
                              final form = formKey.currentState;
                              if(form!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                submit();
                              }
                            },
                            minWidth: 120,
                            color: Colors.blue[400],
                            shape: StadiumBorder(),
                            child: Text('Sign up',
                              style: TextStyle(color: Colors.white, fontSize: 20),)

                        ),
                      ),

                      Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),

                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (
                                    context) => LoginPage()));
                              },
                              child: Text(
                                "Sign In", style: TextStyle(color: Colors.orange),)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }


  void submit() {
    String email = _emailController.text;
    String password = _repeatPasswordController.text;
    saveNamePreference(email,password).then((bool committed) {});
    Navigator.push(context,MaterialPageRoute(builder: (context)=> Home() ));
  }
}

Future<bool> saveNamePreference(String email,String password) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("email",email);
  prefs.setString("password",password);
  // ignore: deprecated_member_use
  return prefs.commit();
}


