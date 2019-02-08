import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class CustomTab extends StatefulWidget {

  int pageCount;
  Color overlayColor=Colors.white.withAlpha(1000);
  Color backgroundColor;
  Widget tabBuilder;
  IndexedWidgetBuilder pageBuilder;
  Color indicatorColor;
  double indicatorHeight;
  CustomTab(this.pageCount,this.tabBuilder,this.pageBuilder,{this.overlayColor,this.backgroundColor,this.indicatorColor,this.indicatorHeight});
  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {

  PageController controller;
  SwiperController controller2;
  var width=[];
  var colors=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new PageController();
    controller2 = new SwiperController();
    for(int i=0;i<widget.pageCount;i++)
    {
      if(i==0)
      {colors.add(Colors.transparent);
      width.add(10.0);
      }
      else
      {colors.add(widget.overlayColor);
      width.add(200.0);}}
  }

  @override
  Widget build(BuildContext context) {
    print(width.length);
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Column(children: <Widget>[
          new Expanded(
              flex: 1,
              child: Container(
                  child: Center(
                    child: Swiper(
                      controller: controller2,
                      viewportFraction: .4,
                      scale: .01,
                      loop: false,
                      autoplay: false,
                      scrollDirection: Axis.horizontal,
                      onIndexChanged: (i) {
                        setState(() {
                          print("hello");
                          for(int ind=0;ind<widget.pageCount;ind++) {
                            if(i==ind)
                            {width[ind]=10.0;
                            colors[i]=Colors.transparent;}
                            else
                            {width[ind] = 200.0;
                            colors[ind]=widget.overlayColor;
                            }
                          }
                        });
                        controller.animateToPage(i,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.linear);
                      },
                      itemBuilder: (context, i) => new GestureDetector(
                        onTap: () {
                          setState(() {
                            print("hello");
                            for(int ind=0;ind<widget.pageCount;ind++) {
                              if(i==ind)
                              {width[ind]=10.0;
                              colors[i]=Colors.transparent;}
                              else
                              {width[ind] = 200.0;
                              colors[ind]=widget.overlayColor;}
                            }
                          });
                          controller2.move(i, animation: true);
                          controller.animateToPage(i,
                              duration: Duration(milliseconds: 10000),
                              curve: Curves.linear);

                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.08),

                            child: Container(

                                child:Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0 )),
                                  elevation: 5.0,


                                  child:
                                  Stack(
                                      fit: StackFit.expand,
                                      overflow: Overflow.visible,
                                      children:[
                                        widget.tabBuilder,
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 5.0),
                                            height: widget.indicatorHeight,
                                            child: new Center(
                                              child: new AnimatedContainer(
                                                duration: Duration(milliseconds: 300),
                                                margin: EdgeInsets.symmetric(horizontal: width[i]),
                                                color: widget.indicatorColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: colors[i],
                                        )

                                      ]),
                                ))),
                      ),
                      itemCount: widget.pageCount,
                    ),
                  ))),
          Expanded(
              flex: 2,
              child: PageView.builder(
                  itemCount: widget.pageCount,
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  onPageChanged: (i) {
                    setState(() {
                      print("hello");
                      for(int ind=0;ind<widget.pageCount;ind++) {
                        if(i==ind)
                        {width[ind]=10.0;
                        colors[i]=Colors.transparent;}
                        else
                        {width[ind] = 200.0;
                        colors[ind]=widget.overlayColor;}
                      }
                    });
                    controller2.move(i, animation: true);
                  },
                  itemBuilder: widget.pageBuilder))]));
  }
}
