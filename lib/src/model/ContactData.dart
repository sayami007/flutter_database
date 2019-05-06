// To parse this JSON data, do
//
//     final contactData = contactDataFromJson(jsonString);

import 'dart:convert';

class ContactData {
  int id;
  String name;

  ContactData({
    this.id,
    this.name,
  });

  factory ContactData.fromJson(String str) =>
      ContactData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactData.fromMap(Map<String, dynamic> json) => new ContactData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
