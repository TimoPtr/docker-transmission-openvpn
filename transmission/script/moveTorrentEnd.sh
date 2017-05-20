#!/bin/bash
# Check the type of the file (by checking the folder) 
# Tar the file in the final dir 


movie_final_dir="/data/final/movie"
serie_final_dir="/data/final/serie"
other_final_dir="/data/final/other"


out_dir="$other_final_dir"

cd $TR_TORRENT_DIR

if [[ $TR_TORRENT_DIR == *movie ]]
then
	$out_dir="$movie_final_dir"
elif [[ $TR_TORRENT_DIR == *serie ]]
then
	$out_dir="$serie_final_dir"
fi

echo "$out_dir/"$TR_TORRENT_NAME".tar"
 
tar -cvf "$out_dir/$TR_TORRENT_NAME.tar" $TR_TORRENT_NAME 
