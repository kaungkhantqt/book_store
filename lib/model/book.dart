class Book {
  int? id;
  String bookName;
  String author;
  int price;

  Book(this.bookName, this.author, this.price);
  Book.withId(this.id, this.bookName, this.author, this.price);

  factory Book.formMap(Map<String, dynamic> map) => Book.withId(
      map['id'], map['book_name'], map['book_author'], map['book_price']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'book_name': bookName,
        'book_author': author,
        'book_price': price
      };
}
