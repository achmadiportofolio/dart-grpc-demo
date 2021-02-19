import 'package:grpc/grpc.dart';
import 'package:portofolio_grpc_dart/portofolio_grpc_dart.dart' ;

void main(args) async {
  final channel = ClientChannel(
    'localhost',
    port: 5001,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure())

  );
  final stub = AlbumServiceClient(channel);
  // var response =  await stub.getAlbums(AlbumRequest());
  // print('client response \n ${response}');
  // print('client response writeToJson\n ${response.writeToJson()}');
  //  response =  await stub.getAlbums(AlbumRequest()..id=1);
  // print('client response writeToJsonMap \n ${response.writeToJsonMap()}');
  var response =  await stub.getAlbumWithPhotos(AlbumRequest());
  print('client response getAlbumWithPhotos \n ${response}');
  print('client response getAlbumWithPhotos \n ${response.writeToJson()}');
  print('client response getAlbumWithPhotos \n ${response.writeToJsonMap()}');
  await channel.shutdown();
}