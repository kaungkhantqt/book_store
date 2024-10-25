import 'package:database/helper/database_helper.dart';
import 'package:database/model/book.dart';
import 'package:database/model/book_search.dart';
import 'package:database/screen/add_update_book.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    Color grey = Colors.grey;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Book Store'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: BookSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: databaseHelper.getAllBook(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: const Color.fromARGB(204, 24, 24, 24),
                      child: ListTile(
                          textColor: grey,
                          iconColor: grey,
                          leading: CircleAvatar(
                            backgroundColor: grey,
                            child: Text('$index'),
                          ),
                          title: Text(
                            snapshot.data[index].bookName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                              '\$${snapshot.data[index].price.toString()}'),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => AddUpdateBook(
                                                  book: snapshot.data[index],
                                                )));
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                color: Colors.red,
                                onPressed: () async {
                                  databaseHelper
                                      .deleteBook(snapshot.data[index].id);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          )),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(204, 24, 24, 24),
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddUpdateBook()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
