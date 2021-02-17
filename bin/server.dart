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
    // TODO: implement getAlbums
    // throw UnimplementedError();
    // print('getalbums ${albums}');
    final albumList = albums.map((album) {
      // print('${album['title']}');
      // print(Album.fromJson('{"1": ${album['id']} , "2": ${album['title']} }'));
       return Album.fromJson('{"1": ${album['id']} , "2": "${album['title']}" }');
       }).toList();
       print('albumList ${albumList}');
    return AlbumResponse()..albums.addAll(albumList);
  }
  
}

void main() async {
  final server = Server([AlbumService()]);
  await server.serve(port:5001);
  print('server grpc running on port ${server.port}');
}