import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double letterSpacing;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500, 
          color: Theme.of(context).colorScheme.onBackground,
        );

    final finalStyle = defaultStyle?.merge(style);

    return Text(
      text,
      style: finalStyle?.copyWith(letterSpacing: letterSpacing),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
