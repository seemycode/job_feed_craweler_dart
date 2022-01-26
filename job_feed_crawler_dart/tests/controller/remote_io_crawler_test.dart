///
/// Example: https://www.remote.io/remote-jobs-to-work-from-home?s=flutter,remote
///
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:job_feed_crawler_dart/controller/remote_io_crawler.dart';
import 'package:job_feed_crawler_dart/core/failure.dart';
import 'package:job_feed_crawler_dart/model/remote_io.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  // TODO: Create tests for RemoteIOController
  late CrawlerStrategy crawler;

  setUp(() {
    crawler = RemoteIOStrategy();
    // defaultReturnValue = [RemoteIOModel.empty()];
  });

  test(
    "Should return failure when no match found",
    () async {
      final siteUrl =
          'file:///work/Code/job_feed_craweler_dart/job_feed_crawler_dart/lib/fixtures/remote_io_empty.html';
      final result = await crawler(siteUrl: siteUrl);
      final model = result.toOption().toNullable()!;

      assert(result.isRight());
      expect(model.data.isEmpty, true);
    },
  );

  test(
    "Should return model when at least one match found",
    () async {
      final siteUrl =
          'file:///work/Code/job_feed_craweler_dart/job_feed_crawler_dart/lib/fixtures/remote_io_results.html';
      final result = await crawler(siteUrl: siteUrl);
      final RemoteIOModel model = result.toOption().toNullable()!;

      assert(result.isRight());
      expect(model.data.isEmpty, false);

      // print(model.data.first.roleDescription);
    },
  );

  // test(
  //   "Should return {} when an exception happens",
  //   () async {
  //     final siteUrl = 'file:///invalid.html';
  //     final crawler = await strategy(siteUrl: siteUrl);

  //     expect(crawler, defaultReturnValue);
  //   },
  // );
}
