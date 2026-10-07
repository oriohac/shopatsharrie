import 'package:flutter/material.dart';
class Addtocart extends StatefulWidget {
  const Addtocart({super.key});

  @override
  State<Addtocart> createState() => _AddtocartState();
}

class _AddtocartState extends State<Addtocart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: SingleChildScrollView(child: Column(
      children: [
        Stack(children: [Container(
          decoration: BoxDecoration(color: Color(0xffE4F5E0)
          ),
        ),
        Image.network('src')
        ],),
        SizedBox(height: 8,),
        Row(children: [Image.network('src'),Image.network('src')],)
        
      ],
    ),),
    );
  }
}