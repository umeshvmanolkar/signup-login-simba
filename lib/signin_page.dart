import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'signup_page.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                      children:[

                        SizedBox(height: 70,),

                        Text("Sign in",style: TextStyle(color:Colors.blue[900],fontWeight:FontWeight.bold,fontSize: 25), ),

                        SizedBox(height: 40,),

                        TextFormField(
                          style: TextStyle(fontSize: 18.0,height: 1),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintStyle: TextStyle(color: Colors.black,fontSize: 18),
                              hintText: "Email:",
                              border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),

                          keyboardType: TextInputType.emailAddress,

                          validator: (email) => !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              :null,

                          controller: _emailController,
                        ),

                        SizedBox(height: 20,),

                        TextFormField(

                          style: TextStyle(fontSize: 18.0,height: 1),

                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintStyle: TextStyle(color: Colors.black,fontSize: 18),

                              hintText: "Password:",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
                          obscureText: true,
                          controller: _passwordController,

                          validator: (value){
                            if(value == null || value.length<5){
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 15,),

                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("Forgot Password?",
                              style: TextStyle(color: Colors.black),)),

                        SizedBox(height: 20,),

                        Padding(

                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              onPressed: (){
                                final form = formKey.currentState;
                                if(form!.validate()) {

                                }
                              },
                              minWidth: 120,
                              color: Colors.blue[400],
                              shape: StadiumBorder(),
                              child:Text('Sign In',
                                style: TextStyle(color: Colors.white,fontSize: 20),)

                          ),
                        ),

                        Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),

                              TextButton(
                                  onPressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=> SignupPage()));
                                  },
                                  child: Text("Sign Up",style: TextStyle(color: Colors.orange),)
                              ),
                            ]),
                      ]
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
