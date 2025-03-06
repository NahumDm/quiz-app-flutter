import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizbrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
   _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];

  void checkAnswer (bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
gi
  // Add if/else condition
      if ( quizBrain.questionNumber() >= quizBrain.questionLength() - 1 ) {
         Alert(context: context,
       title: "Finished!",
       desc: "You have reached the end of the quiz.",
     buttons: [
       DialogButton(
           child: Text('CANCEL',
     style: TextStyle(color: Colors.white, fontSize: 20),
     ),
       onPressed: () {
      setState(() {
      quizBrain.resetQuiz();
      scoreKeeper.clear();
      });
      Navigator.pop(context);
      },
         color: Color.fromRGBO(0, 179, 134, 1.0),
         radius:BorderRadius.circular(0.0),
       ),
],
   ).show();
      }else if( userPickedAnswer == correctAnswer ) {
     scoreKeeper.add(Icon(Icons.check,
          color: Colors.green));
    } else {
    scoreKeeper.add(Icon(Icons.close,
    color: Colors.red));
    }

    quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
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
            child: TextButton(
            style:  TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
            ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                  checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: [
            ...scoreKeeper,
        ],
    ),
      ],
    );
  }
}
