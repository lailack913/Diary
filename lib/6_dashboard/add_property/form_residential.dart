import 'package:flutter/material.dart';
import 'package:diary/templates/other_templates.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';


var area_Controller = TextEditingController();
var interface_Controller = TextEditingController();
var depth_Controller = TextEditingController();
var price_Controller = TextEditingController();
var location_Controller = TextEditingController();
var location_link_Controller = TextEditingController();
var describtion_Controller  = TextEditingController();





class form_residential extends StatefulWidget {
  const form_residential({Key? key}) : super(key: key);

  @override
  State<form_residential> createState() => _form_residentialState();
}

class _form_residentialState extends State<form_residential> {

  late File _file;
  late String img;
  late String img64;


  Future img_picker(ImageSource source)async{
    final  myfile = await ImagePicker().pickImage(source: source);
    setState(() {
      if(myfile==null) return print("error =>>> null");
      _file = File(myfile.path);
    });
  }
  Future upload() async {
    setState(() {
      if (_file == null) return print("//////////////file is null<<<<<<<<<<");
      String imageName = _file.path.split("/").last ;
      String img640= base64Encode(_file.readAsBytesSync());
      print("//////////////this is encoded file");
      print(img640);
      print("//////////////this is file");
      print(_file);
      print("//////////////this is imageName");
      print(imageName);

      img=imageName;
      img64 = img640;
    });
  }
  Future doit() async {
    setState(() {
      if (_file == null) return print("//////////////file is null<<<<<<<<<<");
      String imageName = _file.path.split("/").last ;
      String img640= base64Encode(_file.readAsBytesSync());
      img=imageName;
      img64 = img640;
    });
  }

  Future send() async {
    var url = Uri.parse("http://localhost:3007/try");
    Map<String, String> headers = {"Content-type": "application/json"};

    String json = '{"img": "$img",'
        ' "img64": "$img64"}';
    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body1 = response.body;
    var data = jsonDecode(body1);
    print(data);
    var res = data["code"];

    if (res == null) {
      print("its null dearling");
    }
  }


  @override
  /// main var
  String _residential_type="house";
  String _sell_rent="??????";
  String _price_type = "??????";

  /// thse vars re helping to set values for the main vars

  bool _b_price_type = true; /// <<< true=thousand, false=million

  /// defult choice of residential_type will be the house
  bool _b_house=true;
  bool _b_departmaent=false;
  bool _b_mushtamal =false;
  bool _b_vila = false;

  bool _b_sell_rent=true; /// <<< true=sell, false=rent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Diary_appbar_color,
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 9,right: 9),
                child: Text("?????????? ???????? - ??????",style: TextStyle(fontSize: 23),))
          ],
      ),

      body: SafeArea(
        child:
        SingleChildScrollView(
          child:
          Container(
            padding: EdgeInsets.all(30),
            width: other_templates.width(context),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(":???? ??????",style: TextStyle(fontSize: 23),),

                // set _sell_rent withe help of _b_sell_rent
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: other_templates.selsection(
                          other_templates.height(context)/13,
                          other_templates.width(context)/2.5,
                          23, "??????????", _b_sell_rent),
                      onTap: (){
                        setState(() {
                          _sell_rent="??????????";
                          _b_sell_rent=true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: other_templates.selsection(
                          other_templates.height(context)/13,
                          other_templates.width(context)/2.5,
                          23, "??????????????", !_b_sell_rent),
                      onTap: (){
                        setState(() {
                          _sell_rent="??????????????";
                          _b_sell_rent=false;
                        });
                      },
                    )
                  ],
                ),

                Text(":??????????",style: TextStyle(fontSize: 23),),

                // set _residential_type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: other_templates.selsection(
                          other_templates.height(context)/13,
                          other_templates.width(context)/5,
                          23, "????????", _b_vila),
                      onTap: (){
                        setState(() {

                          _residential_type="????????";

                          _b_house=false;
                          _b_departmaent=false;
                          _b_mushtamal=false;
                          _b_vila=true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: other_templates.selsection(
                          other_templates.height(context)/13,
                          other_templates.width(context)/5,
                          23, "??????????", _b_mushtamal),
                      onTap: (){
                        setState(() {

                          _residential_type="??????????";

                          _b_house=false;
                          _b_departmaent=false;
                          _b_mushtamal=true;
                          _b_vila=false;
                        });
                      },
                    ),
                    GestureDetector(
                      child: other_templates.selsection(
                          other_templates.height(context)/13,
                          other_templates.width(context)/5,
                          23, "??????", _b_departmaent),
                      onTap: (){
                        setState(() {

                          _residential_type="??????";

                          _b_house=false;
                          _b_departmaent=true;
                          _b_mushtamal=false;
                          _b_vila=false;
                        });
                      },
                    ),
                    GestureDetector(
                      child: other_templates.selsection(
                          other_templates.height(context)/13,
                          other_templates.width(context)/5,
                          23, "??????", _b_house),
                      onTap: (){
                        setState(() {

                          _residential_type="??????";

                          _b_house=true;
                          _b_departmaent=false;
                          _b_mushtamal=false;
                          _b_vila=false;
                        });
                      },
                    )
                  ],
                ),

                Text(":?????????????????????????? ???????????? ????????????",style: TextStyle(fontSize: 23),),

                other_templates.Diary_TextField(area_Controller, ''),

                // interface & depth
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: other_templates.width(context)/2.7,
                      child:  Column(
                        crossAxisAlignment:CrossAxisAlignment.end,
                        children: [
                          Text(":??????????????",style: TextStyle(fontSize: 23),),

                          other_templates.Diary_TextField(interface_Controller, '')

                        ],
                      ),
                    ),

                    SizedBox(width: other_templates.width(context)/17,),

                    Container(
                      height: 100,
                      width: other_templates.width(context)/2.7,
                      child:
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.end,
                        children: [
                          Text(":????????????",style: TextStyle(fontSize: 23),),

                          other_templates.Diary_TextField(depth_Controller, '')

                        ],
                      ),
                    )


                  ],
                ),

                // set _price_type with help of _b_price_type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: other_templates.tow_choices_bar(
                          _b_price_type, _price_type, "??????", "??????????"
                      ),
                      onTap:(){
                        setState(() {
                          _b_price_type=!_b_price_type;
                          _b_price_type? _price_type= "??????": _price_type= "??????????";
                        });
                      },
                    ),


                    Text(":?????????? ???????????????? ??????????????",style: TextStyle(fontSize: 23),),
                  ],
                ),

                other_templates.Diary_TextField(price_Controller, ''),

                Text(":????????????",style: TextStyle(fontSize: 23),),

               other_templates.Diary_TextField(location_Controller, ''),

                Text(":???????? ????????????",style: TextStyle(fontSize: 23),),

                other_templates.Diary_TextField(location_link_Controller, ''),

                Text(":?????????? ???????????? ????????????????",style: TextStyle(fontSize: 23),),

               Row(
                 children: [
                   ElevatedButton(
                       onPressed: () => img_picker(ImageSource.camera)
                       ,
                       child: Row(
                         children: [
                           Text("???????????? ????????"),
                           Icon(Icons.camera_alt)
                         ],
                       ),
                       style: ElevatedButton.styleFrom(
                           primary: Diary_button_color
                       )
                   ),
                   SizedBox(width: 19,),
                   
                   ElevatedButton(
                       onPressed: ()  =>  img_picker(ImageSource.gallery)
                       ,
                       child: Row(
                         children: [
                           Text("???????????? ???????? ???? ????????????"),
                           Icon(Icons.image)
                         ],
                       ),
                       style: ElevatedButton.styleFrom(
                           primary: Diary_button_color
                       )
                   ),

                 ],
               ),


                Text(":?????????? ?????? ??????????",style: TextStyle(fontSize: 23),),

                Text(":?????????? ?????????? ???????? ??????????????",style: TextStyle(fontSize: 23),),

                Text(":?????????? ?????? ??????????",style: TextStyle(fontSize: 23),),

                other_templates.Diary_TextField(describtion_Controller, ''),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _file==null ?  print("error =====>>> null") : print(_file);
                          upload();
                     //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => test(img: _file) ));

                          });
                      },
                      child:
                      Text("????????????",style: TextStyle(fontSize: 23),),
                      style: ElevatedButton.styleFrom(
                        primary: Diary_button_color
                      )
                    )
                  ],
                )
              ],
            )
          ),
        ),
      ),

    );
  }


}
