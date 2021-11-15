import 'package:crud/screen/add_student_page.dart';
import 'package:crud/screen/list_student_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("CRUD"),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddStudentPage())),
                // onPressed: () => {},
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )

            // ElevatedButton(
            //     onPressed: () => Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => AddStudentPage())),
            //     child: const Text("Add")),
          ],
        ),
      ),
      body: const ListStudentPage(),
    );
  }
}
