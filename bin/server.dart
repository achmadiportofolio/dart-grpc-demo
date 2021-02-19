import 'dart:ffi';

import 'package:grpc/grpc.dart';
// import 'package:portofolio_grpc_dart/portofolio_grpc_dart.dart' as portofolio_grpc_dart;
import 'package:portofolio_grpc_dart/portofolio_grpc_dart.dart' ;
// import 'package:portofolio_grpc_dart/src/generated/lib/src/proto/album.pb.dart';

// void main(List<String> arguments) {
//   // print('Hello world: ${portofolio_grpc_dart.calculate()}!');
//   final album = Album()..id=2..title="album 1";
//   print(album);
//   final album2 = Album.fromJson('{"1":"${albums[3]['id']}" , "2":"${albums[3]['title']}" }');
//   print(album2);
//   print(album2.clone());
//   print(album2.copyWith((album) {
//     album.setField(2, "update field 1");
//   }));
// }

class AlbumService extends AlbumServiceBase{
  @override
  Future<AlbumResponse> getAlbums(ServiceCall call, AlbumRequest request) async{
    if (request.id>0) {
      return AlbumResponse()..albums.addAll(findAlbums(request.id));
    }
    // TODO: implement getAlbums
    // throw UnimplementedError();
    // print('getalbums ${albums}');
    final albumList = albums.map((album) {
      // print('${album['title']}');
      // print(Album.fromJson('{"1": ${album['id']} , "2": ${album['title']} }'));
      return convertToAlbum(album);
       
       }).toList();
       print('albumList ${albumList}');
    return AlbumResponse()..albums.addAll(albumList);
  }

  List<Album> findAlbums(int id) {
    return albums.where((element) => element['id']==id)
      .map((e) => convertToAlbum(e)).toList();
      
  }
  Album convertToAlbum(Map album) {
    return Album.fromJson('{"1": ${album['id']} , "2": "${album['title']}" }');
  }

  @override
  Future<AlbumResponse> getAlbumWithPhotos(ServiceCall call, AlbumRequest request) async{
    // TODO: implement getAlbumWithPhotos
    // throw UnimplementedError();
    // print('ruun getAlbumWithPhotos \n');
     if (request.id>0) {
      return AlbumResponse()..albums.addAll(albums.where((alb) => alb['id']==request.id).map((json){
          final album = convertToAlbum(json);
          final photos = findPhotos(json);
          return album..photos.addAll(photos);
      }));
    }
    return AlbumResponse()..albums.addAll(albums.map((json){
      // print(' $json');
        final album = convertToAlbum(json);
        // print('album $album');
        final photos = findPhotos(json);
        // print('photos $photos');
        return album..photos.addAll(photos);
    }));
  }

  List<Photo> findPhotos(Map album) {
    return photos.where((json) => json['albumId']==album['id']).map((e) => convertToPhoto(e)).toList();
  }
  Photo convertToPhoto(Map jsonPhoto) {
    // 'albumId': 1,
    // 'id': 27,
    // 'title': 'sit asperiores est quos quis nisi veniam erras',
    // 'url': '
    // print('jsonPhoto $jsonPhoto');
    return Photo.fromJson('{ "1": ${jsonPhoto['albumId']}, "2": ${jsonPhoto['id']}, "3": "${jsonPhoto['title']}", "4": "${jsonPhoto['url']}" }');
  }

  @override
  Stream<Photo> getPhotos(Object call, AlbumRequest request) async* {
    var photoList = photos;
    if (request.id>0) {
      photoList = photos.where((element) => element['albumId']==request.id).toList();
      
    }
    for (final photo in photoList) {
      yield Photo.fromJson('''{
         "1": ${photo['albumId']}, 
         "2": ${photo['id']}, 
         "3": "${photo['title']}", 
         "4": "${photo['url']}"
          }
      ''');
    }
  }
  
}

void main() async {
  final server = Server([AlbumService()]);
  await server.serve(port:5001);
  print('server grpc running on port ${server.port}');
}