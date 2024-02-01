import 'package:flutter/material.dart';
import 'package:namer_app/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Product Name: '),
          TextField(
            controller: nameController,
          ),
          SizedBox(height: 15),
          Text('Category: '),
          TextField(
            controller: categoryController,
          ),
          SizedBox(height: 15),
          ElevatedButton(
              onPressed: () async {
                await databaseInstance.insert({
                  'name': nameController.text,
                  'category': categoryController.text,
                  'created_at': DateTime.now().toString(),
                  'updated_at': DateTime.now().toString()
                });
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Submit'))
        ]),
      ),
    );
  }
}
