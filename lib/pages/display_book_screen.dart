import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app/pages/book_list_tile.dart';
import 'package:library_app/pages/send_or_update_data.dart';

// creating UI that will gather data and send it to firestore with means performing Flutter Firebase CRUD operations
class DisplayDataScreen extends StatefulWidget {
  const DisplayDataScreen({Key? key}) : super(key: key);
  @override
  State<DisplayDataScreen> createState() => _DisplayDataScreenState();
}

class _DisplayDataScreenState extends State<DisplayDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SendOrUpdateData()));
          },
          backgroundColor: Colors.red[50],
          child: const Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Colors.red[50],
        centerTitle: true,
        title: const Text(
          'List of Books',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return BookListTile(book: streamSnapshot.data!.docs[index]);
                  }),
                )
              : const Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator()),
                );
        },
      ),
    );
  }
}
