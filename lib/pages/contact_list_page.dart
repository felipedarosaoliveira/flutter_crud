import 'package:crud_gpt/data/database_helper.dart';
import 'package:crud_gpt/drawer.dart';
import 'package:crud_gpt/models/contact.dart';
import 'package:crud_gpt/pages/contact_form_page.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late Future<List<Contact>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _contactsFuture = _getContacts();
  }

  Future<List<Contact>> _getContacts() async {
    final dbHelper = DatabaseHelper.instance;
    final contacts = await dbHelper.getContacts();
    return contacts;
  }

  void _addContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactFormPage()),
    ).then((value) {
      if (value == true) {
        setState(() {
          _contactsFuture = _getContacts();
        });
      }
    });
  }

  void _editContact(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactFormPage(contact: contact)),
    ).then((value) {
      if (value == true) {
        setState(() {
          _contactsFuture = _getContacts();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      drawer: CustomDrawer(), // Adicione o Drawer personalizado aqui
      body: FutureBuilder<List<Contact>>(
        future: _contactsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final contacts = snapshot.data!;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.email),
                  onTap: () => _editContact(contact),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar contatos');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: Icon(Icons.add),
      ),
    );
  }
}
