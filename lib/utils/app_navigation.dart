import 'package:flutter/material.dart';

Route<dynamic> createRoute({
  required Widget widget,
  String animationStyle = 'slideFromRight',
  int transitionDuration = 900,
}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: transitionDuration),
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (animationStyle) {
        case 'fade':
          return FadeTransition(opacity: animation, child: child);

        case 'slideFromLeft':
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(-1.0, 0.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.ease)),
            ),
            child: child,
          );

        case 'slideFromRight':
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.ease)),
            ),
            child: child,
          );

        case 'slideFromTop':
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(0.0, -1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.ease)),
            ),
            child: child,
          );

        case 'scaleBounce': // New creative effect
          return ScaleTransition(
            scale: animation.drive(
              Tween<double>(
                begin: 0.5,
                end: 1.0,
              ).chain(CurveTween(curve: Curves.elasticOut)),
            ),
            child: child,
          );

        case 'rotateFade': // Rotates slightly while fading
          return RotationTransition(
            turns: animation.drive(Tween(begin: 0.1, end: 0.0)),
            child: FadeTransition(opacity: animation, child: child),
          );

        case 'chatBubble': // Like chat bubble popping
          return ScaleTransition(
            scale: animation.drive(
              Tween<double>(
                begin: 0.2,
                end: 1.0,
              ).chain(CurveTween(curve: Curves.easeOutBack)),
            ),
            child: FadeTransition(opacity: animation, child: child),
          );

        case 'slideFade': // Slide + Fade for smooth feel
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: FadeTransition(opacity: animation, child: child),
          );

        case 'slideFromBottom':
        default:
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOutBack)),
            ),
            child: child,
          );
      }
    },
  );
}
