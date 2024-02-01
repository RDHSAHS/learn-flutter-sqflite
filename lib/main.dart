import 'package:flutter/material.dart';
import 'package:namer_app/src/screens/createDB_screen.dart';
import 'package:namer_app/src/services/database_instance.dart';
import 'package:namer_app/src/models/product_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQFLite',
      theme: ThemeData(
          primaryColor: Colors.teal,
          primaryTextTheme:
              TextTheme(bodyLarge: TextStyle(color: Colors.white))),
      home: MyHomePage(title: 'Flutter SQFLite'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return CreateScreen();
                }));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<ProductModel>>(
            future: databaseInstance.all(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(child: Text('Data still empty'));
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name ?? ''),
                        subtitle: Text(snapshot.data![index].category ?? ''),
                      );
                    });
              } else {
                return Center(
                    child: CircularProgressIndicator(color: Colors.amber));
              }
            }),
      ),
    );
  }
}
