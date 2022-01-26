abstract class Failure {}

class CrawlerFailure extends Failure {
  final String status;
  final String message;
  CrawlerFailure({
    required this.status,
    required this.message,
  });
}
