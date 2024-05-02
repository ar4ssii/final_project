import 'dart:convert';
import 'package:flutter/material.dart';
import 'create.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:intl/intl.dart';
import 'update.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _searchController = TextEditingController();
  final server = "http://localhost/devops_finals/api";
  List<dynamic> notes = [];
  List<dynamic> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final url = Uri.parse("$server/notes.php");
    try {
      final response = await http.get(url);
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        List<dynamic> fetchedNotes = jsonDecode(response.body);
        fetchedNotes.sort((a, b) => DateTime.parse(b['dateTime']).compareTo(DateTime.parse(a['dateTime'])));
        setState(() {
          notes = fetchedNotes;
          filteredNotes = List.from(notes);
        });
      } else {
        // Handle error responses
        print("Failed to load notes: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network errors
      print("Error loading notes: $e");
    }
  }


  void _filterNotes(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredNotes = List.from(notes);
      } else {
        filteredNotes = notes
            .where((note) =>
        note['title'].toLowerCase().contains(query.toLowerCase()) ||
            note['content'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text('QuickNote'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFFFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: _filterNotes,
              ),
            ),
            // Check if notes list is empty
            notes.isEmpty
                ? Container(
              margin: EdgeInsets.symmetric(vertical: 200),
              child: Column(
                children: [
                  Image.network(
                      'https://pat270.github.io/clay3-test-site/vclay-table-dd/images/images/search_state.gif'),
                  SizedBox(height: 30),
                  Text("No Notes Yet. Click \"+\" to Create."),
                ],
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    String id = filteredNotes[index]['id'];
                    String Title = filteredNotes[index]['title'];
                    String Content = filteredNotes[index]['content'];
                    String dateTime =
                    filteredNotes[index]['dateTime'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => UpdateNote(
                          id: id,
                          Title: Title,
                          Content: Content,
                          dateTime: dateTime,
                        ),
                      ),
                    );
                    print('Note tapped: ${filteredNotes[index]['title']}');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border:
                      Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredNotes[index]['title'],
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          filteredNotes[index]['content'].length > 50
                              ? filteredNotes[index]['content']
                              .substring(0, 50) +
                              '...'
                              : filteredNotes[index]['content'],
                        ),
                        Text(
                          DateFormat('MMMM dd, yyyy h:mm a').format(
                              DateTime.parse(filteredNotes[index]
                              ['dateTime'])),
                          style: TextStyle(color: Color(0xff4b4b4b)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNote()),
          );
          // After adding a new note, reload the data
          loadData();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2.0,
        shape: CircleBorder(side: BorderSide(color: Colors.black, width: 2.0)),
      ),
    );
  }
}
