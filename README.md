# Wild Frontier — Android 3D survival starter

This is a small, offline, third-person survival prototype made with Godot 4.3+.

## Included
- Procedurally placed low-poly forest and collectible resources
- Third-person character and basic movement
- Health, hunger, thirst and inventory counters
- Berry eating button
- Touch drag movement for Android

## Open and run
1. Install Godot 4.3 or newer.
2. Import `project.godot` from this folder.
3. Press F6/F5 to run the project.

## Export an Android APK
1. In Godot, install the matching export templates (Editor > Manage Export Templates).
2. Install Android Studio / Android SDK and configure the Android SDK path in Editor Settings > Export > Android.
3. Create an Android export preset: Project > Export > Add… > Android.
4. Set a unique package name, e.g. `com.yourstudio.wildfrontier`.
5. For a test build, enable APK output and export as `WildFrontier.apk`.
6. Install the APK on your Android device. You may need to allow installation from your file manager.

## Prototype limitations
This is a playable starting point, not a finished commercial game. It uses primitive placeholder models, has no combat, crafting UI, save/load, terrain height variation, or optimized large-world streaming yet. Add those systems before publishing.
