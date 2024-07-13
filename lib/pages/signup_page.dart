import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/chatforum/auth_method.dart';
import 'package:news_pulse/pages/dummy_homepage.dart';
import 'package:news_pulse/pages/login_page.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController confirmpasswordcontroller = TextEditingController();

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
              SizedBox(
                height: 20,
              ),
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
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: confirmpasswordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
              SizedBox(height: 20),
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
                              SnackBar(content: Text('Field cannot be empty')));
                        } else if (passwordcontroller.text !=
                            confirmpasswordcontroller.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password dont match')));
                        } else {
                          User? result = await AuthService().register(
                              emailcontroller.text,
                              passwordcontroller.text,
                              context);
                          if (result != null) {
                            print('object');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatScreen(user: result)));
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
                          'Sign Up',
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Alreday have an account?',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueAccent),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
