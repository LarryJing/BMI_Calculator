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

enum Gender { male, female }
enum System { metric, US }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  static System units = System.metric;
  Gender person;
  int height = 170;
  int weight = 60;
  void increaseWeight() {
    weight++;
  }

  void decreaseWeight() {
    weight--;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final kNumberStyle = TextStyle(
      fontSize: screenHeight / 20,
      fontWeight: FontWeight.w900,
    );
    final kLabelStyle = TextStyle(
      fontSize: screenHeight / 44,
      color: Color(0xff8d8e98),
    );
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
                  cardChild: InsideCard(
                    FontAwesomeIcons.mars,
                    screenHeight / 120,
                    'MALE',
                    iconSize: 80.0,
                  ),
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
                  cardChild: InsideCard(
                    FontAwesomeIcons.venus,
                    screenHeight / 120,
                    'FEMALE',
                    iconSize: 80.0,
                  ),
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
                    height: screenHeight / 179,
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
                        units == System.metric ? 'CM' : 'IN',
                        style: kLabelStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0xff8d8e98),
                      thumbColor: Color(0xffeb1555),
                      thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: screenHeight / 120),
                      overlayShape: RoundSliderOverlayShape(
                          overlayRadius: screenHeight / 60),
                      overlayColor: Color(0x30eb1555),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: units == System.metric ? 120 : 40,
                      max: units == System.metric ? 220 : 90,
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
                            units == System.metric ? 'kg' : 'lb',
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 179,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ReusableCard(
                          units == System.metric
                              ? inactiveCardColor
                              : activeCardColor,
                          cardChild: InsideCard(FontAwesomeIcons.globe,
                              screenHeight / 120, 'METRIC'),
                          func: () {
                            setState(() {
                              height = 170;
                              weight = 60;
                              units = System.metric;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          units == System.US
                              ? inactiveCardColor
                              : activeCardColor,
                          cardChild: InsideCard(FontAwesomeIcons.flagUsa,
                              screenHeight / 120, 'IMPERIAL'),
                          func: () {
                            setState(() {
                              height = 65;
                              weight = 130;
                              units = System.US;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () {
              Calculator brain;
              units == System.metric
                  ? brain = Calculator(height.toDouble(), weight.toDouble())
                  : brain = Calculator(height * 2.54, weight * 0.454);
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
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              color: bottomColor,
              height: bottomHeight,
              width: double.infinity,
              margin: EdgeInsets.only(top: screenHeight / 179),
              padding: EdgeInsets.only(bottom: screenHeight / 120),
            ),
          ),
        ],
      ),
    );
  }
}
