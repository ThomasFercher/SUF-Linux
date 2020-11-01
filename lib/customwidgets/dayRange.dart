import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DayRange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              stops: [0.1, 1.4],
              colors: [Color(0xFFfad0c4), Color(0xFF000C40)],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 50,
                height: 50,
                child: FlareActor(
                  'assets/flares/sun.flr',
                  alignment: Alignment.center,
                  animation: "Moon Rings",
                  color: Colors.deepOrange,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "06:00",
                    style:
                        GoogleFonts.nunito(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "18:00",
                  style: GoogleFonts.nunito(color: Colors.white, fontSize: 24),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                width: 50,
                height: 50,
                child: FlareActor(
                  'assets/flares/moon.flr',
                  alignment: Alignment.center,
                  animation: "Moon Rings",
                  color: Colors.white,
                  //  color: Colors.yellow[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
