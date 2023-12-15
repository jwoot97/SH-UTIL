PS3="Select directory to update: "

select dir in $(ls -1); do
	echo "Updating $dir contents..."
	cd ./$dir
	ls | xargs -I{} git -C {} pull
	cd ../
done
exit 1
