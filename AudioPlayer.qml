import QtMultimedia 5.11
import QtQuick 2.0
Item {
    id: audioItem

    function updatePlaylist( jsonPlaylist ){
        var sourceList = JSON.parse(jsonPlaylist)
        audioPlaylist.clear()

        for( var source in sourceList['sources'] ){
            if(!sourceList['sources'][source]) break;
            audioPlaylist.addItem(
                "file://"+sourceList['sources'][source]
                )
        }

        audioPlaylist.shuffle()
        audioComponent.play()
    }

    function play(){
        audioComponent.play()
    }

    function start(){
        audioPlaylist.shuffle()
        audioComponent.play()
    }

    function stop(){
        audioComponent.stop()
    }

    function isPlaying(){
        return audioComponent.playbackState == Audio.PlayingState
    }

    Audio {
        id: audioComponent
        audioRole: Audio.MusicRole

        playlist: Playlist {
            id: audioPlaylist
            playbackMode: Playlist.Loop
        }
    }
}