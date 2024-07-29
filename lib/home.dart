import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_do/widgets/item_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Container(
              height:MediaQuery.of(context).size.height/1.6,
              color: Colors.orange,
              child: Column(children: [
                Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemMenu(
                    size: Size(MediaQuery.of(context).size.width / 2.5, 150),
                    text: "Box1",
                    colorBox: const Color.fromARGB(255, 244, 146, 54),
                    border: Border.all(color: Colors.blue, width: 5),
                  ),
                  const Spacer(),
                  ItemMenu(
                    size: Size(MediaQuery.of(context).size.width / 2.5, 150),
                    text: "Box2",
                    colorBox: const Color.fromARGB(255, 244, 146, 54),
                    border: Border.all(color: Colors.blue, width: 5),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemMenu(
                    size: Size(MediaQuery.of(context).size.width / 2.5, 150),
                    text: "Box3",
                    colorBox: const Color.fromARGB(255, 244, 146, 54),
                    border: Border.all(color: Colors.blue, width: 5),
                  ),
                  const Spacer(),
                  ItemMenu(
                    size: Size(MediaQuery.of(context).size.width / 2.5, 150),
                    text: "Box4",
                    colorBox: const Color.fromARGB(255, 244, 146, 54),
                    border: Border.all(color: Colors.blue, width: 5),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemMenu(
                    size: Size(MediaQuery.of(context).size.width / 2.5, 150),
                    text: "Box5",
                    colorBox: const Color.fromARGB(255, 244, 146, 54),
                    border: Border.all(color: Colors.blue, width: 5),
                  ),
                  const Spacer(),
                  ItemMenu(
                    size: Size(MediaQuery.of(context).size.width / 2.5, 150),
                    text: "Box6",
                    colorBox: const Color.fromARGB(255, 244, 146, 54),
                    border: Border.all(color: Colors.blue, width: 5),
                  ),
                ],
              ),
            )
              ],),
            )
            
          ],
        ),
      )),
    );
  }
}
