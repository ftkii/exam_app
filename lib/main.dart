import 'app_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AppBrain appBrain = AppBrain();

void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ExamApp"),
          backgroundColor: Color.fromRGBO(46, 79, 79, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ExamPage(),
        ),
      ),
    );
  }
}

class ExamPage extends StatefulWidget {
  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List<Widget> answerResult = [];
  int rightAnswer = 0;

//method
  void checkAnswer(bool whatUserPicked) {
    bool correctAnswer = appBrain.getQuestionAnswer();
    setState(() {
      if (whatUserPicked == correctAnswer) {
        rightAnswer++;
        answerResult.add(
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.thumb_up_alt,
                color: Color.fromARGB(255, 13, 116, 16)),
          ),
        );
      } else {
        answerResult.add(
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.thumb_down_alt,
                color: Color.fromARGB(255, 168, 21, 11)),
          ),
        );
      }
      if (appBrain.isFinished() == true) {
        //نهايه الاسئله
        Alert(
          context: context,
          title: "انتهاء الاختبار",
          desc: "لقد اجبت على $rightAnswer من اصل 7",
          buttons: [
            DialogButton(
              child: Text(
                "!ابدأ من جديد",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        appBrain.rest();

        answerResult = [];

        rightAnswer = 0;
      } else {
        appBrain
            .nextQuestion(); //لو مو ترو ولا وصل للاخير راح يروح للسؤال الثاني

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, //عشان يتمدد الزر
      children: [
        //الاجابات اذا صح او خطأ
        Row(children: answerResult //استدعيت الليست الي تحتوي لي مجموعه الايكون,
            ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Image.asset(appBrain.getQuestionImage()),
              SizedBox(height: 20),
              Text(
                appBrain.getQuestionteText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0), //فراغات ن فوق وتحت
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: Text('صح',
                  style: TextStyle(fontSize: 22, color: Colors.white)),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 13, 116, 16)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0), //فراغات ن فوق وتحت
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: Text('خطأ',
                  style: TextStyle(fontSize: 22, color: Colors.white)),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 168, 21, 11)),
            ),
          ),
        ),
      ],
    );
  }
}
