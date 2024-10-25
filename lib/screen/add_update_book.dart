import 'package:database/helper/database_helper.dart';
import 'package:database/model/book.dart';
import 'package:flutter/material.dart';

class AddUpdateBook extends StatefulWidget {
  AddUpdateBook({super.key, this.book});
  Book? book;

  @override
  State<AddUpdateBook> createState() => _AddUpdateBookState();
}

class _AddUpdateBookState extends State<AddUpdateBook> {
  TextEditingController bookName = TextEditingController();

  TextEditingController bookAuthor = TextEditingController();

  TextEditingController bookPrice = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      bookName.text = widget.book!.bookName;
      bookAuthor.text = widget.book!.author;
      bookPrice.text = widget.book!.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: widget.book == null
            ? const Text('Add Book')
            : const Text('Update Book'),
      ),
      body: Container(
        height: 300,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: bookName == null ? Colors.red : Colors.teal),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  labelText: 'Book title',
                  labelStyle: const TextStyle(color: Colors.grey)),
              style: const TextStyle(color: Colors.white),
              controller: bookName,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  labelText: 'Book author',
                  labelStyle: TextStyle(color: Colors.grey)),
              style: const TextStyle(color: Colors.white),
              controller: bookAuthor,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  labelText: 'Book price',
                  labelStyle: TextStyle(color: Colors.grey)),
              style: const TextStyle(color: Colors.white),
              controller: bookPrice,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(204, 24, 24, 24),
                    foregroundColor: Colors.white),
                onPressed: () async {
                  if (bookName.text != null &&
                      bookAuthor.text != null &&
                      bookPrice.text != bookPrice) {
                    if (widget.book == null) {
                      databaseHelper.addBook(Book(bookName.text,
                          bookAuthor.text, int.parse(bookPrice.text)));
                    } else {
                      databaseHelper.updateBook(Book.withId(
                          widget.book!.id,
                          bookName.text,
                          bookAuthor.text,
                          int.parse(bookPrice.text)));
                    }
                    Navigator.pop(context);
                  }
                },
                child: widget.book == null
                    ? const Text('save')
                    : const Text('update')),
          ],
        ),
      ),
    );
  }
}
