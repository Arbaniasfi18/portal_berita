import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textTitle = GoogleFonts.bitter(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

TextStyle textTitleDetailPage = GoogleFonts.bitter(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

TextStyle textSplash = GoogleFonts.bitter(
  fontSize: 30,
  fontWeight: FontWeight.w600,
  color: Colors.grey[700],
);

TextStyle textNotif({double? fontSize = 14, FontWeight fontWeight = FontWeight.normal}) => GoogleFonts.bitter(
  fontSize: fontSize,
  fontWeight: fontWeight,
);

TextStyle textCardTitle = GoogleFonts.bitter(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

TextStyle textCardCategory = GoogleFonts.bitter(
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.grey[700],
);