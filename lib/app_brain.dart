import 'question.dart';

class AppBrain {
  int _questionNumber = 0; //تعريف متغير عشان اعرف اتا في اي سؤال حاليا

  List<Question> _questionGroup = [
    Question(
      q: 'عدد الكواكب بالمجموعة الشمسية هي ثمانية كواكب؟',
      i: 'images/image-1.jpg',
      a: true,
    ),
    Question(
      q: 'القطط هي حيوانات لاحمة؟',
      i: 'images/image-2.jpg',
      a: true,
    ),
    Question(
      q: 'الصين موجودة بالقارة الأفريقية؟',
      i: 'images/image-3.jpg',
      a: false,
    ),
    Question(
      q: 'الأرض مسطحة وليست كروية؟',
      i: 'images/image-4.jpg',
      a: false,
    ),
    Question(
      q: 'باستطاعة الانسان البقاء على قيد الحياة بدون اكل اللحوم؟',
      i: 'images/image-5.jpg',
      a: true,
    ),
    Question(
      q: 'الشمس تدور حول الأرض والأرض تدور حول القمر؟',
      i: 'images/image-6.jpg',
      a: false,
    ),
    Question(
      q: 'الحيوانات لاتشعر بالألم؟',
      i: 'images/image-7.jpg',
      a: false,
    ),
  ];

  void nextQuestion() {
    // تفحص لو باقي عندنا اسئله قبل لا تزود
    // 6 < 7 - 1
    //اذاالكويسشن نمبر اقل من 6 بنكون بامان
    if (_questionNumber < _questionGroup.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionteText() {
    return _questionGroup[_questionNumber].questionText!;
  }

  String getQuestionImage() {
    return _questionGroup[_questionNumber].questionImage!;
  }

  bool getQuestionAnswer() {
    return _questionGroup[_questionNumber].questionAnswer!;
  }

//من المثود هذي اعرف اذا اليزر وصل للسؤال الاخير
  bool isFinished() {
    if (_questionNumber >= _questionGroup.length - 1) {
      return true;
    } else {
      return false;
    }
  }
//المثود ترجع قسمه عدد الاسئله للصفر لما استدعيها يعني ارجع للسؤال الاول
  void rest() {
    _questionNumber = 0;
  }
}
