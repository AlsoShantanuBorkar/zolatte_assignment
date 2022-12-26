import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zolatte_assignment/providers/auth_service.dart';

class AddDetailsForm extends StatelessWidget {
  final FirebaseService provider;
  final User userData;
  const AddDetailsForm(
      {super.key, required this.provider, required this.userData});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    return Dialog(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Age",
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter A Valid Age";
                      } else if (value.length > 2 ||
                          value.length < 2 ||
                          int.parse(value) < 0) {
                        return "Please Enter A Valid Age";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Phone Number",
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Enter Valid Phone Number";
                      } else if (value.contains(RegExp(r'[A-Z]')) ||
                          value.length < 10) {
                        return "Enter Valid Phone Number";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Address",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Valid Address";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.redAccent,
                        ),
                      ),
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        if (formKey.currentState!.validate()) {
                          provider.addDetails(
                              age: ageController.text,
                              phoneNumber: phoneNumberController.text,
                              address: addressController.text,
                              email: userData.email,
                              name: userData.displayName);
                          Navigator.pop(context);
                        }
                      }),
                      child: const Text("Add Details"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
