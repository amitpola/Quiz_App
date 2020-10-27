import 'dart:ui';
import 'package:flutter/material.dart';
import 'Question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain quizbrain=QuestionBrain();

void main(){
  return runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}
class _QuizpageState extends State<Quizpage> {

  List<Widget> correctCounts=[];

  void correctAnswers(bool answer){
    bool correctAnswer= quizbrain.getCorrectAnswer();

      setState(() {

        if(quizbrain.isFinished()==true){
          Alert(
            context: context,
            title: 'Finished',
            desc: 'End of quiz is reached',
          ).show();

          quizbrain.reset();

          correctCounts=[];
        }
        else {
          if (correctAnswer == answer) {
            correctCounts.add(Icon(Icons.check, color: Colors.green,),);

          }
          else {
            correctCounts.add(Icon(Icons.close, color: Colors.red,),);

          }
          quizbrain.nextQuestion();
        }
      });

  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionMethod(),
                 textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: (){

                correctAnswers(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: (){
                correctAnswers(false);
                }
            ),
          ),
        ),
        Row(
          children: correctCounts,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

