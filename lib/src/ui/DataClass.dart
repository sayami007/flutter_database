import 'package:database_project/src/model/ContactData.dart';
import 'package:database_project/src/utils/DBHelper.dart';
import 'package:flutter/material.dart';

class DataClass extends StatelessWidget {
  List<ContactData> nameList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data List')),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return FutureBuilder(
      future: getAllData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            return Center(child: Text('Loading'));
            break;

          case ConnectionState.none:
            return Center(child: Text('Loading'));
            break;
          case ConnectionState.waiting:
            return Center(child: Text('Loading'));
            break;
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].name),
                );
              },
            );
            break;
        }
        print(snapshot.data);
      },
    );
  }

  Future<List<ContactData>> getAllData() async {
    nameList = List<ContactData>();
    List<Map<String, dynamic>> db = await DBHelper().getAllRecord();
    for (var data in db) {
      ContactData contactData = ContactData.fromMap(data);
      nameList.add(contactData);
    }
    return nameList;
  }
}
