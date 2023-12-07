// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_berita_wawan/home_page.dart';
import 'package:portal_berita_wawan/partials/dialog/info_dialog.dart';
import 'package:portal_berita_wawan/partials/style/color.dart';
import 'package:portal_berita_wawan/partials/style/text.dart';

class AddNews extends StatefulWidget {
  final List<dynamic> newsData;
  final int? index;
  final String? title;
  final String? island;
  final String? image;
  final String? content;

  const AddNews({super.key, 
  required this.newsData,
  this.index,
  this.title, 
  this.island, 
  this.image,
  this.content});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {

  List<dynamic> newsData = [];

  int index = 0;

  TextEditingController judul = TextEditingController();
  TextEditingController gambar = TextEditingController();
  TextEditingController konten = TextEditingController();

  String? title;
  String? image;
  String? content;
  String? island;


  @override
  void initState() {
    // TODO: implement initState

    newsData = widget.newsData;

    if (widget.title != null) {
      judul.text = widget.title!;
    }
    if (widget.image != null) {
      gambar.text = widget.image!;
    }
    if (widget.content != null) {
      konten.text = widget.content!;
    }
    if (widget.island != null) {
      island = widget.island!;
    }
    if (widget.index == null) {
      index = newsData.length + 1;
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryPink,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 25)
        ),
        title: Text(widget.title == null ? "Tambah berita" : "Ubah berita", style: textTitle,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * .95)),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Text("Judul Berita", style: textTitleDetailPage,),
                TextField(
                  controller: judul,
                  decoration: const InputDecoration(
                    hintText: "Paslon no ..... berhasil ...",
                  ),
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                Text("Pulau", style: textTitleDetailPage,),
                DropdownButton(
                  hint: const Text("Semua"),
                  value: island,
                  items: const [
                    DropdownMenuItem(value: "Semua", child: Text("Semua")),
                    DropdownMenuItem(value: "Sumatera", child: Text("Sumatera")),
                    DropdownMenuItem(value: "Jawa", child: Text("Jawa")),
                    DropdownMenuItem(value: "Kalimantan", child: Text("Kalimantan")),
                    DropdownMenuItem(value: "Sulawesi", child: Text("Sulawesi")),
                    DropdownMenuItem(value: "Papua", child: Text("Papua")),
                  ], 
                  onChanged: (value) {
                    setState(() {
                      island = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                Text("Link Gambar", style: textTitleDetailPage,),
                TextField(
                  controller: gambar,
                  decoration: const InputDecoration(
                    hintText: "https://example.com/img.jpg",
                  ),
                  onChanged: (value) {
                    setState(() {
                      image = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                Text("Konten", style: textTitleDetailPage,),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 600
                  ),
                  child: TextField(
                    controller: konten,
                    decoration: const InputDecoration(
                      hintText: "Berdasarkan senin (10/20/1020) ....",
                    ),
                    maxLines: 15,
                    onChanged: (value) {
                      setState(() {
                        content = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () async {

                        if (title != null && image != null && content != null && island != null) {

                          Map<String, dynamic> data = {
                            "id": index,
                            "title": judul.text,
                            "island": island,
                            "image": gambar.text,
                            "content": konten.text,
                          };

                          newsData.add(data);

                          successDialog(context, message: "Berhasil menambahkan berita");

                          await Future.delayed(const Duration(seconds: 3));

                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => HomePage(newsData: newsData)), (route) => false);
                          }

                        }
                        else if(widget.index != null){

                          Map<String, dynamic> data = {
                            "id": widget.index! + 1,
                            "title": judul.text,
                            "island": island,
                            "image": gambar.text,
                            "content": konten.text,
                          };

                          newsData.removeAt(widget.index!);

                          newsData.insert(widget.index!, data);

                          successDialog(context, message: "Berhasil mengubah berita");

                          await Future.delayed(const Duration(seconds: 3));

                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => HomePage(newsData: newsData)), (route) => false);
                          }


                        }else{

                          kosongDialog(context);

                        }


                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPink
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: widget.index != null 
                          ? [
                            const Text("Simpan", style: TextStyle(
                              color: Colors.white,
                            ))
                          ] 
                          : [
                          const Icon(Icons.add, color: Colors.white),
                          const Text("Tambah", style: TextStyle(
                            color: Colors.white,
                          )),
                        ],
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        )
      ),
    );
  }
}