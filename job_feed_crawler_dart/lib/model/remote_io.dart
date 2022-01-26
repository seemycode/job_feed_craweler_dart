//TODO create remote.io entity here based on crawled data
/// Links
/// http://localhost:4040/
/// https://github.com/xvrh/puppeteer-dart/blob/master/doc/api.md#elementhandlestring-selector
/// http://xpather.com/
import 'dart:convert';

class RemoteIOModel {
  final List<RemoteIOModelItem> data;

  RemoteIOModel(this.data);

  RemoteIOModel.empty() : data = [];

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory RemoteIOModel.fromMap(Map<String, dynamic> map) {
    return RemoteIOModel(
      List<RemoteIOModelItem>.from(
          map['data']?.map((x) => RemoteIOModelItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteIOModel.fromJson(String source) =>
      RemoteIOModel.fromMap(json.decode(source));
}

class RemoteIOModelItem {
  final String siteUrl;
  final String siteName;
  final String siteIcon;
  final String roleTitle;
  final String roleDescription;

  RemoteIOModelItem({
    required this.siteUrl,
    required this.siteName,
    required this.siteIcon,
    required this.roleTitle,
    required this.roleDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'siteUrl': siteUrl,
      'siteName': siteName,
      'siteIcon': siteIcon,
      'roleTitle': roleTitle,
      'roleDescription': roleDescription,
    };
  }

  factory RemoteIOModelItem.fromMap(Map<String, dynamic> map) {
    return RemoteIOModelItem(
      siteUrl: map['siteUrl'] ?? '',
      siteName: map['siteName'] ?? '',
      siteIcon: map['siteIcon'] ?? '',
      roleTitle: map['roleTitle'] ?? '',
      roleDescription: map['roleDescription'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteIOModelItem.fromJson(String source) =>
      RemoteIOModelItem.fromMap(json.decode(source));
}
