import 'package:flutter/material.dart';
import 'package:crud_sqlite/ui/entryform.dart';
import 'package:crud_sqlite/models/contact.dart';
import 'package:crud_sqlite/helpers/dbhelper.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Contact> contactList;

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      // ignore: deprecated_member_use
      contactList = List<Contact>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Data-Data'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Contact',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) addContact(contact);
        },
      ),
    );
  }

  Future<Contact> navigateToEntryForm(
      BuildContext context, Contact contact) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(contact);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.people),
            ),
            title: Text(
              this.contactList[index].name,
              style: textStyle,
            ),
            subtitle: Text(this.contactList[index].phone),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteContact(contactList[index]);
              },
            ),
            onTap: () async {
              var contact =
                  await navigateToEntryForm(context, this.contactList[index]);
              if (contact != null) editContact(contact);
            },
          ),
        );
      },
    );
  }

  void addContact(Contact object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteContact(Contact object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  void editContact(Contact object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Contact>> contactListFuture = dbHelper.getContactList();
      contactListFuture.then((contactList) {
        setState(() {
          this.contactList = contactList;
          this.count = contactList.length;
        });
      });
    });
  }
}

class Database {
  execute(String s) {}

  query(String s, {String orderBy}) {}

  insert(String s, Map<String, dynamic> map) {}

  update(String s, Map<String, dynamic> map,
      {String where, List<int> whereArgs}) {}

  delete(String s, {String where, List<int> whereArgs}) {}
}
