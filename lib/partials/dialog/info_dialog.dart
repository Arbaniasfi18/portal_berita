import 'package:flutter/material.dart';
import 'package:portal_berita_wawan/partials/style/color.dart';
import 'package:portal_berita_wawan/partials/style/text.dart';

infoDialog(BuildContext context) => 
showDialog(
  context: context, 
  builder: (context) => 
    AlertDialog(
      title: Icon(Icons.info_outline_rounded, color: primaryPink, size: 40),
      content: Text("Ini adalah portal berita yang lebih mengarah ke edukasi perundungan\n- Geser kekanan untuk edit berita\n- Geser kekiri untuk menghapus dan melaporkan berita", textAlign: TextAlign.center, style: textNotif(),),
    )
);

errNotif(BuildContext context, {required String message}) => 
showDialog(
  context: context, 
  builder: (context) => 
    AlertDialog(
      title: const Icon(Icons.cancel_outlined, color: Colors.red, size: 40),
      content: Text(message, textAlign: TextAlign.center, style: textNotif(),),
    )
);

terimakasihDialog(BuildContext context) => 
showDialog(
  context: context, 
  barrierDismissible: false,
  builder: (context) => 
    AlertDialog(
      title: Icon(Icons.check, color: Colors.green[700], size: 40),
      content: Text("Terimakasih telah malaporkan berita ini\n\nNb: Berita tidak akan langsung hilang, tetapi akan direview oleh admin terlebih dahulu", textAlign: TextAlign.center, style: textNotif(),),
    )
);

laporkanDialog(BuildContext context) => 
showDialog(
  context: context, 
  builder: (context) => 
    AlertDialog(
      title: Icon(Icons.warning, color: Colors.red[700], size: 40),
      content: Text("Apakah anda ingin melaporkan berita ini ?", textAlign: TextAlign.center, style: textNotif(),),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), 
          child: const Text("Tidak", style: TextStyle(
            color: Colors.black
          ),)
        ),
        TextButton(onPressed: () async {
          terimakasihDialog(context);

          await Future.delayed(const Duration(seconds: 5));

          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }, 
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red[700])
          ),
          child: const Text("Ya", style: TextStyle(
            color: Colors.white
          ),)
        )
      ],
    )
);

kosongDialog(BuildContext context) => 
showDialog(
  context: context, 
  builder: (context) => 
    AlertDialog(
      title: Icon(Icons.info_outline_rounded, color: primaryPink, size: 40),
      content: Text("Anda belum melengkapi data berita", textAlign: TextAlign.center, style: textNotif(),),
    )
);

successDialog(BuildContext context, {required String message}) => 
showDialog(
  context: context, 
  barrierDismissible: false,
  builder: (context) => 
    AlertDialog(
      title: Icon(Icons.check, color: Colors.green[700], size: 40),
      content: Text(message, textAlign: TextAlign.center, style: textNotif(),),
    )
);