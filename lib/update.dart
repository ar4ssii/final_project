import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'main.dart';

class UpdateNote extends StatefulWidget {
  final String id;
  final String Title;
  final String Content;
  final String dateTime;

  UpdateNote({
    required this.id,
    required this.Title,
    required this.Content,
    required this.dateTime,
  });

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  final server = "http://localhost/devops_finals/api";

  Future<void> updateData() async {
    final url = "$server/notes.php";
    Map<String, dynamic> data = {
      "title": _title.text,
      "content": _content.text,
      "id": widget.id,
    };
    final response =
    await http.put(Uri.parse(url), body: jsonEncode(data));
    print(response.body);
    print(_title.text);
    print(_content.text);

    // Reload main screen after update
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  Future<void> deleteNote() async {
    final url = "$server/notes.php";
    Map<String, dynamic> data = {
      "id": widget.id,
    };

    try {
      final response =
      await http.delete(Uri.parse(url), body: jsonEncode(data));
      if (response.statusCode == 200) {
        print('Note deleted successfully');

        // Reload main screen after delete
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else {
        print('Failed to delete note: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  @override
  void initState() {
    _title.text = widget.Title;
    _content.text = widget.Content;

    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.chevron_left),
            ),
            GestureDetector(
              onTap: () {
                updateData();
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _title,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(fontSize: 25),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Color(0xff7e7e7e),
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _content,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Content here...',
                        ),
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            child: Text(
              DateFormat('MMMM dd, yyyy h:mm a').format(
                DateTime.parse(widget.dateTime),
              ),
              style: TextStyle(color: Color(0xff4b4b4b)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteNote();
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2.0,
        shape: CircleBorder(side: BorderSide(color: Colors.black, width: 2.0)),
      ),
    );
  }
}
