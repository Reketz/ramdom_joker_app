import 'package:flutter/cupertino.dart';

class RouterSimple extends PageRouteBuilder{
  final Widget widget;

  RouterSimple({this.widget})
    : super(
      pageBuilder: (BuildContext c, Animation<double> animation, Animation<double> secund){
        return widget;
      },
      transitionsBuilder: (BuildContext c, Animation<double> animation, Animation<double> secund, Widget widget){
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero
          ).animate(animation),
          child: widget,
        );
      },
    );
}