notmuch new
notmuch tag --batch --input=/home/lixun/.config/offlineimap/notmuch_tags
notmuch search --output=files tag:deleted | sed 's_[,:!@#$%^&*()-= ]_\\&_g' | xargs -l rm -f
