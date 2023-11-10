import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  final txtctrlr1 = TextEditingController();
  final txtctrlr2 = TextEditingController();

  final List<String> bldgrp = ["A+", "A-", "B", "B+", "O+", "O", "AB+", "AB-"];
  String selectedgrp = "";

  void adddonor() {
    final data = {
      'name': txtctrlr1.text,
      'group': selectedgrp,
      'phone': txtctrlr2.text
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: txtctrlr1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name'),
                    hintText: "Enter Name"),
              )),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: txtctrlr2,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Number'),
                  hintText: "Enter Phone Number"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: DropdownButtonFormField(
                items: bldgrp
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: ((value) {
                  selectedgrp = value.toString();
                })),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                adddonor();
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Donor Added')));
              },
              child: Text("Submit"),
              style: ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50))),
            ),
          )
        ],
      ),
    );
  }
}
