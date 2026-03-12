import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_model.dart';

class UserForm extends StatefulWidget {

  final User? user;

  UserForm({this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final name = TextEditingController();
  final email = TextEditingController();
  final age = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();

    if(widget.user != null){
      name.text = widget.user!.name;
      email.text = widget.user!.email;
      age.text = widget.user!.age;
    }
  }

  saveUser() async {

    User user = User(
      id: widget.user?.id,
      name: name.text,
      email: email.text,
      age: age.text,
    );

    if(widget.user == null){
      await dbHelper.insertUser(user);
    }
    else{
      await dbHelper.updateUser(user);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.user == null ? "Add User" : "Update User"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: age,
              decoration: InputDecoration(labelText: "Age"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveUser,
              child: Text("Save"),
            )

          ],
        ),
      ),
    );
  }
}