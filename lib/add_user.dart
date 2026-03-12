import 'package:flutter/material.dart';
import 'package:sqlitecrudapp/user_model.dart';
import 'database_helper.dart';

class AddUser extends StatefulWidget {

  final User? user;

  AddUser({this.user});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();

  @override
  void initState() {
    super.initState();

    if(widget.user != null){
      name.text = widget.user!.name;
      email.text = widget.user!.email;
      age.text = widget.user!.age.toString();
    }
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
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: age,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(

              child: Text(widget.user == null ? "Add User" : "Update User"),

              onPressed: () async {

                final user = User(
                  id: widget.user?.id,
                  name: name.text,
                  email: email.text,
                  age: age.text,
                );

                if(widget.user == null){
                  await DatabaseHelper.instance.insertUser(user);
                }
                else{
                  await DatabaseHelper.instance.updateUser(user);
                }

                Navigator.pop(context);
              },
            )

          ],
        ),
      ),
    );
  }
}