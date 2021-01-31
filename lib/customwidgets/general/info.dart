import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';

import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

class InfoDialog extends StatelessWidget {
  String text;
  String title;

  InfoDialog({
    Key key,
    this.text,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: () {
          showModal(
            configuration: FadeScaleTransitionConfiguration(
              transitionDuration: Duration(milliseconds: 250),
              barrierDismissible: true,
              reverseTransitionDuration: Duration(milliseconds: 250),
            ),
            context: context,
            builder: (context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Colors.black.withOpacity(0.75),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              SectionTitle(
                                title: title,
                                color: Colors.white,
                                fontSize: 28,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  text,
                                  maxLines: 10,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.info, color: theme.textColor),
      ),
    );
  }
}
