import 'package:flutter/material.dart';
import 'package:quiz_app/const.dart';
import 'package:quiz_app/model/quiz.model.dart';
import 'package:quiz_app/services/quiz.services.dart';
import 'package:quiz_app/views/results.view.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({Key? key, required this.quizData}) : super(key: key);
  final List<Result> quizData;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizServices quizServices = QuizServices();
  bool isBottomBtnVisible = false;
  PageController pageController = PageController();
  @override
  void initState() {
    quizServices.updateQuizData(widget.quizData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: quizServices,
        builder: (context, snapshot) {
          return Scaffold(
            body: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                        gradient: kBackgroundColor,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          itemCount: widget.quizData.length,
                          itemBuilder: (context, pageViewIndex) {
                            return Container(
                              padding:
                                  const EdgeInsets.all(kDefaultPadding / 2),
                              width: constraints.maxWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 50),
                                  Text(
                                    "Question ${pageViewIndex + 1} of ${widget.quizData.length}",
                                    style: const TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: kDefaultPadding),
                                  Text(
                                    widget.quizData[pageViewIndex].question,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: kDefaultPadding / 4),
                                  const Padding(
                                    padding: EdgeInsets.all(kDefaultPadding),
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.4,
                                    width: constraints.maxWidth,
                                    child: ListView.builder(
                                      itemCount: quizServices
                                          .answers[pageViewIndex]?.length,
                                      itemBuilder: (context, index) {
                                        return QuizAnswerCard(
                                          constraints: constraints,
                                          answer: quizServices
                                              .answers[pageViewIndex]![index],
                                          isCorrect:
                                              index == quizServices.correctIdx,
                                          isFalse:
                                              index == quizServices.falseIdx,
                                          press: () {
                                            if (quizServices
                                                .isTapAnswerAllowed) {
                                              if (widget.quizData[pageViewIndex]
                                                      .correctAnswer ==
                                                  quizServices.answers[
                                                      pageViewIndex]![index]) {
                                                quizServices
                                                    .updateCorrectIdx(index);
                                                quizServices.score++;
                                                setState(() {
                                                  isBottomBtnVisible = true;
                                                });
                                              } else {
                                                quizServices
                                                    .updateFalseIdx(index);
                                                quizServices.updateCorrectIdx(
                                                    quizServices
                                                        .answers[pageViewIndex]!
                                                        .indexOf(widget
                                                            .quizData[
                                                                pageViewIndex]
                                                            .correctAnswer));
                                                setState(() {
                                                  isBottomBtnVisible = true;
                                                });
                                              }
                                              quizServices.isTapAnswerAllowed =
                                                  false;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Visibility(
                                    visible: isBottomBtnVisible,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (pageViewIndex !=
                                            widget.quizData.length - 1) {
                                          quizServices.correctIdx = 6;
                                          quizServices.falseIdx = 6;
                                          isBottomBtnVisible = false;
                                          quizServices.isTapAnswerAllowed =
                                              true;
                                          pageController
                                              .jumpToPage(pageViewIndex + 1);
                                        } else {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ReslutsScreen(
                                                quizServices: quizServices,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: constraints.maxWidth * 0.75,
                                        height: 60,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffCE9D2A),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              pageViewIndex !=
                                                      widget.quizData.length - 1
                                                  ? "Next Question"
                                                  : "See Results",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                            const SizedBox(
                                                width: kDefaultPadding),
                                            const Icon(Icons.arrow_forward_ios)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }
}

class QuizAnswerCard extends StatelessWidget {
  const QuizAnswerCard({
    Key? key,
    required this.constraints,
    required this.answer,
    required this.isCorrect,
    required this.press,
    required this.isFalse,
  }) : super(key: key);
  final BoxConstraints constraints;
  final String answer;
  final bool isCorrect, isFalse;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 1.5, vertical: kDefaultPadding / 1.5),
        margin: const EdgeInsets.only(bottom: kDefaultPadding / 2),
        width: constraints.maxWidth * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isCorrect
                ? Colors.green
                : isFalse
                    ? Colors.red
                    : Colors.transparent,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.75,
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.05,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
            ),
            const Spacer(),
            if (isCorrect)
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
            if (isFalse)
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
          ],
        ),
      ),
    );
  }
}
