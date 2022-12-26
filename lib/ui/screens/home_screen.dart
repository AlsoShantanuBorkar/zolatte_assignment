import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/auth_service.dart';
import 'package:zolatte_assignment/ui/screens/delete_data_screen.dart';
import 'package:zolatte_assignment/ui/screens/logout_screen.dart';
import 'package:zolatte_assignment/ui/widgets/add_details_form.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<FirebaseService>(context, listen: false).getDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final User userData = Provider.of<User?>(context)!;

    return Consumer<FirebaseService>(
      builder: ((context, provider, child) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Center(child: Text("Menu")),
                ListTile(
                  title: const Text('LogOut'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LogOutScreen()),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Delete Data'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const DeleteDataScreen()),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text("Zolatte"),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userData.photoURL == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(userData.photoURL!),
                                )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(userData.displayName ?? "N/A"),
                              Text(userData.email ?? "N/A"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Age: ${provider.appUser.age ?? "N/A"}"),
                          Text(
                              "Phone Number: ${provider.appUser.phoneNumber ?? "N/A"}"),
                          Text("Address: ${provider.appUser.address ?? "N/A"}"),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddDetailsForm(
                          provider: provider,
                          userData: userData,
                        );
                      },
                    );
                  }),
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.stacked_bar_chart),
                        Text("Add Details"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
