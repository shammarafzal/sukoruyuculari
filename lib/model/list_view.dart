import 'package:flutter/material.dart';
import 'package:sukoruyuculari/API/utils.dart';
import 'package:sukoruyuculari/Models/getImages.dart';
import 'package:sukoruyuculari/layout/SizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';
class ImageListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth * 1,
      height:
      MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.5 : SizeConfig.screenHeight * 0.8,
      child:  FutureBuilder<GetImages>(
        future: Utils().fetchImages(),
        builder: (context,snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.data?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Category(
                  image_location: snapshot.data?.data?[index].imageUrl ?? "",
                  image_title: snapshot.data?.data?[index].text ?? ""
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
