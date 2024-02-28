import 'package:flutter/material.dart';
import 'package:medical_app/Database/User_database.dart';

class AddUser extends StatefulWidget {
  Map<String, Object?>? map;

  AddUser(map) {
    this.map = map;
  }

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final _key = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var secondName = TextEditingController();
  var phoneNumber = TextEditingController();

  void initState() {
    firstName.text =
        widget.map == null ? '' : widget.map!["firstName"].toString();
    secondName.text =
        widget.map == null ? '' : widget.map!["secondName"].toString();
    phoneNumber.text =
        widget.map == null ? '' : widget.map!["phoneNumber"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADD USER')),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: firstName,
                decoration: InputDecoration(hintText: "Enter First Name :"),
              ),
              TextFormField(
                controller: secondName,
                decoration: InputDecoration(hintText: "Enter Second Name :"),
              ),
              TextFormField(
                controller: phoneNumber,
                decoration: InputDecoration(hintText: "Enter Phone number :"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (widget.map == null) {
                      insertUser()
                          .then((value) => Navigator.of(context).pop(true));
                    } else {
                      editUser(widget.map!["id"].toString())
                          .then((value) => Navigator.of(context).pop(true));
                    }
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  Future<int> insertUser() async {
    Map<String, Object?> map = Map<String, Object?>();
    map["firstName"] = firstName.text;
    map["secondName"] = secondName.text;
    map["phoneNumber"] = phoneNumber.text;

    var res = await MyDatabase().insertUser(map);
    return res;
  }

  Future<int> editUser(id) async {
    Map<String, Object?> map = Map<String, Object?>();
    map["firstName"] = firstName.text;
    map["secondName"] = secondName.text;
    map["phoneNumber"] = phoneNumber.text;

    var res = await MyDatabase().editUser(map, id);
    return res;
  }
}
