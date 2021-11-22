import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'details.dart';
import 'employee.dart';


void main() => runApp(const MyApp());

Future<List<Employee>> parseProducts(String responseBody) async {
  final parsed = json.decode(responseBody);
  return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
}

Future<List<Employee>> fetchEmployee() async {
  final response = await http
      .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  //print(response.statusCode);
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  }
  else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Employee>> futureEmployee;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
print("build");

    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: Center(
          child: FutureBuilder<List<Employee>>(
              future: fetchEmployee(),
              builder: (context, snapshot) {
                List<Employee>? data = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context,int indax){
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:NetworkImage("https://picsum.photos/200/300")
                          ),
                          title: Text(data[indax].name!),
                          subtitle: Text(data[indax].username!),
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Details(data[indax]))
                            );
                          }
                        ),

                      );
                  }
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
