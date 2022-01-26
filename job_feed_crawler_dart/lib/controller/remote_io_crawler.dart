import 'dart:convert';

import 'package:job_feed_crawler_dart/model/remote_io.dart';
import 'package:puppeteer/puppeteer.dart';

abstract class CrawlerStrategy<T> {
  Future<T> call({required String siteUrl});
}

class RemoteIOStrategy implements CrawlerStrategy<List<RemoteIOModel>> {
  final empty = Future.value([RemoteIOModel.empty()]);

  @override
  Future<List<RemoteIOModel>> call({required String siteUrl}) async {
    var browser = await puppeteer.launch();
    var page = await browser.newPage();
    Future<List<RemoteIOModel>> result;

    try {
      await page.goto(siteUrl, wait: Until.networkIdle);

      var futures;
      futures.add(noMatches(page));
      futures.add(existMatches(page));
      result = await Future.any(futures);
    } catch (e) {
      return empty;
    } finally {
      await browser.close();
    }
    return Future.value(result);
  }

  Future<List<RemoteIOModel>> noMatches(Page page) async {
    try {
      await page.waitForXPath('//*[text()="No results found!"]',
          timeout: Duration(seconds: 10));
    } catch (e) {
      return empty;
    }
    return empty;
  }

  Future<List<RemoteIOModel>> existMatches(Page page) async {
    var result = <RemoteIOModel>[];
    try {
      var matches = await page
          .$x("//div[contains(@class,'flex-grow') and a[contains(@class,'font-600 leading-none')]]")
          .timeout(Duration(seconds: 10));

      for (var e in matches) {
        //TODO extract information to model
        var html = await e.propertyValue('innerHTML');
        result.add(RemoteIOModel(
            siteUrl: 'siteUrl',
            siteName: 'siteName',
            siteIcon: 'siteIcon',
            roleTitle: 'roleTitle',
            roleDescription: html));
      }
    } catch (e) {
      return empty;
    }
    return Future.value(result);
  }
}
