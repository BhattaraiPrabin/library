import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:library_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoginMode = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset('assets/images/library.png'),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      onChanged: (value) {},
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF584846),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        hintText: '\tEnter Email-id',
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      onChanged: (value) {},
                      controller: passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF584846),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF584846)),
                        ),
                        hintText: 'Enter Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (passwordController.text.length > 6) {
                              isLoginMode ? login() : signUp();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please provide a valid password with at least 7 characters.',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(isLoginMode ? 'LOGIN' : 'SIGN UP',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLoginMode
                            ? 'Don\'t have an account? '
                            : 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginMode = !isLoginMode;
                          });
                        },
                        child: Text(
                          isLoginMode ? 'Signup' : 'Login',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check the current user after login
      User? user = auth.currentUser;
      if (user != null) {
        print('User logged in: ${user.uid}');
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print('User login failed');
      }
    } catch (e) {
      // Handle login errors here
      print('Login failed: $e');
    }
  }

  Future<void> signUp() async {
    final auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }
}
