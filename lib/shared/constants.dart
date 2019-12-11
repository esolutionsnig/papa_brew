import 'package:papabrew/shared/color.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: cgrey,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: cgrey, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: cprimary, width: 2.0),
  ),
);
