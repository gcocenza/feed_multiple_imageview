import 'package:flutter/material.dart';
import 'package:feed_multimedia_gridview/src/smart_image.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class MultipleImageView extends StatelessWidget {
  final List<String> imageUrls;
  final List<String>? videoUrls;
  final Radius? topLeft;
  final Radius? topRight;
  final Radius? bottomLeft;
  final Radius? bottomRight;
  final BorderRadius? borderRadius;

  const MultipleImageView({
    Key? key,
    required this.imageUrls,
    this.videoUrls,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _contentRender(context),
    );
  }

  List<Widget> _contentRender(BuildContext context) {
    final media = _buildMedia();
    switch (media.length) {
      case 0:
        return const [SizedBox.shrink()];
      case 1:
        return _singleMediaView(context, media);
      case 2:
        return _twoMediaView(context, media);
      case 3:
        return _threeMediaView(context, media);
      case 4:
        return _fourMediaView(context, media);
      default:
        return _multipleMediaView(context, media);
    }
  }

  List<_MediaItem> _buildMedia() {
    final list = <_MediaItem>[];
    if (videoUrls != null && videoUrls!.isNotEmpty) {
      list.addAll(videoUrls!.map((e) => _MediaItem(_MediaType.video, e)));
    }
    list.addAll(imageUrls.map((e) => _MediaItem(_MediaType.image, e)));
    return list;
  }

  List<Widget> _singleMediaView(BuildContext context, List<_MediaItem> media) {
    return [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: _mediaTile(context, media[0]),
        ),
      ),
    ];
  }

  List<Widget> _twoMediaView(BuildContext context, List<_MediaItem> media) {
    return [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: topLeft ?? const Radius.circular(20),
            bottomLeft: bottomLeft ?? const Radius.circular(20),
          ),
          child: _mediaTile(context, media[0]),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: topRight ?? const Radius.circular(20),
            bottomRight: bottomRight ?? const Radius.circular(20),
          ),
          child: _mediaTile(context, media[1]),
        ),
      ),
    ];
  }

  List<Widget> _threeMediaView(BuildContext context, List<_MediaItem> media) {
    return [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: topLeft ?? const Radius.circular(20),
            bottomLeft: bottomLeft ?? const Radius.circular(20),
          ),
          child: _mediaTile(context, media[0]),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: topRight ?? const Radius.circular(20),
                ),
                child: _mediaTile(context, media[1]),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: bottomRight ?? const Radius.circular(20),
                ),
                child: _mediaTile(context, media[2]),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _fourMediaView(BuildContext context, List<_MediaItem> media) {
    return [
      Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: topLeft ?? const Radius.circular(20),
            bottomLeft: bottomLeft ?? const Radius.circular(20),
          ),
          child: _mediaTile(context, media[0]),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: topRight ?? const Radius.circular(20),
                ),
                child: _mediaTile(context, media[1]),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(child: _mediaTile(context, media[2])),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: bottomRight ?? const Radius.circular(20),
                ),
                child: _mediaTile(context, media[3]),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _multipleMediaView(
    BuildContext context,
    List<_MediaItem> media,
  ) {
    return [
      Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: topLeft ?? const Radius.circular(20),
            bottomLeft: bottomLeft ?? const Radius.circular(20),
          ),
          child: _mediaTile(context, media[0]),
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: topRight ?? const Radius.circular(20),
                ),
                child: _mediaTile(context, media[1]),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: ClipRRect(child: _mediaTile(context, media[2])),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: bottomRight ?? const Radius.circular(20),
                    ),
                    child: _mediaTile(context, media[3]),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(127),
                        borderRadius: BorderRadius.only(
                          bottomRight: bottomRight ?? const Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        '+${_buildMedia().length - 4}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "Nulito",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _mediaTile(BuildContext context, _MediaItem item) {
    final isVideo = item.type == _MediaType.video;
    final child = Stack(
      fit: StackFit.expand,
      children: [
        if (isVideo)
          _VideoThumb(url: item.url)
        else
          SmartImage(item.url, fit: BoxFit.cover, isPost: true),
        if (isVideo) const _PlayOverlay(),
      ],
    );

    if (!isVideo) return child;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _VideoPlayerScreen(videoUrl: item.url),
          ),
        );
      },
      child: child,
    );
  }
}

enum _MediaType { video, image }

class _MediaItem {
  final _MediaType type;
  final String url;
  const _MediaItem(this.type, this.url);
}

class _PlayOverlay extends StatelessWidget {
  const _PlayOverlay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.play_circle_fill, color: Colors.white, size: 56),
    );
  }
}

class _VideoThumb extends StatefulWidget {
  final String url;
  const _VideoThumb({Key? key, required this.url}) : super(key: key);
  @override
  State<_VideoThumb> createState() => _VideoThumbState();
}

class _VideoThumbState extends State<_VideoThumb> {
  late final CachedVideoPlayerController _controller;
  bool _inited = false;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        if (mounted) setState(() => _inited = true);
      });
    _controller.setVolume(0);
    _controller.pause();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_inited) return const ColoredBox(color: Colors.black12);
    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: _controller.value.size.width,
        height: _controller.value.size.height,
        child: CachedVideoPlayer(_controller),
      ),
    );
  }
}

class _VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const _VideoPlayerScreen({Key? key, required this.videoUrl})
    : super(key: key);
  @override
  State<_VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<_VideoPlayerScreen> {
  late CachedVideoPlayerController _videoController;
  late CustomVideoPlayerController _customController;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _videoController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _customController = CustomVideoPlayerController(
          context: context,
          videoPlayerController: _videoController,
          customVideoPlayerSettings: const CustomVideoPlayerSettings(
            showPlayButton: true,
            showSeekButtons: true,
          ),
        );
        if (mounted) setState(() => _ready = true);
      });
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ),
            Expanded(
              child:
                  _ready
                      ? CustomVideoPlayer(
                        customVideoPlayerController: _customController,
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
