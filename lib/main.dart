import 'package:flutter/material.dart';
import 'create.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          title: Text('App Name'),
          automaticallyImplyLeading: false
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              // ------ Uncomment this kung may if-else statement na sa notes display -----
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 200),
              //   child: Column(
              //     children: [
              //       Image.network('https://pat270.github.io/clay3-test-site/vclay-table-dd/images/images/search_state.gif'),
              //       SizedBox(height:30),
              //       Text("No Notes Yet. Click \"+\" to Create."),
              //     ],
              //   ),
              // ),


              Container(
                color: Color(0xFFFFFFFF),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onChanged: (value) {
                    // Handle search functionality here
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'title',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text('desc'),
                    Text(
                      '10/10/24  11:11pm',
                      style: TextStyle(color: Color(0xff4b4b4b)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'title',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text('desc'),
                    Text(
                      '10/10/24  11:11pm',
                      style: TextStyle(color: Color(0xff4b4b4b)),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNote()),
          );
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
