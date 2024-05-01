import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Loading(),
  ));
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text('App Name'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Image.network("https://media1.giphy.com/media/YMM6g7x45coCKdrDoj/giphy.gif?cid=6c09b952ie13wn96bpurngdeew5yz6v2q3m5piiagbfxkran&ep=v1_internal_gif_by_id&rid=giphy.gif&ct=s"),
            ],
          ),
        ),
      ),

    );
  }
}
