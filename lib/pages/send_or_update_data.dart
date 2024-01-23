import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendOrUpdateData extends StatefulWidget {
  final String book_name;
  final String author;
  final String isbn;
  final String status;
  final String publisher;

  final String id;
  const SendOrUpdateData(
      {this.id = '',
      this.author = '',
      this.isbn = '',
      this.book_name = '',
      this.status = '',
      this.publisher = ''});
  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}

class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    nameController.text = widget.book_name;
    authorController.text = widget.author;
    isbnController.text = widget.isbn;
    statusController.text = widget.status;
    publisherController.text = widget.publisher;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    authorController.dispose();
    isbnController.dispose();
    statusController.dispose();
    publisherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
        centerTitle: true,
        title: const Text(
          'Add Books',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 60, bottom: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Book Name',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Author',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: authorController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Isbn',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: isbnController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Publisher',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: publisherController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: statusController,
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (nameController.text.isEmpty ||
                    authorController.text.isEmpty ||
                    isbnController.text.isEmpty ||
                    publisherController.text.isEmpty ||
                    statusController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fill in all fields')));
                } else {
                  //reference to document
                  final dUser = FirebaseFirestore.instance
                      .collection('books')
                      .doc(widget.id.isNotEmpty ? widget.id : null);
                  String docID = '';
                  if (widget.id.isNotEmpty) {
                    docID = widget.id;
                  } else {
                    docID = dUser.id;
                  }
                  final jsonData = {
                    'name': nameController.text,
                    'author': authorController.text,
                    'isbn': isbnController.text,
                    'publisher': publisherController.text,
                    'status': statusController.text,
                    'id': docID
                  };
                  showProgressIndicator = true;
                  if (widget.id.isEmpty) {
                    //create document and write data to firebase
                    await dUser.set(jsonData).then((value) {
                      nameController.text = '';
                      authorController.text = '';
                      isbnController.text = '';
                      publisherController.text = '';
                      statusController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  } else {
                    await dUser.update(jsonData).then((value) {
                      nameController.text = '';
                      authorController.text = '';
                      isbnController.text = '';
                      publisherController.text = '';
                      statusController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  }
                }
              },
              minWidth: double.infinity,
              height: 50,
              color: Colors.red.shade300,
              child: showProgressIndicator
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
