import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/tabs_screen.dart';
import '/models/donation.dart';

class HostDonationScreen extends StatefulWidget {
  const HostDonationScreen({super.key});

  @override
  State<HostDonationScreen> createState() => _HostDonationScreenState();
}

class _HostDonationScreenState extends State<HostDonationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  final TextEditingController mobilecontroller = TextEditingController();
  final TextEditingController banknamecontroller = TextEditingController();
  final TextEditingController accnumcontroller = TextEditingController();
  final TextEditingController pannumcontroller = TextEditingController();
  final TextEditingController ifsccontroller = TextEditingController();
  final TextEditingController amtcontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    agecontroller.dispose();
    mobilecontroller.dispose();
    banknamecontroller.dispose();
    accnumcontroller.dispose();
    pannumcontroller.dispose();
    ifsccontroller.dispose();
    amtcontroller.dispose();
    super.dispose();
  }

  Padding formField(
    BuildContext context,
    TextEditingController varcontroller,
    String boxReason,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.08,
        right: MediaQuery.of(context).size.width * 0.08,
        bottom: MediaQuery.of(context).size.height * 0.03,
      ),
      child: TextFormField(
        controller: varcontroller,
        validator: (value) {
          if (varcontroller == mobilecontroller) {
            if (value!.isEmpty) {
              return '$boxReason cannot be empty';
            }
            if (value.length != 10) {
              return 'Mobile Number should be of exact 10 digits';
            } else {
              return null;
            }
          } else if (varcontroller == agecontroller) {
            if (value!.isEmpty) {
              return '$boxReason cannot be empty';
            }
            // if (value.length > 2) {
            if (int.tryParse(value)! < 18) {
              return 'Age must be greater than 18 to host';
            }
          } else if (varcontroller == accnumcontroller) {
            if (int.tryParse(value!) == null) {
              return 'Account number contains only number';
            }
            if (value.isEmpty) {
              return '$boxReason cannot be empty';
            }
            if (value.length < 9) {
              return 'Account number must be greater than 9 digits';
            }
          }
          if (varcontroller == ifsccontroller) {
            if (value!.isEmpty) {
              return '$boxReason cannot be empty';
            }
            if (value.length != 11) {
              return 'IFSC Code should be of exact 11 digits';
            }
          }
          if (varcontroller == pannumcontroller) {
            if (value!.isEmpty) {
              return '$boxReason cannot be empty';
            }
            if (value.length != 10) {
              return 'Pan Number should be of exact 10 digits';
            }
          }
          if (varcontroller == amtcontroller) {
            if (value!.isEmpty) {
              return '$boxReason cannot be empty';
            }
            if (int.tryParse(value) == null) {
              return 'Donation Amount must be an integer';
            }
          } else {
            if (value!.isEmpty) {
              return '$boxReason cannot be empty';
            } else {
              return null;
            }
          }
        },
        decoration: InputDecoration(
          label: Text(boxReason),
          hintText: 'Enter your $boxReason',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final donationContainer = Provider.of<DonationProvider>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('ENTER YOUR DETAILS TO HOST DONATIONS'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              formField(context, namecontroller, 'Name'),
              formField(context, agecontroller, 'Age'),
              formField(context, mobilecontroller, 'Mobile Number'),
              formField(context, banknamecontroller, 'Bank Name'),
              formField(context, accnumcontroller, 'Account Number'),
              formField(context, ifsccontroller, 'IFSC Code'),
              formField(context, pannumcontroller, 'Pan Number'),
              formField(context, amtcontroller, 'Amount'),
              ElevatedButton(
                onPressed: () {
                  print(_formKey.currentState!.validate());
                  if (_formKey.currentState!.validate() == true) {
                    donationContainer.addDonation(
                      Donation(
                        amt: amtcontroller.text,
                        name: namecontroller.text,
                        age: agecontroller.text,
                        mobile: mobilecontroller.text,
                        bankName: banknamecontroller.text,
                        accNum: accnumcontroller.text,
                        panNum: pannumcontroller.text,
                        ifsc: ifsccontroller.text,
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: AlertDialog(
                          title: const Text('Documents gone for verification'),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Column(
                              children: [
                                Text('Name: ${namecontroller.text}'),
                                const Divider(),
                                Text('Age: ${agecontroller.text}'),
                                const Divider(),
                                Text('Mobile Number: ${mobilecontroller.text}'),
                                const Divider(),
                                Text('Bank Name: ${banknamecontroller.text}'),
                                const Divider(),
                                Text('Account No.: ${accnumcontroller.text}'),
                                const Divider(),
                                Text('IFSC Code: ${ifsccontroller.text}'),
                                const Divider(),
                                Text('Pan Number: ${pannumcontroller.text}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TabsScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Kindly check the details Entered'),
                        actions: [
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
