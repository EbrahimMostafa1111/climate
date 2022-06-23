import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
var kTextFieldInputDecoration = InputDecoration(
  hintText: 'enter city name',
  hintStyle: TextStyle(color: Colors.grey),
  icon: Icon(Icons.location_city,color: Colors.white,),
  filled: true,//without it no fill color appear
  fillColor: Colors.white,
  border: OutlineInputBorder(
      borderSide:BorderSide.none ,// to avoid color around the box
      borderRadius: BorderRadius.circular(10)
  ),

);