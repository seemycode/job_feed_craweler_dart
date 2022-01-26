///
/// Example: https://www.remote.io/remote-jobs-to-work-from-home?s=flutter,remote
///
import 'package:job_feed_crawler_dart/controller/remote_io_crawler.dart';
import 'package:test/test.dart';

void main() {
  // TODO: Create tests for RemoteIOController
  late CrawlerStrategy strategy;

  setUp(() {
    strategy = RemoteIOStrategy();
  });

  test(
    "Should return empty object when no match is afound",
    () async {
      final siteUrl =
          'file:///work/Code/job_feed_craweler_dart/job_feed_crawler_dart/lib/fixtures/remote_io_empty.html';
      final crawler = await strategy(siteUrl: siteUrl);

      expect(crawler, {});
    },
  );

  test(
    "Should return RemoteIO when at least one match found",
    () async {
      final siteUrl =
          'file:///work/Code/job_feed_craweler_dart/job_feed_crawler_dart/lib/fixtures/remote_io_results.html';
      final crawler = await strategy(siteUrl: siteUrl);

      assert(crawler != {});
      print(crawler);
    },
  );

  test(
    "Should return {} when an exception happens",
    () async {
      final siteUrl = 'file:///invalid.html';
      final crawler = await strategy(siteUrl: siteUrl);

      expect(crawler, {});
    },
  );
}
