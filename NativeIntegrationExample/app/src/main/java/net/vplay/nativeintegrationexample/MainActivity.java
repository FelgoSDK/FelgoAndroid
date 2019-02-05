package net.vplay.nativeintegrationexample;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;

import net.vplay.ui.VPlayAndroidActivity;
import net.vplay.ui.VPlayAndroidFragment;

import java.io.IOException;

public class MainActivity extends VPlayAndroidActivity {

  @Override protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    // activity_main.xml loads QML fragment:
    setContentView(R.layout.activity_main);

    // show QML fragment via code: (uncomment FrameLayout in activity_main.xml)
/*    try {
      getFragmentManager().beginTransaction()
          .replace(R.id.fragment_container, new VPlayAndroidFragment()
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
