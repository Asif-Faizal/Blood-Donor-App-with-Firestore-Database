import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/add_user.dart';
import 'package:flutter3/update.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUser()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: donor.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot donorsnap = snapshot.data?.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.green,
                                  blurRadius: 15,
                                  blurStyle: BlurStyle.outer),
                            ],
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        height: 80,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: Text(donorsnap['group']),
                          ),
                          title: Text(donorsnap['name']),
                          subtitle: Text(donorsnap['phone']),
                          trailing: Wrap(
                            spacing: 5,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateUser(
                                                  grp: donorsnap['group'],
                                                  nme: donorsnap['name'],
                                                  phn: donorsnap['phone'],
                                                  id: donorsnap.id,
                                                )));
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                onPressed: () {
                                  donor.doc(donorsnap.id).delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Donor Deleted')));
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              )
                            ],
                          ),
                        )),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }
}
