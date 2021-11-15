import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var name = '';
  var email = '';
  var password = '';

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

// addUser code
  CollectionReference addStudent =
      FirebaseFirestore.instance.collection('student');

  addUser() {
    // ignore: avoid_print
    // print("Okay");
    addStudent
        .add({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Added"))
        .catchError((onError) => print('Failed to added $onError'));
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  resetForm() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add students"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Name")),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Email")),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Required";
                        // ignore: unrelated_type_equality_checks
                      } else if (!val.contains('@')) {
                        return "Required @";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("password"),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            setState(() {
                              name = nameController.text;
                              email = emailController.text;
                              password = passwordController.text;
                              resetForm();
                              addUser();
                            });
                          }
                        },
                        child: const Text("Submit"),
                      ),
                      ElevatedButton(
                        onPressed: () => resetForm(),
                        child: const Text("Reset"),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
