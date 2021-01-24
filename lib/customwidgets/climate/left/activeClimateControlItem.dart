import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActiveClimateControlItem extends StatelessWidget {
  final String value;
  final String lable;
  final IconData icon;
  final double height;
  final MaterialColor color;

  const ActiveClimateControlItem({
    Key key,
    this.value,
    this.lable,
    this.icon,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
      leading: Container(
        height: height - 8,
        width: height - 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white24,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: height / 3,
        ),
      ),
      title: Container(
        height: height,
        alignment: Alignment.centerLeft,
        child: Text(
          lable,
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      trailing: Text(
        value,
        style: GoogleFonts.nunito(
          color: Colors.white,
          fontWeight: FontWeight.w100,
          fontSize: 22,
        ),
      ),
    );
  }
}
