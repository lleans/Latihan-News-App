import 'package:flutter/material.dart';
import 'package:NewsAppLatihanEzyIndustries/model/news_model.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  NewsModel data;
  DetailPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => shareNotice(),
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(6.0),
          child: ListView(
            children: [
              Hero(
                tag: data.title,
                child: _getImageNetwork(data.urlToImage),
              ),
              _getBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageNetwork(url) {
    try {
      if (url != '') {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
          child: Container(
            height: 200.0,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/place_holder.jpg',
              image: url,
              fit: BoxFit.cover,
            ),
          ),
        );
      } else {
        return Container(
          height: 200.0,
          child: Image.asset('assets/place_holder_3.jpg'),
        );
      }
    } catch (e) {
      return Container(
        height: 200.0,
        child: Image.asset('assets/pllace_holder_3.jpg'),
      );
    }
  }

  Widget _getBody(context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitle(data.title),
          _getDate(data.publishedAt, data.author),
          _getDescription(data.desc),
          _getAntLink(),
          _getLink(data.url, context),
        ],
      ),
    );
  }

  Widget _getAntLink() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Text("Mais detalhes acesse:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          )),
    );
  }

  Widget _getLink(link, context) {
    return GestureDetector(
      child: Text(
        link,
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () => _launchURL(link, context),
    );
  }

  _getTitle(title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    );
  }

  _getDate(date, origin) {
    return Container(
      margin: EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
          ),
          Text(
            origin,
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
          )
        ],
      ),
    );
  }

  _getDescription(desc) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(desc),
    );
  }

  _launchURL(url, context) async {
    if (Platform.isAndroid) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    } else {
      Clipboard.setData(ClipboardData(text: url));
      _showDialog(context);
    }
  }

  Future shareNotice() async {
    await Share.share(data.title);
  }

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(content: Text("Link Copied"), actions: [
        FlatButton(
          child: Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ]),
    );
  }
}
