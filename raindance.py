from PySide2.QtCore import Qt, QObject, QUrl, Slot, Signal
from PySide2.QtQuick import QQuickView
from PySide2.QtWidgets import QApplication

from configuration import RaindanceConfig

from os import listdir
from os.path import isfile, join, abspath

from requests import post, get

# define slot functions
class Backend(QObject):

    view = None

    AUDIOPATHS = ['audio']

    SWITCHURL = "http://homeassistant:8123/api/services/light/toggle"
    WAKEENTITY = "light.alexa_virtual_wake"
    SLEEPENTITY = "light.alexa_virtual_sleep"

    MESSAGEURL = "http://manetheren/services/message.php"

    # SIGNALS #

    # emit this signal when the playlist has been
    # updated
    updatePlaylist = Signal(str)
    updateMessage = Signal(str)

    # SLOTS #

    @Slot()
    def dimDisplay(self):
        f = open("/sys/class/backlight/rpi_backlight/brightness", "w")
        f.write("7")
        f.close()
        return
    
    @Slot()
    def lightDisplay(self):
        f = open("/sys/class/backlight/rpi_backlight/brightness", "w")
        f.write("200")
        f.close()
        return
    
    @Slot()
    def test(self):
        self.updatePlaylist.emit("playlist test")

    @Slot(str)
    def checkPlaylist(self, modes):
        jsonString = "{\"sources\":["
        for path in self.AUDIOPATHS:
            for f in listdir(path):
                if isfile( join(path, f) ):
                    jsonString += '"'+abspath(join(path,f))+'",'
        jsonString += "false]}"
        self.updatePlaylist.emit(jsonString)

    @Slot()
    def sendWakeCommand(self):
        self.sendSwitchCommand(Backend.WAKEENTITY)

    @Slot()
    def sendSleepCommand(self):
        self.sendSwitchCommand(Backend.SLEEPENTITY)

    def sendSwitchCommand(self, entity):
        headers = {
            "Authorization": "Bearer " + RaindanceConfig.AUTHTOKEN,
            "content-type": "application/json",
        }
        data = {
            "entity_id": entity
        }
        try:
            response = post(Backend.SWITCHURL,headers=headers,json=data)
        except:
            print("HTTP connection error on switch command, continuing")

    @Slot()
    def requestMessage(self):
        try:
            response = get(Backend.MESSAGEURL)
            if response.status_code == 200:
                self.updateMessage.emit(response.content.decode())
        except:
            print("HTTP error in message request, continuing")

    # BACKEND SETUP

    ## Setup backend to connect signals
    def setup(self):
        self.updatePlaylist.connect( self.view.rootObject().updatePlaylist )
        self.updateMessage.connect( self.view.rootObject().updateMessage )

    ## initialize the backend
    def __init__(self, parent=None, view=None):
        QObject.__init__(self,parent)
        self.view = view
        self.m_text = ""



# load the display

app = QApplication([])
view = QQuickView()

app.setOverrideCursor(Qt.BlankCursor)

# create a manager
backend = Backend(None, view)

context = view.rootContext()
context.setContextProperty("backend", backend)

url = QUrl("main.qml")

view.setSource(url)
view.showFullScreen()

# run setup
backend.setup()

app.exec_()