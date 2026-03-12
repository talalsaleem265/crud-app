import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_model.dart';
import 'user_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  List<User> users = [];

  loadUsers() async {
    final data = await dbHelper.getUsers();

    setState(() {
      users = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("SQLite CRUD App"),
      ),

      body: ListView.builder(
        itemCount: users.length,

        itemBuilder: (context, index) {

          return Card(
            child: ListTile(

              title: Text(users[index].name),

              subtitle: Text(
                  "${users[index].email} | Age: ${users[index].age}"
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.green),

                    onPressed: () async {

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserForm(user: users[index]),
                        ),
                      );

                      loadUsers();
                    },
                  ),

                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),

                    onPressed: () async {

                      await dbHelper.deleteUser(users[index].id!);

                      loadUsers();
                    },
                  ),

                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UserForm(),
            ),
          );

          loadUsers();
        },
      ),
    );
  }
}