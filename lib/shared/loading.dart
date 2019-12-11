import 'package:papabrew/shared/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: clitegrey,
      child: Center(
        child: SpinKitCubeGrid(
          color: cprimary,
          size: 100.0,
        ),
      ),
    );
  }
}