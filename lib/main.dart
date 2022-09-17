import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:submit/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Firebase';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: SignUpPage(),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  final db = FirebaseFirestore.instance;
  @override
  printText(String text) {
    final user = <String, dynamic>{"user name": text};

    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
    print(text);
  }

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 360.0,
                child: TextFormField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: 'Enter user name',
                    hintStyle: TextStyle(fontSize: 14.0),
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  autofocus: true,
                  validator: (value) {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 70.0),
              child: ElevatedButton(
                onPressed: () {
                  printText(myController.text);
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
