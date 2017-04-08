extends StreamPlayer

var music

func play_song(musicfile):
	music = load(musicfile)
	set_stream(music)
	set_loop(true)
	play()