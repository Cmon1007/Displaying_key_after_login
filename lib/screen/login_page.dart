import 'dart:convert';
import 'package:displaying_key/screen/activity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isvisible=true;       //for password icon
  final _formkey=GlobalKey<FormState>();          //form key
  final usernamecontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
   
   Future<String> getKey({required String username,required String password}) async
   {
    try{
      const url="https://test.rouund.ca/mob/staff_login/";
      final uri=Uri.parse(url);
      final response=await http.post(uri,
      body: {
        'username':username,
        'password':password,
      },
      );
      if(response.statusCode==200)
      {
        return jsonDecode(response.body).toString();
      }
      else
      {
        throw Exception("Failed");
      }
    }
    catch(e)
    {
      throw "Failed to load data";
    }
   }
 
 @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          title: const Text("Sign In",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          centerTitle: true,
          leading: IconButton(onPressed: (){
          showDialog(
            barrierDismissible: false,
            context: context,
           builder: (BuildContext context) => AlertDialog(actions: [
            ListTile(
              title: Column(
                children: [
                  const Text("Do you want to close \nthe app ?",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: const Icon(Icons.check,
                        color: Colors.green,),
                        onTap: () => SystemNavigator.pop(),
                        ),
                      const SizedBox(width: 30,),
                      InkWell(
                        child: const Icon(Icons.close,
                        color: Colors.red,),
                        onTap: () => Navigator.of(context).pop(),
                        ),
                    ],
                  ),
                ],
              ),
              
            )
          ],));
          },
           icon: const Icon(Icons.arrow_back,color: Colors.black,),
           ),
          elevation: 0,
        ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome to the \nDizziHotel",style: TextStyle(fontSize: 45),),
            const Text("Enter your Phone number or Username \nand password to signin",style: TextStyle(fontSize: 17),),
            const SizedBox(height: 25,),
            Form(
              key: _formkey,
              child: Column(             
             crossAxisAlignment: CrossAxisAlignment.start,
                children: [  
                  const Text("USERNAME",style: TextStyle(color: Colors.grey),),
                 // User name field
                      TextFormField(
                      controller: usernamecontroller,
                      validator: (value) {
                        if(value==null||value.isEmpty)     //null validation
                        {
                          return "Username cannot be empty";
                        }
                        if(value!="waiter")
                        {
                          return "Invalid username";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                      hintText: "Username",
                      //icon
                      suffixIcon: Icon(Icons.check),     
                      suffixIconColor: Colors.orange
                      
                   ),
                      ),
                  const SizedBox(height: 25,),
                  const Text("PASSWORD",style: TextStyle(color: Colors.grey),),

                  //Password field
                  TextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if(value==null||value.isEmpty)    //null validation
                    {
                      return "Password field can't be empty";
                    }
                    if(value!="waiterwaiter")
                    {
                      return "Password doesn't match.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                  hintText: "Password",
                  //icon
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      isvisible=!isvisible;
                    });
                  },
                   icon: isvisible?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                   ),
                   
                    ),
                    obscureText: isvisible,
                    obscuringCharacter: "*",    //appearing text type
                 ),
                 const SizedBox(height: 50,),
               
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[400],
                  minimumSize: const Size(355, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
                  
                  onPressed: () async{
                    if (_formkey.currentState!.validate()) {
                       try {
                          final key= await getKey(
                          username: usernamecontroller.text,
                          password: passwordcontroller.text
                          );
                      
                         Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityPage(data:key),),
                        );
                          }
                     catch (e) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityPage(data:"Error"),),);
                        }
                   
                    ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(
                       content: Text("Login Successful"),
                      duration: Duration(seconds: 1),));
                     }
                  },
                 child:const Text("SIGN IN"),
                 ),
                ],
              )
              
              )
          ],
        ),
      ),
      );

  }

}

