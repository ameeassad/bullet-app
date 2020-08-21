import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget bulletDisplay(int type, DateTime entryDate){
  IconData myIcon;
  if (type==0){
    myIcon = Icons.format_quote;
  }
  else if (type==1){
    myIcon = Icons.play_circle_filled;
  }
  else if (type==2){
    myIcon = Icons.cloud_queue;
  }
  else if (type==3){
    myIcon = Icons.http;
  }
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
              myIcon,
              size: 20.0,
            ),
          Text(DateFormat('dd MMM yy').format(entryDate)),
        ]
      ),
      Container(
        child: Text("This is a quote or video or thought or link."),
      ),
      Container(
        child: Text("This is the comments if there are any!"),
      ),
    ],
    );
  }