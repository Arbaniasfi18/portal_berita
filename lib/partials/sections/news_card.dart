import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portal_berita_wawan/partials/style/color.dart';
import 'package:portal_berita_wawan/partials/style/text.dart';

Widget newsCard (BuildContext context, {required String title, required String image, required String island}) => 
Container(
  width: MediaQuery.of(context).size.width,
  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * .96)),
  child: PhysicalModel(
    color: Colors.black,
    borderRadius: BorderRadius.circular(10),
    elevation: 5,
    child: Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: primaryPink)),
                errorWidget: (context, url, error) => const Icon(Icons.warning, color: Colors.red),
                fit: BoxFit.fitHeight,
                imageUrl: image
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40,),
                  Text(island, style: textCardCategory,),
                  const SizedBox(height: 10,),
                  Text(title, style: textCardTitle, maxLines: 3, overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  )
);