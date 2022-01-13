import 'package:flutter/material.dart';

void main() {
  runApp(morr_app());
}

class morr_app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Credit Card Input Exercise"),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Credit Card Number",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                validator: (value) {
                  value = value.toString();
                  if ((new RegExp(
                          r'^4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|^(222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)[0-9]{12}|6(?:011|5[0-9]{2})[0-9]{12}|3[47]\d{13,14}$'))
                      .hasMatch(value)) {
                    if (Luhn(value)) {
                      return null;
                    }
                  }
                  return "Invalid Credit card Number";
                },
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Expiration date(MM/YY)",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'[0-3][0-9][/][0-9][0-9]'))
                            .hasMatch(value)) {
                          return null;
                        }
                        return "Invalid Expiry date";
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "CVV Security Code",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'^[0-9]{3,4}$')).hasMatch(value)) {
                          return null;
                        }
                        return "Invalid Security Code";
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "First Name",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'[A-Za-z ]$')).hasMatch(value)) {
                          return null;
                        }
                        return "Invalid First name";
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        value = value.toString();
                        if ((new RegExp(r'[A-Za-z ]$')).hasMatch(value)) {
                          return null;
                        }
                        return "Invalid Last name";
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                width: 200,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'Transaction Successful',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Luhn(String input) {
  int sum = 0;
  int length = input.length;
  for (var i = 0; i < length; i++) {
    int digit = int.parse(input[length - i - 1]);
    if (i % 2 == 1) {
      digit *= 2;
    }
    sum += digit > 9 ? (digit - 9) : digit;
  }

  if (sum % 10 == 0) {
    return true;
  }

  return false;
}
