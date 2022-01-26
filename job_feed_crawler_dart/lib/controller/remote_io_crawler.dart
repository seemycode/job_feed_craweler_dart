import 'package:dartz/dartz.dart';
import 'package:job_feed_crawler_dart/core/failure.dart';
import 'package:job_feed_crawler_dart/model/remote_io.dart';
import 'package:puppeteer/puppeteer.dart';

abstract class CrawlerStrategy<T> {
  Future<T> call({required String siteUrl});
}

class RemoteIOStrategy
    implements CrawlerStrategy<Either<CrawlerFailure, RemoteIOModel>> {
  late Browser browser;
  late Page page;

  @override
  Future<Either<CrawlerFailure, RemoteIOModel>> call(
      {required String siteUrl}) async {
    browser = await puppeteer.launch();
    page = await browser.newPage();

    try {
      await page.goto(siteUrl, wait: Until.networkIdle);

      var futures = <Future<RemoteIOModel>>[];
      futures.add(noMatches(page));
      futures.add(existMatches(page));
      var result = await Future.any(futures);

      await browser.close();
      return Right(result);
    } catch (e) {
      return Left(CrawlerFailure(status: 'error', message: e.toString()));
    }
  }

  //TODO migrate to model layer
  Future<RemoteIOModel> noMatches(Page page) async {
    try {
      await page.waitForXPath('//*[text()="No results found!"]',
          timeout: Duration(seconds: 10));
    } on TargetClosedException {
      //// That happens when the first is picked > browser is closed right next.
    } catch (e) {
      print('error at noMatches: ${e.toString()}');
    }
    return RemoteIOModel.empty();
  }

  //TODO migrate to model layer
  Future<RemoteIOModel> existMatches(Page page) async {
    var result = RemoteIOModel.empty();
    try {
      var matches = await page
          .$x("//div[contains(@class,'flex-grow') and a[contains(@class,'font-600 leading-none')]]")
          .timeout(Duration(seconds: 15));

      for (var e in matches) {
        //TODO extract information to model
        var html = await e.propertyValue('innerHTML');
        result.data.add(
          RemoteIOModelItem(
              siteUrl: 'siteUrl',
              siteName: 'siteName',
              siteIcon: 'siteIcon',
              roleTitle: 'roleTitle',
              roleDescription: html),
        );
      }
    } catch (e) {
      print('error at existMatches ${e.toString()}');
      //TODO implement
    }
    return Future.value(result);
  }
}
