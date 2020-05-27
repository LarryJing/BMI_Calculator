import 'package:bmi_calculator/Calculator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/ReusableCard.dart';
import 'package:bmi_calculator/InsideCard.dart';
import 'package:bmi_calculator/RoundIconButton.dart';
import 'package:bmi_calculator/Results.dart';

const bottomHeight = 80.0;
const activeCardColor = Color(0xff1e1d33);
const inactiveCardColor = Color(0xff111328);
const bottomColor = Color(0xffeb1555);
const kNumberStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);
const kLabelStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0xff8d8e98),
);

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender person;
  int height = 170;
  int weight = 60;
  int age = 20;
  void increaseWeight() {
    weight++;
  }

  void decreaseWeight() {
    weight--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Expanded(
                child: ReusableCard(
                  person == Gender.male ? activeCardColor : inactiveCardColor,
                  cardChild: InsideCard(FontAwesomeIcons.mars, 15.0, 'MALE'),
                  func: () {
                    setState(() {
                      person = Gender.male;
                    });
                  },
                ),
              ),
              Expanded(
                child: ReusableCard(
                  person == Gender.female ? activeCardColor : inactiveCardColor,
                  cardChild: InsideCard(FontAwesomeIcons.venus, 15.0, 'FEMALE'),
                  func: () {
                    setState(() {
                      person = Gender.female;
                    });
                  },
                ),
              ),
            ]),
          ),
          Expanded(
            child: ReusableCard(
              activeCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberStyle,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'CM',
                        style: kLabelStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0xff8d8e98),
                      thumbColor: Color(0xffeb1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                      overlayColor: Color(0x30eb1555),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Expanded(
                child: ReusableCard(
                  activeCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'WEIGHT',
                        style: kLabelStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            weight.toString(),
                            style: kNumberStyle,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'KG',
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            Icon(FontAwesomeIcons.minus),
                            f: () {
                              setState(() {
                                decreaseWeight();
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                            Icon(FontAwesomeIcons.plus),
                            f: () {
                              setState(() {
                                increaseWeight();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  activeCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'AGE',
                        style: kLabelStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumberStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            Icon(FontAwesomeIcons.minus),
                            f: () {
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                            Icon(FontAwesomeIcons.plus),
                            f: () {
                              setState(() {
                                age++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () {
              Calculator brain = Calculator(height, weight, age);
              String bmi = brain.calculateBMI();
              String result = brain.calculateResult();
              String exp = brain.getExplanation();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Results(result, bmi, exp);
              }));
            },
            child: Container(
              child: Center(
                child: Text(
                  'CALCULATE',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              color: bottomColor,
              height: bottomHeight,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(bottom: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}
