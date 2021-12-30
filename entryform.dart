import 'package:flutter/material.dart';
import 'package:crud_sqlite/models/contact.dart';

class EntryForm extends StatefulWidget {
  final Contact contact;

  EntryForm(this.contact);

  @override
  EntryFormState createState() => EntryFormState(this.contact);
}

// Class Controller
class EntryFormState extends State<EntryForm> {
  Contact contact;

  EntryFormState(this.contact);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Condition
    if (contact != null) {
      nameController.text = contact.name;
      phoneController.text = contact.phone;
    }

    // Change
    return Scaffold(
        appBar: AppBar(
          title: contact == null ? Text('Tambah') : Text('Rubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // Input Name
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // Input Phone Number
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // Button

              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // Button Save
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.0,
                        ),
                        onPressed: () {
                          if (contact == null) {
                            // Add Data
                            contact = Contact(
                                nameController.text, phoneController.text);
                          } else {
                            // Change Data
                            contact.name = nameController.text;
                            contact.phone = phoneController.text;
                          }

                          Navigator.pop(context, contact);
                        },
                      ),
                    ),

                    Container(
                      width: 5.0,
                    ),
                    // Button Cancel
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
