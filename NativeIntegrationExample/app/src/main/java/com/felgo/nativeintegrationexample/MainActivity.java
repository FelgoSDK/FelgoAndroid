package com.felgo.nativeintegrationexample;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;

import com.felgo.ui.FelgoAndroidActivity;
import com.felgo.ui.FelgoAndroidFragment;

import java.io.IOException;

public class MainActivity extends FelgoAndroidActivity {

  @Override protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    // activity_main.xml loads QML fragment:
    setContentView(R.layout.activity_main);

    // show QML fragment via code: (uncomment FrameLayout in activity_main.xml)
/*    try {
      getFragmentManager().beginTransaction()
          .replace(R.id.fragment_container, new FelgoAndroidFragment()
                  .setQmlSource(getApplicationContext(), "qml/Cube3D.qml"),
              null)
          .addToBackStack(null)
          .commit();
    } catch (IOException ex) {
      // qml file not found
      Log.w("MainActivity", "Could not load QML file", ex);
    }*/
  }
}
