import 'package:flutter/material.dart';
import 'package:bullet/const.dart';
import 'package:bullet/widgets/bulletDisplay.dart';
import 'package:intl/intl.dart';


class BulletsPageView extends StatefulWidget {
  BulletsPageView({Key key}) : super(key: key);

  @override
  BulletsPageViewState createState() => BulletsPageViewState();
}

class BulletsPageViewState extends State<BulletsPageView> {
  BulletsPageViewState({Key key});

  DateTime todayDate;
  DateTime selectedDate;
  int pageIndex = 0;
  int typeIndex = 0;
  
  PageController pageController = PageController(initialPage: 0,);
  PageController typeController = PageController(initialPage: 0,);

  final TextEditingController entryTextEditingController = TextEditingController();
  final TextEditingController commentsTextEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    todayDate = DateTime.now();
    selectedDate = todayDate;
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
              Icons.add,
              size: leftSize,
            ),
          ),
          Container(
            width: 30.0,
          ),
          IconButton(
            onPressed: ()=> tapped(1),
            icon: Icon(
              Icons.grain,
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

  Widget chooseType(){
    return Container(
      child: PageView(
          controller: typeController,
          onPageChanged: (index) {
            setState(() {
              typeIndex = index;
            });
          },
          children: <Widget>[
            Icon(Icons.format_quote),
            Icon(Icons.play_circle_filled),
          ],
        ),
    );
  }

  int _selectedType;
  
  Widget addBullet(){
    List<String> _types = ['Quote', 'Video', 'Thought', 'Link'];
    return Column(
      children: <Widget>[
        Container(height: 80.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: DropdownButton(
                hint: Text('Type'),
                value: _selectedType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                items: _types.map((type) {
                  return DropdownMenuItem(
                    child: FlatButton.icon(
                      onPressed: null, 
                      icon: (type=='Quote') ? Icon(Icons.format_quote)
                      : (type=='Video') ? Icon(Icons.play_circle_filled)
                      : (type=='Thought') ? Icon(Icons.cloud_queue)
                      : Icon(Icons.http), 
                      label: Text(type)
                      ),
                    value: type,
                  );
                }).toList(),
              ),
            ),
            FlatButton(
              child: Text("Date: " + DateFormat('dd MMM yy').format(selectedDate)),
              onPressed: () async{
                  DateTime date = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(2010), 
                  lastDate: DateTime.now().add(Duration(days: 1)));
                  if (date != null){
                      setState((){
                          selectedDate = date;
                      });
                  }
              },
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            style: TextStyle(fontSize: 15.0),
            controller: entryTextEditingController,
            decoration: InputDecoration.collapsed(
              hintText: "add entry here",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            style: TextStyle(fontSize: 15.0),
            controller: commentsTextEditingController,
            decoration: InputDecoration.collapsed(
              hintText: "add comments here",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
  Widget allBullets(){
    List<Widget> example = [bulletDisplay(0,todayDate), bulletDisplay(1,todayDate),bulletDisplay(2,todayDate)];
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
            addBullet(),
            allBullets(),
          ],
        ),
      ]
    );
  }
}
