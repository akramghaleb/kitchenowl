import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kitchenowl/services/api/api_service.dart';

String buildUrl(String url) {
  if (_urlIsLocal(url)) {
    return '${ApiService.getInstance().baseUrl}/upload/$url';
  }

  return url;
}

bool _urlIsLocal(String url) => !url.contains('/');

ImageProvider<Object> getImageProvider(
  BuildContext context,
  String image,
) {
  if (kIsWeb) {
    return NetworkImage(
      buildUrl(image),
      headers: _urlIsLocal(image) ? ApiService.getInstance().headers : null,
    );
  }

  return CachedNetworkImageProvider(
    buildUrl(image),
    headers: _urlIsLocal(image) ? ApiService.getInstance().headers : null,
  );
}
