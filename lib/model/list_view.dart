import 'package:flutter/material.dart';
import 'package:sukoruyuculari/API/utils.dart';
import 'package:sukoruyuculari/layout/SizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';
class ImageListView extends StatelessWidget {

  var images;
  getImages() async {
    images = await Utils().getImages();
    return images;
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    getImages();
    return Container(
      width: SizeConfig.screenWidth * 1,
      height:
      MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.5 : SizeConfig.screenHeight * 0.8,
      child:  FutureBuilder(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Category(
                  image_location: images[index]['image_url'],
                  image_title: images[index]['text'],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(216, 56, 48, 1)),
            ),
          );
        },
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_title;
  Category({
    required this.image_location,
    required this.image_title,
  });
  _launchURL() async {
    const url = 'https://okuyolla.com/sukoruyuculari';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          _launchURL();
        },
        child: Container(
          width:  SizeConfig.screenWidth * 1,
          child: ListTile(
            title: Image.network(
              image_location,
              fit: BoxFit.fill,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(image_title, style: new TextStyle(fontSize: 18.0,),textAlign: TextAlign.center,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
