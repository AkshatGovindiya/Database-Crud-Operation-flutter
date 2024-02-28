import 'package:flutter/material.dart';
import 'package:medical_app/Database/User_database.dart';
import 'package:medical_app/add_user.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    MyDatabase().copyPasteAssetFileToRoot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddUser(null)))
              .then((value) {
            setState(() {});
          });
        },
      ),
      appBar: AppBar(
        title: Text("Database"),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 1}. ${snapshot.data![index]["firstName"]} ${snapshot.data![index]["secondName"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: TextButton(
                                      child: Icon(Icons.delete,color: Colors.red,),
                                      onPressed: () async {
                                        await MyDatabase()
                                            .deleteUser(snapshot.data![index]["id"])
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      child: Icon(Icons.edit,color: Colors.green,),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return AddUser(snapshot.data![index]);
                                          },
                                        )).then(
                                              (value) {
                                            setState(() {});
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        future: MyDatabase().getDetails(),
      ),
    );
  }
}
