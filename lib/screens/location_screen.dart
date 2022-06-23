import 'package:flutter/material.dart';
import 'package:testing/screens/city_screen.dart';
import 'package:testing/services/weather.dart';
import 'package:testing/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeatherData;
  LocationScreen({this.locationWeatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //create object from weather model to get icons
  WeatherModel weatherModel=WeatherModel();
  int? temp;
  String? cityName;
  int? condition;
  String? weatherIcon;
  String? weatherMessage;
  String? typedCityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.locationWeatherData);
  }
  void updateUi(dynamic weatherData){
    setState(() {
      if (weatherData==null){
        temp = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return; // put here to continue next step note there is no else
      }
      double doubleTemp=weatherData['main']['temp'];
      temp=doubleTemp.toInt();
      cityName=weatherData['name'];
      condition=weatherData['weather'][0]['id'];
      weatherIcon=weatherModel.getWeatherIcon(condition!);
      weatherMessage=weatherModel.getMessage(temp!);
      // print(temp);
      // print(cityName);
      //  print(condition);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('images/location_background.jpg'),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(
          //       Colors.white.withOpacity(0.8), BlendMode.dstATop),
          // ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData= await weatherModel.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     typedCityName=await  Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                     if(typedCityName!=null){
                       var weatherData=await weatherModel.getCityWeather(typedCityName!);
                       updateUi(weatherData);
                     }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}