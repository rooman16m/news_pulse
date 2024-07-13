import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_pulse/chatforum/auth_gate.dart';
import 'package:news_pulse/pages/login_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Container(
            color: Colors.deepPurple,
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen(user: user)),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Please log in to access the chat forum')),
              );
            }
          },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 1.6,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Chat Forum',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            User? user = FirebaseAuth.instance.currentUser;
            if (user == null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else {
              _showDialog(
                  context, 'Already Logged In', 'You are already logged in.');
            }
          },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 1.6,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.login,
                  color: Colors.white,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 1.6,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 189,
        ),
        SizedBox(
          height: 150,
          child: Container(
            color: Colors.deepPurple,
          ),
        )
      ],
    );
  }
}
