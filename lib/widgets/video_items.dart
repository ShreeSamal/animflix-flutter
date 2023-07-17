// import 'package:flutter/material.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:video_player/video_player.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:chewie/chewie.dart';

// class VideoItems extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
//   final bool looping;
//   final bool autoplay;

//   const VideoItems({
//     required this.videoPlayerController,
//     required this.looping,
//     required this.autoplay,
//     super.key,
//   });

//   @override
//   State<VideoItems> createState() => _VideoItemsState();
// }

// class _VideoItemsState extends State<VideoItems> {
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     try {
//       _chewieController = ChewieController(
//         videoPlayerController: widget.videoPlayerController,
//         autoInitialize: true,
//         autoPlay: widget.autoplay,
//         looping: widget.looping,
//         errorBuilder: (context, errorMessage) {
//           return Center(
//             child: Text(
//               errorMessage,
//               style: const TextStyle(color: Colors.white),
//             ),
//           );
//         },
//       );
//     } catch (e) {}
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _chewieController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Chewie(
//         controller: _chewieController,
//       ),
//     );
//   }
// }
