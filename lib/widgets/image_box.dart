import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ImageBox extends StatelessWidget {
  final String image;
  const ImageBox({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Center(child: SvgPicture.asset(image, fit: BoxFit.contain)),
    );
  }
}
