// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? age;
  AppUser({
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.age,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? age,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      age: age ?? this.age,
    );
  }

  AppUser deleteUserData() {
    return AppUser(
      name: null,
      email: null,
      phoneNumber: null,
      address: null,
      age: null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'age': age,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      age: map['age'] != null ? map['age'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
