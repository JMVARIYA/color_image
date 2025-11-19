import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/image_controller.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({super.key});

  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GetX<ImageController>(
      initState: (_) => imageController.initStateMethod(),
      builder: (_) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: imageController.isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            appBar: appBarWidget(context, theme),
            bottomNavigationBar: bottomAppBarWidget(context),
            body: bodyWidget(context, theme),
          ),
        );
      },
    );
  }

  PreferredSizeWidget? appBarWidget(BuildContext context, ThemeData theme) {
    return AppBar(
      title: const Text("Image Screen"),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween<double>(begin: 0.6, end: 1).animate(animation),
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: InkWell(
              key: ValueKey(imageController.isDark),
              onTap: imageController.toggleTheme,
              borderRadius: BorderRadius.circular(40),
              child: Icon(
                imageController.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 26,
                color: theme.iconTheme.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget? bottomAppBarWidget(BuildContext context) {
    return BottomAppBar(
      child: ElevatedButton(
        onPressed: imageController.isLoading.value
            ? null
            : imageController.initStateMethod,
        child: const Text("Another"),
      ),
    );
  }

  Widget? bodyWidget(BuildContext context, ThemeData theme) {
    return imageController.isInternetConnect.value == true &&
        imageController.isServerError.value == false
        ? imageController.isLoading.value
        ? skeletonWidget(context, theme)
        : buildImage(context, theme)
        : errorWidget(theme);
  }

  Widget errorWidget(ThemeData theme) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            imageController.isServerError.value
                ? Icons.error_outline
                : Icons.wifi_off_outlined,
            size: 40.0,
            color: theme.iconTheme.color,
          ),
          Text(
            imageController.errorMsg.value,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          ElevatedButton(
            onPressed: imageController.initStateMethod,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget skeletonWidget(BuildContext context, ThemeData theme) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: theme.scaffoldBackgroundColor,
      highlightColor: theme.shadowColor,
      child: Container(
        height: size.height,
        width: size.width,
        color: theme.scaffoldBackgroundColor,
      ),
    );
  }

  Widget buildImage(BuildContext context, ThemeData theme) {
    Size size = MediaQuery.of(context).size;
    return commonContainerWidget(
      cornerColorsEmpty: imageController.cornerColors.isEmpty,
      theme: theme,

      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Container(
            alignment: Alignment.center,
            key: ValueKey(imageController.imageUrl.value),
            width: size.width,
            height: size.width,
            child: CachedNetworkImage(
              imageUrl: imageController.imageUrl.value,
              fit: BoxFit.cover,
              placeholder: (_, _) => commonContainerWidget(
                child: SizedBox(),
                cornerColorsEmpty: true,
                theme: theme,
              ),
              errorWidget: (_, _, _) => Icon(
                Icons.broken_image,
                size: 40,
                color: theme.iconTheme.color!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget commonContainerWidget({
    required ThemeData theme,
    required Widget child,
    required bool cornerColorsEmpty,
  }) {
    return Container(
      decoration: cornerColorsEmpty
          ? BoxDecoration(color: theme.scaffoldBackgroundColor)
          : BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            imageController.cornerColors["topLeft"]!,
            imageController.cornerColors["topRight"]!,
            imageController.cornerColors["bottomRight"]!,
            imageController.cornerColors["bottomLeft"]!,
          ],
          stops: const [0.0, 0.30, 0.70, 1.0],
        ),
      ),
      child: child,
    );
  }
}
