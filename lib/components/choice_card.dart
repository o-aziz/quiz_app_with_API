import 'package:flutter/material.dart';

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    Key? key,
    required this.choice,
    required this.onPress,
    required this.isAcitve,
  }) : super(key: key);
  final String choice;
  final GestureTapCallback onPress;
  final bool isAcitve;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
        decoration: BoxDecoration(
          color: isAcitve ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isAcitve
              ? [const BoxShadow(color: Colors.black54, blurRadius: 10)]
              : [],
        ),
        child: Text(
          choice,
          style: TextStyle(
            fontSize: size.width * 0.045,
            fontWeight: FontWeight.bold,
            color: isAcitve ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
