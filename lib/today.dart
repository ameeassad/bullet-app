import 'package:flutter/material.dart';
import 'package:bullet/const.dart';
import 'package:bullet/widgets/bulletDisplay.dart';

class TodayPageView extends StatefulWidget {
  final DateTime todayDate;

  TodayPageView({Key key, @required this.todayDate}) : super(key: key);

  @override
  TodayPageViewState createState() => TodayPageViewState(todayDate:todayDate);
}

class TodayPageViewState extends State<TodayPageView> {
  TodayPageViewState({Key key, this.todayDate});

  DateTime todayDate;
  int pageIndex = 0;
  
  PageController pageController = PageController(initialPage: 0,);
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }
  
  void tapped(int index) {
    setState(() {
      pageIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Widget topSection(){
    double leftSize, rightSize;
    if (pageIndex==0) {
      leftSize = 50.0;
      rightSize = 30.0;
    } else {
      leftSize = 30.0;
      rightSize = 50.0;
    }
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(bottom: 15.0),
      alignment: Alignment(0.0, 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: ()=> tapped(0),
            icon: Icon(
              Icons.wb_sunny,
              size: leftSize,
            ),
          ),
          Container(
            width: 30.0,
          ),
          IconButton(
            onPressed: ()=> tapped(1),
            icon: Icon(
              Icons.edit,
              size: rightSize,
            ),
          ),
        ]),
    );
  }

  void pageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  Widget todayBullets(){
    List<Widget> example;
    Widget addButton = Container(
      margin:  const EdgeInsets.only(top: 10.0),
      child: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
        onPressed: ()=> setState(() {
          print("add to list, reload all the widgets from today");
        })
      )
    );
    example = [bulletDisplay(0,todayDate), bulletDisplay(1,todayDate),bulletDisplay(2,todayDate), addButton];
    return Column(
      children: <Widget>[
        Container(height: 80.0,),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: example.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(child: example[index]),
              );
            }
          ),
        ),
      ],
    );
  }
  Widget todayJournal(){
    return Column(
      children: <Widget>[
        Container(height: 80.0,),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 15.0),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: "How did you implement today's bullets?",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        Container(
          margin:  const EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed:() => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Text("Done"),

          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        topSection(),
        PageView(
          controller: pageController,
          onPageChanged: (index) {
            pageChanged(index);
          },
          children: <Widget>[
            todayBullets(),
            todayJournal(),
          ],
        ),
      ]
    );
  }
}
