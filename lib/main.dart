import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Container( //Outer Box
                alignment: const Alignment(-1, -1), //alignment for innerbox 
                height: 200,
                width: 350,
                padding:const EdgeInsets.only(top:20,left:20,right:20,bottom:10),
                decoration: BoxDecoration(
                  color:const Color.fromARGB(255, 156, 91, 45),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                   Stack(
                  children: [
                    Container(          //inner Box
                        width: 330,
                        height: 75,
                        alignment:const Alignment(-0.7,0.05), //alignment for text
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(255, 86, 46, 15),
                          borderRadius: BorderRadius.circular(15)
                        ),                        
                        child: const Text('Temperature  :    ', //inner box and text is inside the stack child of the main container
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Tiro Kannada',
                                color: Color.fromARGB(255, 245, 250, 255))),
                        )]),
                   const SizedBox(
                    height: 25,
                   ),
                   const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    //SizedBox(
                      //width : 200,
                      //height: 50,
                      //child: Stack(
                      //children:[ 
                        //Container(
                        //padding:const EdgeInsets.all(20),
                        //decoration : BoxDecoration(
                          //borderRadius: BorderRadius.circular(10) ),
                           //),
                         toggleSwitch(),
                         SizedBox(width:20),
                         Bulb(isGlowing: true)

                  ,]),])
              ))); 
  }
}

//toggle function

class toggleSwitch extends StatefulWidget {
  const toggleSwitch({super.key});

  @override
  State<toggleSwitch> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<toggleSwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Color.fromARGB(255, 251, 251, 251),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}

//Bulb
class Bulb extends StatelessWidget {
  final bool isGlowing;

  const Bulb({Key? key, required this.isGlowing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isGlowing ? Colors.yellow : Colors.grey,
        boxShadow: isGlowing
            ? [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.6),
                  spreadRadius: 10,
                  blurRadius: 30,
                ),
              ]
            : [],
      ),
      child: Center(
        child: Icon(
          Icons.lightbulb,
          size: 50,
          color: isGlowing ? Colors.orange : Colors.black,
        ),
      ),
    );
  }
}