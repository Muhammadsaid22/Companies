import 'package:companies_items_a/repositories/auth_repository.dart';
import 'package:companies_items_a/services/cashe_keys.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../company/companies_list.dart';
import '../../models/verify_model.dart';
class LoginPage extends StatelessWidget {
  String showm = '';
  void showbottom(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: (440.0),
            width: (375.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.orange.shade900,
                      Colors.orange.shade800,
                      Colors.orange.shade400
                    ]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPTextField(
                  length: 4 ,
                  width: MediaQuery.of(context).size.width * 0.9,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: (54.0),
                  fieldStyle: FieldStyle.box,
                  onChanged: (value) {
                    showm = value;
                  },
                  outlineBorderRadius: (15.0),
                  style: TextStyle(
                    fontSize: (26.0),
                    color: Colors.blue,
                  ),
                  onCompleted: (pin) {
                    debugPrint("Completed: " + pin);
                  },
                ),
                SizedBox(
                  height: (10.0),
                ),
                SlideCountdown(
                  duration: Duration(minutes: 2),
                  icon: Icon(Icons.timer_rounded),
                  fade: true,
                ),
                SizedBox(
                  height: (40.0),
                ),
                ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(
                          (295.0),
                          (54.0),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                (12.0)))),
                    child: Text('Continue'),
                    onPressed: () async  {
                      Map<String, String> header = {
                        'Content-Type': 'application/json'
                      };
                      Map body = {
                        "phoneNumber" : "${_phone.text}",
                        "code":"$showm"
                      };
                      final verify = await AuthRepository().verify(header, body);
                      if(verify is Verify){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ComoaniesList(verify.token)),
                          ModalRoute.withName('/'),
                        );
                      }
                    }),

              ],
            ),
          ),
        );
      },
    );
  }
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400
                ]
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.red.shade700
                    ),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      hintMaxLines: 1,

                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 8, top: 20 ),
                      hintText: 'Ism',
                    labelStyle: TextStyle(
                      fontSize: 18
                    )
                  ),

                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red.shade800
                  ),
                    borderRadius: BorderRadius.circular(16)
                ),
                child:  TextField(
                  controller: _phone,
                  decoration: InputDecoration(
                      hintMaxLines: 1,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 10, top: 20),
                      hintText: 'Telefon',labelStyle: TextStyle(
                    fontSize: 18
                  )
                  ),


                ),
              ),
              SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: Size(
                        (240.0),
                        (50.0),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              (12.0)))),
                  child: Text('Login'),
                  onPressed: ()  async{
                    Map<String, String> header = {
                      'Content-Type': 'application/json'
                    };
                    Map body = {
                      "phoneNumber" : "${_phone.text}",
                    };
                    print(_phone.text);
                   final login = await AuthRepository().login(header,body);
                   if(login != null){
                     showbottom(context);
                   }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
Future<void> Data(Userdate) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(('userdate'), Userdate);

}