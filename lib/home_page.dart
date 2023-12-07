import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:portal_berita_wawan/add_news_page.dart';
import 'package:portal_berita_wawan/news_details_page.dart';
import 'package:portal_berita_wawan/partials/dialog/info_dialog.dart';
import 'package:portal_berita_wawan/partials/sections/news_card.dart';
import 'package:portal_berita_wawan/partials/style/color.dart';
import 'package:portal_berita_wawan/partials/style/text.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  final List<dynamic> newsData;
  const HomePage({super.key, required this.newsData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Box? box;

  String? pulau;

  bool loading = true;
  bool hive = false;
  List<dynamic> newsData = [];
  List<dynamic> actualNews = [];

  Future<void> getDataBerita(BuildContext context) async {

    String baseLink = "https://komikscolar.id/scolar/api";

    try {
      
      http.Response response = await http.get(Uri.parse("$baseLink/artikel-orangtua"));

      if (response.statusCode == 200) {

        Map<String, dynamic> body = jsonDecode(response.body);

        List<dynamic> data = body['data'];

        int a = 0;

        data.forEach((element) {
          Map<String, dynamic> temp = {
            'id': element['id'],
            'title': element['title'],
            'island': a > 1 ? "Sumatera" : "Jawa",
            'image': element['image'],
            'content': element['content'],
          };
          newsData.add(temp);

          a+=1;

        });

        actualNews = newsData;

        box!.put('newsData', newsData);

        setState(() {
          loading = false;
        });

      }
      else {

        if (context.mounted) {
          errNotif(context, message: "Gagal mengambil data");
        }

      }
      
    } catch (e) {
      
      if (context.mounted) {
        errNotif(context, message: e.toString());
      }

    }

  }

  Future<void> openBox() async {
    box = await Hive.openBox("berita");


    if (box?.get("newsData") != null) {
      
      if (box?.get("newsData").length > 0) {

        setState(() {
          hive = true;
        });

      }

        
      if (widget.newsData.isNotEmpty) {
        box?.delete("newsData");

        newsData = widget.newsData;

        actualNews = newsData;

        box?.put("newsData", newsData);

        setState(() {
          loading = false;
        });

      }else {
        
        if (hive) {

          newsData = box?.get("newsData");

          actualNews = newsData;

          setState(() {
            loading = false;
          });

        }else{
          
          if (context.mounted) {
            getDataBerita(context);
          }

        }
      }
    
    }else{

      if (context.mounted) {
        getDataBerita(context);
      }

    }

  }


  @override
  void initState() {
    // TODO: implement initState
    
    
    openBox();

        // getDataBerita(context);


    super.initState();

  }
  


  @override
  Widget build(BuildContext context) {
    return loading 
    ? Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.newspaper_rounded, color: primaryPink, size: 100),
            const SizedBox(height: 10,),
            Text("Portal Berita", style: textSplash,),
          ],
        ),
      ),
    )
    : Scaffold(
      appBar: AppBar(
        backgroundColor: primaryPink,
        title: Text("Portal Berita", style: textTitle,),
        actions: [
          IconButton(
            onPressed: () => infoDialog(context), 
            icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    Text("Daerah : ", style: textTitleDetailPage),
                    const SizedBox(width: 10,),
                    DropdownButton(
                      hint: const Text("Semua"),
                      value: pulau,
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
                          pulau = value;
                        });

                        actualNews = [];

                        if (pulau == "Semua") {
                          actualNews = newsData;
                          return; 
                        }

                        newsData.forEach((element) {
                          if (element['island'] == pulau) {
                            Map<String, dynamic> temp = {
                              'id': element['id'],
                              'title': element['title'],
                              'island': element['island'],
                              'image': element['image'],
                              'content': element['content'],
                            };
                            actualNews.add(temp);
                          }
                        });
                        
                      },
                    ),
                  ],
                )
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: actualNews.length,
                    itemBuilder: (context, index) =>
                      Column(
                        children: [
                          const SizedBox(height: 10,),
                          Slidable(
                            startActionPane: ActionPane(
                              motion: const DrawerMotion(), 
                              children: [
                                SlidableAction(
                                  onPressed: (context) => Navigator.push(context, CupertinoPageRoute(builder: (context) => AddNews(newsData: newsData, index: actualNews[index]['id'] - 1, title: actualNews[index]['title'], island: actualNews[index]['island'], image: actualNews[index]['image'], content: actualNews[index]['content'],))),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.yellow[700]!,
                                  label: "Ubah",
                                  icon: Icons.edit,
                                )
                              ]
                            ),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(), 
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      box?.delete("newsData");
                                      newsData.removeAt(actualNews[index]['id'] - 1);
                                      actualNews.removeAt(index);
                                      box?.put("newsData", newsData);
                                    });
                                  },
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red[700]!,
                                  label: "Hapus",
                                  icon: Icons.delete,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    laporkanDialog(context);
                                  },
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.grey[700]!,
                                  label: "Laporkan",
                                  icon: Icons.warning_amber,
                                )
                              ]
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => NewsDetail(image: actualNews[index]['image'], title: actualNews[index]['title'], content: actualNews[index]['content']))),
                              child: newsCard(context, title: actualNews[index]['title'], image: actualNews[index]['image'], island: actualNews[index]['island'].toString())
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ) 
                  ),
                ),
              ),
            ],
          ),
          // child: newsCard(context, title: newsData[0]['title'], image: newsData[0]['image'])
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => AddNews(newsData: newsData))),
        backgroundColor: primaryPink,
        tooltip: "Tambah berita",
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}