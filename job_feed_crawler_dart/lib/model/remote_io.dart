//TODO create remote.io entity here based on crawled data
/// Links
/// http://localhost:4040/
/// https://github.com/xvrh/puppeteer-dart/blob/master/doc/api.md#elementhandlestring-selector
/// http://xpather.com/
import 'dart:convert';

class RemoteIOModel {
  final String siteUrl;
  final String siteName;
  final String siteIcon;
  final String roleTitle;
  final String roleDescription;

  RemoteIOModel.empty()
      : siteUrl = '',
        siteName = '',
        siteIcon = '',
        roleTitle = '',
        roleDescription = '';

  RemoteIOModel({
    required this.siteUrl,
    required this.siteName,
    required this.siteIcon,
    required this.roleTitle,
    required this.roleDescription,
  });

  RemoteIOModel copyWith({
    String? siteUrl,
    String? siteName,
    String? siteIcon,
    String? roleTitle,
    String? roleDescription,
  }) {
    return RemoteIOModel(
      siteUrl: siteUrl ?? this.siteUrl,
      siteName: siteName ?? this.siteName,
      siteIcon: siteIcon ?? this.siteIcon,
      roleTitle: roleTitle ?? this.roleTitle,
      roleDescription: roleDescription ?? this.roleDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'siteUrl': siteUrl,
      'siteName': siteName,
      'siteIcon': siteIcon,
      'roleTitle': roleTitle,
      'roleDescription': roleDescription,
    };
  }

  factory RemoteIOModel.fromMap(Map<String, dynamic> map) {
    return RemoteIOModel(
      siteUrl: map['siteUrl'] ?? '',
      siteName: map['siteName'] ?? '',
      siteIcon: map['siteIcon'] ?? '',
      roleTitle: map['roleTitle'] ?? '',
      roleDescription: map['roleDescription'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteIOModel.fromJson(String source) =>
      RemoteIOModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RemoteIOModel(siteUrl: $siteUrl, siteName: $siteName, siteIcon: $siteIcon, roleTitle: $roleTitle, roleDescription: $roleDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RemoteIOModel &&
        other.siteUrl == siteUrl &&
        other.siteName == siteName &&
        other.siteIcon == siteIcon &&
        other.roleTitle == roleTitle &&
        other.roleDescription == roleDescription;
  }

  @override
  int get hashCode {
    return siteUrl.hashCode ^
        siteName.hashCode ^
        siteIcon.hashCode ^
        roleTitle.hashCode ^
        roleDescription.hashCode;
  }
}
