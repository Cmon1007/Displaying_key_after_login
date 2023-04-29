import 'package:flutter/material.dart';
class ActivityPage extends StatelessWidget {
  final String data;
  const ActivityPage({super.key,required this.data});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Activity Page",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                  Center(
                    child: Column(
                      children: [
                        Text("Key value is: $data"),
                        const SizedBox(height: 15,),
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[200],
                          minimumSize: const Size(300, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        onPressed: (){
                        Navigator.of(context).pop();
                       },
                        child:const Text("Go Back",style: TextStyle(color: Colors.black),))
                      ],
                    ),
                    
                  )
            
              ],
            ),
        
        ),
    );

  }
}
