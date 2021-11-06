import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:line_icons/line_icons.dart';

import '../helpers/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _page = 10;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PageController pageController;

    pageController = PageController(initialPage: 10);
    pageController.addListener(
      () {
        setState(
          () {
            _page = pageController.page!;
          },
        );
      },
    );

    void onAddButtonTapped(int index) {
      pageController.animateToPage(index,
          curve: Curves.linear, duration: const Duration(milliseconds: 2000));
    }

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14609D),
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              Icons.arrow_back,
            ),
            Text('Hakiki'),
            Text('')
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue.withOpacity(0.1),
            ),
            padding: const EdgeInsets.all(15),
            width: width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red.withOpacity(0.1),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.place,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Jina la mtaa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: FlutterCodingChallenge.primaryColor,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const Icon(
                  Icons.more_horiz,
                )
              ],
            ),
          ),
          Center(
            child: Stack(
              children: [
                SizedBox(
                  height: width * 0.8,
                  width: width * .95,
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) {
                      List<Widget> cards = [];

                      for (int i = 0; i <= 11; i++) {
                        double currentPageValue = i - _page;
                        bool pageLocation = currentPageValue > 0;

                        double start = 1 +
                            max(
                              (boxConstraints.maxWidth - width * .75) -
                                  ((boxConstraints.maxWidth - width * .75) /
                                          2) *
                                      -currentPageValue *
                                      (pageLocation ? 9 : 1),
                              0.0,
                            );

                        var customizableCard = Positioned.directional(
                          top: 20 + 5 * max(-currentPageValue, 0.0),
                          bottom: 20 + 5 * max(-currentPageValue, 0.0),
                          start: start,
                          textDirection: TextDirection.ltr,
                          child: cardContents(width),
                        );
                        cards.add(customizableCard);
                      }
                      return Stack(children: cards);
                    },
                  ),
                ),
                Positioned.fill(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: 11,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: size.width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            _page = pageController.page!;
                          },
                        );

                        onAddButtonTapped(_page.toInt() - 1);
                      },
                      child: const Icon(
                        Icons.clear,
                        size: 25,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(8),
                        primary: Colors.red,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            _page = pageController.page!;
                          },
                        );

                        onAddButtonTapped(_page.toInt() - 1);
                      },
                      child: const Icon(
                        Icons.done,
                        size: 50,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: const Icon(
                          LineIcons.share,
                          size: 25,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(8),
                        primary: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container cardContents(double width) {
    return Container(
      height: width * .67,
      width: width * .67,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          color: FlutterCodingChallenge.lightGrey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: const Color(0xFFF6C83E),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      '19',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * .04,
                ),
                const Text(
                  '16102 Ghana, Mwanza',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
        _title("Jina Maarufu"),
        _subTitle("Rock City Mall"),
        _title('Aina ya Huduma'),
        _subTitle('Benki,Bar,Mgahawa,Chuo,Duka'),
        _title('Jina la Huduma'),
        _subTitle('CRDB Bank,NMB Bank')
      ]),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10)
        ],
      ),
    );
  }

  Padding _subTitle(String subTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
      ),
      child: Text(
        subTitle,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 5,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
