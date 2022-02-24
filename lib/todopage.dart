import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class todopage extends StatefulWidget {
  const todopage({Key? key}) : super(key: key);

  @override
  _todopageState createState() => _todopageState();
}

class _todopageState extends State<todopage> {

  String username = 'username';
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late DateTime Date;
  var colorData;

  List<String>title = [];
  List<String>status = [];
  List<DateTime> date = [];


  @override
  void initState() {
    super.initState();
    getPrefData();
    title.add("Submit Code Taksu");
    status.add('OPEN');
    date.add(DateTime.now());

  }

  void getPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
    });

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
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hi, "+username,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(height: 20,),
            Container(
              height: 550,
              child: ListView.builder(
                itemCount: title.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  colorData = status[index] == "OPEN" ? Colors.grey :
                  status[index] == "DONE" ? Colors.green :
                  DateTime.now() != date[index] ? Colors.red : null ;

                  String dateFormat = DateFormat('yyyy-MM-dd – kk:mm').format(date[index]);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Color(0xFF40444B),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorData,
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                                      child: Text('OPEN',style: TextStyle(
                                          fontSize: 10,fontWeight: FontWeight.bold
                                      ),)),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black,
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        print('test');
                                        title.removeAt(index);
                                        status.removeAt(index);
                                        date.removeAt(index);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(Icons.restore_from_trash,
                                        color: Colors.white,
                                        size: 20,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text(title[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Due Date:"),
                                    Text(dateFormat)
                                  ],
                                ),
                                SizedBox(
                                  width: 80,
                                  child: status[index] == "OPEN" || status[index] == "OVERDUE" ? ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        status[index] = "DONE";
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF5440D1)
                                    ),
                                    child: Text("DONE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ) : null
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        onPressed: () {
          addData();

        },
        child: Icon(Icons.add,size: 32,),
      ),
    );
  }

  Future addData(){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Color(0xFF36393F),
            title: Text("New Todo"),
            content:
            Container(
              height: 310,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Title"),
                  SizedBox(height: 10,),
                  Container(
                    child: TextField(
                      controller: titleController,
                      style: TextStyle(
                          height: 1
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xFF40444B),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 0.0)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Due Date"),
                  SizedBox(height: 10,),
                  Container(
                    child: TextField(
                      controller: dateController,
                      onTap: () async{
                        DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2100),
                          onChanged: (date){
                            Date = date;
                            String dateFormat = DateFormat('yyyy-MM-dd – kk:mm').format(date);
                            dateController.text = dateFormat.toString();
                          }
                        );},
                      style: TextStyle(
                          height: 1
                      ),
                      decoration: InputDecoration(
                        fillColor: Color(0xFF40444B),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 0.0)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 33,),
                  Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(onPressed: (){
                            setState(() {
                              if(titleController.text != "" && date!= null){
                                title.add(titleController.text);
                                date.add(Date);
                                status.add("OPEN");
                                titleController.text = "";
                                dateController.text = "";
                                Navigator.pop(context);
                              }
                            });
                          },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF5440D1)
                            ), child: Text("Save"),
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                          titleController.text = "";
                          dateController.text = "";

                        },
                           child: Text("Cancel",
                             style: TextStyle(
                               color: Colors.white
                             ) ,),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }


}
