#!/bin/bash
# When a movie/serie/music/other are done downloading this script is trigger to create cache if its movie or serie (usefull for sonarr/couch) and create a file in final directory which will trigger the upload of the torrent on the cloud

# final dir 
movie_final_dir="/data/final/movie"
serie_final_dir="/data/final/serie"
music_final_dir="/data/final/music"
other_final_dir="/data/final/other"

# cache dir
movie_cache_dir="/cache/movie"
serie_cache_dir="/cache/serie"


function createFinal {
	final_dir=$1
	touch "${final_dir}/${TR_TORRENT_NAME}"
	echo "MOVE_TORRENT : dir = $TR_TORRENT_DIR       torrent = ${TR_TORRENT_NAME} create final in ${final_dir}" >> /config/transmission.log
}

function createCache {
	cache_dir=$1

	find "${TR_TORRENT_DIR}/${TR_TORRENT_NAME}" -type d |
	while read -r dir; do
		name="${cache_dir}/${dir#${TR_TORRENT_DIR}/}"
		#echo "$name"
		if [ ! -d "${name}" ]; then
    			mkdir "${name}"
		fi
	done

	find "${TR_TORRENT_DIR}/${TR_TORRENT_NAME}" -type f |
	while read -r file; do
		#echo "${file#${TR_TORRENT_DIR}/}"
		#echo "${cache_dir}/${file#${TR_TORRENT_DIR}/}" 				
		touch "${cache_dir}/${file#${TR_TORRENT_DIR}/}"
	done	
	echo "MOVE_TORRENT : dir = $TR_TORRENT_DIR       torrent = ${TR_TORRENT_NAME} create cache in ${cache_dir}" >> /config/transmission.log
}


if [[ $TR_TORRENT_DIR == *movie* ]]
then
	createFinal ${movie_final_dir}
	creatteCache ${movie_cache_dir}
elif [[ $TR_TORRENT_DIR == *serie* ]]
then
	createFinal ${serie_final_dir}
	creatteCache ${serie_cache_dir}
elif [[ $TR_TORRENT_DIR == *music* ]]
then
	createFinal ${music_final_dir}
else
	createFinal ${other_final_dir}
fi
