import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:NewsAppLatihanEzyIndustries/model/news_model.dart';
import 'package:NewsAppLatihanEzyIndustries/ui/screen/detail/detail_page.dart';

class ItemNewsWidget extends StatelessWidget {
  NewsModel data;
  BuildContext _context;

  ItemNewsWidget(this.data);

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return new GestureDetector(
      onTap: _handleTapUp(),
      child: new Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        child: new Material(
          borderRadius: new BorderRadius.circular(6.0),
          elevation: 2.0,
          child: _getListTitle(),
        ),
      ),
    );
  }

  Widget _getListTitle() {
    return new Container(
      height: 95.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Hero(
            tag: data.title,
            child: _getImgWidget(data.urlToImage),
          ),
          _getColumnText(data.title, data.publishedAt, data.desc)
        ],
      ),
    );
  }

  _handleTapUp() {
    Navigator.of(_context).push(
      new MaterialPageRoute(
        builder: (context) {
          return DetailPage(data);
        },
      ),
    );
  }

  Widget _getColumnText(title, date, desc) {
    return new Expanded(
      child: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getTitleWidget(title),
            _getDateWidget(date),
            _getDescriptionWidget(desc)
          ],
        ),
      ),
    );
  }

  Widget _getImgWidget(String url) {
    return new Container(
      width: 95.0,
      height: 95.0,
      child: new ClipRRect(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(6.0),
            bottomLeft: const Radius.circular(6.0)),
        child: _getImageNetwork(url),
      ),
    );
  }

  Widget _getImageNetwork(String url) {
    try {
      if (url.isNotEmpty) {
        return new FadeInImage.assetNetwork(
          placeholder: 'assets/place_holder.jpg',
          image: url,
          fit: BoxFit.cover,
        );
      } else {
        return new Image.asset('assets/place_holder.jpg');
      }
    } catch (e) {
      return new Image.asset('assets/place_holder.jpg');
    }
  }

  Widget _getTitleWidget(String currencyName) {
    return Text(
      currencyName,
      maxLines: 1,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getDescriptionWidget(String desc) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Text(
        desc,
        maxLines: 2,
      ),
    );
  }

  Widget _getDateWidget(String date) {
    return Text(
      date,
      style: TextStyle(color: Colors.grey, fontSize: 10.0),
    );
  }
}
