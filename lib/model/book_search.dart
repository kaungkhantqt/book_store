import 'package:database/helper/database_helper.dart';
import 'package:database/model/book.dart';
import 'package:flutter/material.dart';

class BookSearch extends SearchDelegate {
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodyMedium:
            TextStyle(color: Colors.white), // Set default text color to white
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<List<Book>>(
        future: databaseHelper.searchBook(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: const Color.fromARGB(204, 24, 24, 24),
                      child: ListTile(
                        textColor: Colors.grey,
                        iconColor: Colors.grey,
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text('$index'),
                        ),
                        title: Text(
                          snapshot.data[index].bookName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle:
                            Text('\$${snapshot.data[index].price.toString()}'),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<List<Book>>(
        future: databaseHelper.searchSuggestion(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: const Color.fromARGB(204, 24, 24, 24),
                      child: ListTile(
                        textColor: Colors.grey,
                        iconColor: Colors.grey,
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text('$index'),
                        ),
                        title: Text(snapshot.data[index].bookName,
                            style: const TextStyle(color: Colors.white)),
                        subtitle:
                            Text('\$${snapshot.data[index].price.toString()}'),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
