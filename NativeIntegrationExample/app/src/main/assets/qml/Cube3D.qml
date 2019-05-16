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
   licenseKey: "7CFB6B4DBEAF65BACCA104174D8D10074AB9DE51CD8FADCE794842AC15A424B5DB0ADE80EA99588A8E581B8F019647F1C97F6569C4F81C27E76E8EFF8CB5581C1E761EDF6DC35D826EFFBB10C6041C97220674F01F425134E53A69B7BBCB2B31A3280C2A024F4123FE06EDAE4D31457F02FCB57EC9395DC271D2689AE58A78EB161021E10DDFCC4A069A5280CB401FC5D5207DDD384EF42EBAAA2F13FA7309A57A70AB5D164416AF06F000C5E3A0EC3871D47B876E0EB807171EF09F01A631B6CBF12ECD02F11677E93F0792A57EE53F83AE3E11AD94D1AF5FC5297B1E35F956EB8C0F8AF72DAADEB0B5320DA93F8A2396A52FB53F1107837C5DF03271B938612C0DF798B0F4A300B233FC3C7D8BFC7D52DFB4C0A216F9216FCCDD2C9A6C4F7288B71985AD6B3201F052D2B60DA904126FD44F74A195D9E46C4F6F6A24643EEA"


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