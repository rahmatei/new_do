import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  final Size size;
  final String text;
  final Color? colorBox;
  final BoxBorder? border;
  const ItemMenu({
    super.key, required this.size, required this.text, this.colorBox, this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: colorBox,
        border: border ,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: const Color.fromARGB(255, 126, 126, 126)
                  .withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5)
        ],
      ),
      child: Center(child: Text(text)),
    );
  }
}
