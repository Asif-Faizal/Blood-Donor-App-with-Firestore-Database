import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUser extends StatefulWidget {
  final String nme, phn, grp, id;

  const UpdateUser(
      {super.key,
      required this.nme,
      required this.phn,
      required this.grp,
      required this.id});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  final txtctrlr1 = TextEditingController();
  final txtctrlr2 = TextEditingController();

  final List<String> bldgrp = ["A+", "A-", "B", "B+", "O+", "O", "AB+", "AB-"];
  String selectedgrp = "";

  void updateuser(docid) {
    final data = {
      'name': txtctrlr1.text,
      'phone': txtctrlr2.text,
      'group': selectedgrp
    };
    donor.doc(docid).update(data);
  }

  @override
  Widget build(BuildContext context) {
    txtctrlr1.text = widget.nme;
    txtctrlr2.text = widget.phn;
    selectedgrp = widget.grp;
    var docid = widget.id;
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: txtctrlr1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Number'),
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
                updateuser(docid);
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Donor Updated')));
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
