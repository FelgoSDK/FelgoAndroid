# Integrate Felgo with Existing Apps

This guide describes how to integrate Felgo into existing Android projects.

*Felgo Native Integration* comes as an Android aar library file.
You can add it as a regular maven dependency.

1. Add the felgo-android dependency in your build.gradle file:

	```groovy
	dependencies {
        implementation 'com.felgo:felgo-android:3.+'
	}
	```

2. Add the Felgo Maven repository at the repositories block:

	```groovy 
	repositories {
        maven { url 'https://github.com/FelgoSDK/FelgoAndroid/raw/master/maven/' }
	}
	```

3. Set the base class of any Activity that includes Felgo to `FelgoAndroidActivity`

4. Add your QML code to the application assets. The following example uses the file `assets/qml/Main.qml`.

5. Add `FelgoAndroidFragment` in layout or in source.
	1. From XML layout:
	
		```xml
		<fragment
		    android:id="@+id/qt_fragment_container"
		    class="com.felgo.ui.FelgoAndroidFragment"
		    android:layout_width="match_parent"
		    android:layout_height="match_parent"
		    app:qml_source="qml/Main.qml"/>
		```
	
	2. From source:

		```java
		getFragmentManager().beginTransaction()
		    .replace(R.id.qt_fragment_container, new FelgoAndroidFragment()
		             .setQmlSource(getApplicationContext(), "qml/Main.qml"), 
		         null)
		     .addToBackStack(null)
		     .commit();
		```

	Note: `R.id.qt_fragment_container` must be a view in the current activity.

## Example Application

The folder `NativeIntegrationExample` contains a complete Android example project
making use of FelgoAndroid.
You can open it directly in Android Studio.
	
