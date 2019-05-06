import 'package:database_project/src/model/ContactData.dart';
import 'package:database_project/src/ui/DataClass.dart';
import 'package:database_project/src/utils/DBHelper.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactState();
  }
}

class ContactState extends State<Contact> {
  String _name;

  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact list'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Name"),
              onChanged: (newName) => {
                    this.setState(() {
                      this._name = newName;
                    })
                  },
            ),
            width: double.maxFinite,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: RaisedButton(
              child: Text('Save Data'),
              onPressed: () => _saveContact(mainContext, this._name),
            ),
            width: double.maxFinite,
            margin: EdgeInsets.all(10),
          ),
          Container(
            child: RaisedButton(
              child: Text('Show Data'),
              onPressed: () => _showContact(mainContext),
            ),
            width: double.maxFinite,
            margin: EdgeInsets.all(10),
          )
        ],
      )),
    );
  }

  _saveContact(BuildContext ctx, String name) {
    ContactData data = ContactData(name: name);
    Future<int> db = DBHelper().insertContact(data);
    db.then((value) {
      print(value);
    });
  }

  _showContact(BuildContext ctx) {
    Navigator.of(ctx).push(
        MaterialPageRoute(builder: (BuildContext context) => DataClass()));
  }
}
