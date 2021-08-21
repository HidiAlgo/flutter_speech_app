import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class InitialScreen extends StatefulWidget {


  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context)async{
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(_date.year-1),
        lastDate: DateTime(_date.year+1));

    if(_datePicker != null && _datePicker != _date){
      setState(() {
        _date = _datePicker;
        String formattedDate = DateFormat("yyyy-MM-dd").format(_datePicker);
        _dateController.text = formattedDate;
      });

      print(_date.year);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1,0.5,0.9],
              colors: [Color(0xFFF7CAD0),Color(0xFFFF5C8A),Color(0xFFFBB1BD)]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Text("APP NAME",style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  child:  Image.asset(
                    'assets/mother.png',
                    height: 200.0,
                    width: 200.0,

                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 20),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                      filled: true,
                      fillColor: Color(0xFFF7CAD0).withOpacity(0.4),
                      hintText: "Nick Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,

                      ),

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white,fontSize: 20),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                      filled: true,
                      fillColor: Color(0xFFF7CAD0).withOpacity(0.4),
                      hintText: "Age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,

                      ),

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    style: TextStyle(color: Colors.white,fontSize: 20),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                      fillColor: Color(0xFFF7CAD0).withOpacity(0.4),
                      hintText: "Pregnancy Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,

                      ),

                    ),
                    readOnly: true,
                    controller: _dateController,
                    onTap: (){
                      setState(() {
                        _selectDate(context);
                      });
                    },
                  ),
                ),
                SizedBox(height: 40,),
                InkWell(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color(0xFFF7CAD0).withOpacity(0.4),
                    ),

                    child: Icon(Icons.arrow_forward_ios,color: Color(0xFFFF5C8A),),
                  ),
                  onTap: (){
                    //todo validation data
                    //todo storing data in shared preferences
                    //todo moving to main
                    setState(() {
                      _selectDate(context);
                      print("ok");
                    });
                  },
                )

              ],
            ),
          ),
        )
      ),
    );
  }
}
