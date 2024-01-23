import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/login_sign_up_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 500,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 499,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 76, 174, 101),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(27.0),
                          bottomRight: Radius.circular(27.0),
                          topRight: Radius.circular(0.0),
                        ),
                      ),
                    ),
                    Container(
                      child: CircleAvatar(
                        radius: 80,
                        // backgroundColor: Color(0xFFE0B485),

                        backgroundColor:
                            const Color.fromARGB(255, 249, 214, 214),
                        child: const Opacity(
                          opacity: 0.8,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 335,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ADMIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 390,
                      child: const Opacity(
                        opacity: 0.7,
                        child: Text(
                          'Admin',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    leading: Icon(
                      Icons.call,
                      color: Color(0xFF584846),
                    ),
                    title: Text(
                      'Phone Number',
                      style: TextStyle(
                          color: Color(0xFF584846),
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '+ 977 9843018218',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.mail,
                      color: Color(0xFF584846),
                    ),
                    title: Text(
                      'Email',
                      style: TextStyle(
                          color: Color(0xFF584846),
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'admin@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.home,
                          color: Color.fromARGB(255, 49, 220, 137),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                    'Are you sure you want to logout?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        // Sign out the user
                                        await FirebaseAuth.instance.signOut();

                                        // Close the current screen
                                        Navigator.of(context).pop();

                                        // Navigate to the login page
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                        );

                                        // Show a success message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Logout successful!'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      } catch (e) {
                                        print('Error during logout: $e');

                                        // Show an error message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Logout failed. Please try again.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.logout,
                          color: Color.fromARGB(255, 216, 85, 76),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
