import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  const UpdateStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var name = '';
  var email = '';
  var password = '';

// Update Code
  CollectionReference updateStudent =
      FirebaseFirestore.instance.collection('student');

  Future<void> updateUser(id, name, email, passowrd) {
    return updateStudent
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((value) => print("updated"))
        .catchError((onError) => print('Error : $onError'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Students"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('student')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print("Error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.data();
                var name = data!['name'];
                var email = data['email'];
                var password = data['password'];

                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: name,
                      autofocus: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), label: Text("Name")),
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => name = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) => email = value,
                      autofocus: false,
                      initialValue: email,
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: password,
                      onChanged: (value) => password = value,
                      autofocus: false,
                      obscureText: false,
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateUser(widget.id, name, email, password);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Submit"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Reset"),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
