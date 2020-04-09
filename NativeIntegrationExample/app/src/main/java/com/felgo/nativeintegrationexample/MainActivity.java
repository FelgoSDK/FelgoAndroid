package com.felgo.nativeintegrationexample;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.util.Log;

import com.felgo.ui.FelgoAndroidActivity;
import com.felgo.ui.FelgoAndroidFragment;

import org.qtproject.qt5.android.bindings.QtFragment;

public class MainActivity extends FelgoAndroidActivity {

  private FelgoAndroidFragment m_qtFragment;

  @Override protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    // activity_main.xml loads QML fragment:
    setContentView(R.layout.activity_main);

    Toolbar toolbar = findViewById(R.id.toolbar);
    setSupportActionBar(toolbar);

    m_qtFragment = (FelgoAndroidFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);

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
