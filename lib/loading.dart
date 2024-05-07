import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'main.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Loading(),
  ));
}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

Future<void> validation() async{
  try{
    final url = "http://localhost/devops_finals/validate.php";
    final response = await http.get(
      Uri.parse(url)
    );
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyApp()));
    });
  }catch(ex){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Error"),
        content: Text("DBServer Not Found"),
      );
    });

    Timer(Duration(seconds: 3),(){Navigator.pop(context); });
    validation();
  }
}

@override
void initState(){
  validation();

  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text('QuickNote'),
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
