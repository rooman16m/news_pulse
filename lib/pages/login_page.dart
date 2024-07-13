import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/chatforum/auth_method.dart';
import 'package:news_pulse/pages/dummy_homepage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 50),
              Icon(
                Icons.newspaper_rounded,
                size: 100,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  )),
              SizedBox(height: 20.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(fontSize: 17, color: Colors.grey.shade500),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              loading
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        if (emailcontroller.text == "" ||
                            passwordcontroller.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Field cannot be empty')));
                        } else {
                          User? result = await AuthService().login(
                              emailcontroller.text,
                              passwordcontroller.text,
                              context);
                          if (result != null) {
                            print('object');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                          user: result,
                                        )));
                          }
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(18),
                        child: Center(
                            child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
