 import VPlayApps 1.0
 import QtQuick 2.9
 // 3d imports
 import QtQuick.Scene3D 2.0
 import Qt3D.Core 2.0
 import Qt3D.Render 2.0
 import Qt3D.Input 2.0
 import Qt3D.Extras 2.0
 import QtSensors 5.9

 App {
   // use a license key to remove the splash screen
   licenseKey: "A8C45807243D543D7886F7E0C74BE137F829ECDECD1C5C9B2D5A04632A4C414641E19FBA08A780E016C12D85FABEA85BEFCA441F34431000A0515D27733A9EFA26E37A2DDE3BB549626B6680B04729B1F2F6ED00045593D954ED9989C68BC7FA1CD762A676CEC2F29E7D81F543BEE8481032CD16493917087654109AAEF3ABB523AB6552E0A3E39179DCCD055CA4459BD91FEA1554A1679F62218C072AD0B06E7A2A11144FFC107A0387DE5E857B0EB2C73BF3E0DADA4106117C2849E48D6D57815D79D01648C1752F9CDDA98C2CC8228339C3DFB3271BFCE525D797B865585B286730ABD4CA06AD24E45AF879413C81573E2F461EDF69FEF7E5A2F5BEDC9B0ED74A559B59D856940CCFAD0199F7FB338D775FDA129D853FE359001CCD64FFFA632E0FEC1324C0142942B71F1C6C1B8F5D50E109DBF3E76E58BD84BC6958E86F"


   // Set screen to portrait in live client app (not needed for normal deployment)
   onInitTheme: nativeUtils.preferredScreenOrientation = NativeUtils.ScreenOrientationPortrait

   RotationSensor {
     id: sensor
     active: true
     // We copy reading to custom property to use behavior on it
     property real readingX: reading ? reading.x : 0
     property real readingY: reading ? reading.y : 0
     // We animate property changes for smoother movement of the cube
     Behavior on readingX {NumberAnimation{duration: 200}}
     Behavior on readingY {NumberAnimation{duration: 200}}

     Component.onCompleted: {
        console.log("sensor completed", active, busy, connectedToBackend, "types:" + QmlSensors.sensorTypes())
        start()
        console.log("sensor started", active, busy, connectedToBackend)
     }
     onActiveChanged: console.log("sensor active", active, busy, connectedToBackend)
   //  onBusyChanged: console.log("sensor busy", active, busy, connectedToBackend)

   }

 Page {
   title: "3D Cube on Page"
   backgroundColor: Theme.secondaryBackgroundColor

   Column {
     padding: dp(15)
     spacing: dp(5)

     AppText {
       text: "x-axis " + sensor.readingX.toFixed(2)
     }
     AppText {
       text: "y-axis " + sensor.readingY.toFixed(2)
     }
   }

   // 3d object on top of camera
   Scene3D {
     id: scene3d
     anchors.fill: parent
     focus: true
     aspects: ["input", "logic"]
     cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

     Entity {

       // The camera for the 3d world, to view our cube
       Camera {
         id: camera3D
         projectionType: CameraLens.PerspectiveProjection
         fieldOfView: 45
         nearPlane : 0.1
         farPlane : 1000.0
         position: Qt.vector3d( 0.0, 0.0, 40.0 )
         upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
         viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
       }

       components: [
         RenderSettings {
           activeFrameGraph: ForwardRenderer {
             camera: camera3D
             clearColor: "transparent"
           }
         },
         InputSettings { }
       ]

       PhongMaterial {
         id: material
         ambient: Theme.tintColor // Also available are diffuse, specular + shininess to control lighting behavior
       }

       // The 3d mesh for the cube
       CuboidMesh {
         id: cubeMesh
         xExtent: 8
         yExtent: 8
         zExtent: 8
       }

       // Transform (rotate) the cube depending on sensor reading
       Transform {
         id: cubeTransform
         // Create the rotation quaternion from the sensor reading
         rotation: fromAxesAndAngles(Qt.vector3d(1,0,0), sensor.readingX*2, Qt.vector3d(0,1,0), sensor.readingY*2)
       }

       // The actuac 3d cube that consist of a mesh, a material and a transform component
       Entity {
         id: sphereEntity
         components: [ cubeMesh, material, cubeTransform ]
       }
     }
   } // Scene3D

   // Color selection row
   Row {
     anchors.horizontalCenter: parent.horizontalCenter
     anchors.bottom: parent.bottom
     spacing: dp(5)
     padding: dp(15)

     Repeater {
       model: [Theme.tintColor, "red", "green", "#FFFF9500"]

       Rectangle {
         color: modelData
         width: dp(48)
         height: dp(48)
         radius: dp(5)

         MouseArea {
           anchors.fill: parent
           onClicked: {
             material.ambient = modelData
           }
         }
       }
     }
   }
 } // Page
 } // App