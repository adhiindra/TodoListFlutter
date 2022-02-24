import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolistflutter/todopage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: GoogleFonts.robotoTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white
      )
    ),
    home: MainPage(title:'Todo List'),
    routes: <String, WidgetBuilder> {
      '/todopage' : (BuildContext context) => new todopage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final myController = TextEditingController();
  late String name;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF36393F),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0.0,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Name"),
            SizedBox(height: 10,),
            Container(
              height: 50,
              child: TextField(
                controller: myController,
                style: TextStyle(
                  height: 0.9
                ),
                decoration: InputDecoration(
                  fillColor: Color(0xFF40444B),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 0.0)
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(onPressed: (){
              name = myController.text;
              addUser();
            },
              label: Text("Next"),
              icon: Icon(Icons.arrow_forward,size: 24,),
              style: ElevatedButton.styleFrom(
                primary: Colors.green
              ),
            )
          ]
        ),
      )
    );
  }

  void addUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(name!=""){
      await prefs.setString('username', name);
      Navigator.of(context).pushNamedAndRemoveUntil('/todopage', (Route<dynamic> route) => false);
    }else{
      print("Kosong");
      print(prefs.getString('username'));
    }

  }

}


