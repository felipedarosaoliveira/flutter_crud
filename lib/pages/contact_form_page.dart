import 'package:crud_gpt/data/database_helper.dart';
import 'package:crud_gpt/models/contact.dart';
import 'package:flutter/material.dart';

class ContactFormPage extends StatefulWidget {
  final Contact? contact;

  ContactFormPage({this.contact});

  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _emailController.text = widget.contact!.email;
      _phoneController.text = widget.contact!.phone;
    }
  }

  void _saveContact() async {
    if (_formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper.instance;

      final contact = Contact(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      if (widget.contact != null) {
        // Editar um contato existente
        contact.id = widget.contact!.id;
        await dbHelper.updateContact(contact);
      } else {
        // Cadastrar um novo contato
        await dbHelper.insertContact(contact);
      }

      Navigator.pop(
          context, true); // Indica que o contato foi salvo com sucesso
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact != null ? 'Edit Contact' : 'Add Contact'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _saveContact,
                  child: Text('Save Contact'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
