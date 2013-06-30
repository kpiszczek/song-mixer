AudioPlayer [] loadTracks(Maxim maxim, String stub, String extension, int numImages)
{
  AudioPlayer [] tracks = new AudioPlayer[0];
  
  for(int i = 0; i < numImages; i++)
  {
    AudioPlayer track = maxim.loadFile(stub+i+extension, sample_rate);
    if(track != null)
    {
      track.setLooping(true);
      track.setAnalysing(true);
      track.cue(0);
      tracks = (AudioPlayer [])append(tracks,track);
    }
    else
    {
      break;
    }
  }
  return tracks;
}
