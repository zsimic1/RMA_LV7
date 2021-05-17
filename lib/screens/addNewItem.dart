import 'package:flutter/material.dart';
import 'package:list_lv/database/moor_database.dart';
import 'package:uuid/uuid.dart';

class newItem extends StatefulWidget {
  const newItem({Key key}) : super(key: key);

  @override
  _newItemState createState() => _newItemState();
}

class _newItemState extends State<newItem> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();
  TextEditingController latitudeController = new TextEditingController();
  TextEditingController longitudeController = new TextEditingController();

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
        title: Text('Add new item'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Naziv:'),
                  SizedBox(width: 5),
                  Flexible(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Opis:'),
                  SizedBox(width: 11),
                  Flexible(
                    child: TextField(
                      maxLength: 100,
                      controller: descriptionController,
                      decoration: InputDecoration(
                          counterText: '', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('URL:'),
                  SizedBox(width: 13),
                  Flexible(
                    child: TextField(
                      maxLength: 100,
                      controller: urlController,
                      decoration: InputDecoration(
                          counterText: '', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Lat:'),
                  SizedBox(width: 18),
                  Flexible(
                    child: TextField(
                      maxLength: 100,
                      controller: latitudeController,
                      decoration: InputDecoration(
                          counterText: '', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Long:'),
                  SizedBox(width: 8),
                  Flexible(
                    child: TextField(
                      maxLength: 100,
                      controller: longitudeController,
                      decoration: InputDecoration(
                          counterText: '', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                        if (urlController.text.isEmpty) {
                          urlController.text =
                              "https://upload.wikimedia.org/wikipedia/commons/4/48/BLANK_ICON.png";
                        }

                        if (longitudeController.text.isEmpty || latitudeController.text.isEmpty) {
                          latitudeController.text = "0.0";
                          longitudeController.text = "0.0";
                        }
                        AppDatabase().insertItem(Item(
                            guid: uuid.v4(),
                            name: nameController.text,
                            description: descriptionController.text,
                            url: urlController.text,
                            latitude: latitudeController.text,
                            longitude: longitudeController.text));

                        final snackBar = SnackBar(content: Text('Item added'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        nameController.clear();
                        descriptionController.clear();
                        urlController.clear();
                        latitudeController.clear();
                        longitudeController.clear();
                    });
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
