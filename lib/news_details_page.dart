import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portal_berita_wawan/partials/style/color.dart';
import 'package:portal_berita_wawan/partials/style/text.dart';

class NewsDetail extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  const NewsDetail({super.key, required this.image, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryPink,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 25)
        ),
        title: Text("Berita", style: textTitle,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Text(title, style: textTitleDetailPage, textAlign: TextAlign.center,),
                const SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(color: primaryPink)),
                      errorWidget: (context, url, error) => const Icon(Icons.warning, color: Colors.red),
                      fit: BoxFit.fitWidth,
                      imageUrl: image
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * .9) - 20),
                  child: Text(content, textAlign: TextAlign.justify,),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}