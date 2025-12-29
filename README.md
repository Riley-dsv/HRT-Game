# GAME HRT

A small application to Gamify your HRT taking.

## How does it works ? 

Simple, you open it and click on the only button it will display a message and update your streak by one. Then you will be notified. It works on iOS and android. But because I don't own any iOS device, I will let you compile this yourself.

## Installation 

Go into releases and download the .apk for android or the equivalent for iOS.

## Developement

I will assume you already installed `flutter`, `dart`, `sdkmanager` and the ADK.
Clone it:

```bash
git clone https://github.com/Riley-dsv/HRT-Game.git
```

```
cd HRT-Game
flutter clean
flutter pub get
# To debug
flutter run
# To production
flutter build apk
```

## Note

I do not like the current name, but I had to come with a name so it won't be " Demo App ". If you have a suggestion, you can open a discussion. 

## FAQ.

Q. Can I schedule the notification myself ? 
A. Yes, you just need to recompile the application.

Q. What does it do if I miss a day ?
A. I'm pretty sure I forgot to implement the drawback if you do not do it.

Q. Why 7pm and 7pm for notification ? 
A. Blame my friend, I made the app for her in a first place.

Q. Will it be updated ?
A. Yes, this is still an MVP, I will work on it to make it better.

Q. Do you actively support Linux, Windows or MacOS ?
A. No, I will focus on phone. This is made with dart and flutter, so it might be doable to just fork it yourself and maintain those versions.

Q. Why is it ugly ?
A. I'm not a designer.
