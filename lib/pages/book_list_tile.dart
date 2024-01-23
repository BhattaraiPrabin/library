import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/send_or_update_data.dart';

class BookListTile extends StatelessWidget {
  const BookListTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> book;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book Name: ${book['name']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Author: ${book['author']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ISBN: ${book['isbn']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Publisher: ${book['publisher']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${book['status']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SendOrUpdateData(
                        book_name: book['name'],
                        author: book['author'].toString(),
                        isbn: book['isbn'],
                        publisher: book['publisher'].toString(),
                        status: book['status'],
                        id: book.id,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  final docData = FirebaseFirestore.instance
                      .collection('books')
                      .doc(book.id);
                  await docData.delete();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red.shade900,
                  size: 21,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
