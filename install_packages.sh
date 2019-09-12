#! /usr/bin

# install font inconsolata
sudo apt-get install fonts-inconsolata -y
sudo fc-cache -fv
# install texlive
sudo apt install texlive texlive-latex-extra texlive-publishers texlive-science
# install compilers
sudo apt install gcc g++ cmake
# install exa
sudo apt install curl
curl https://sh.rustup.rs -sSf | sh
manually add PATH: source ~/.cargo/env
sudo apt install libgit2-26
cargo install exa
# install dtrx
sudo apt install dtrx
#install git
sudo apt install git
# install hstr
sudo add-apt-repository ppa:ultradvorka/ppa
sudo apt update
sudo apt install hstr
hstr --show-configuration >> ~/.bashrc
# install vim
sudo apt install vim
# install tilix
sudo apt install tilix
sudo update-alternatives --config x-terminal-emulator
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
copy nord.json to /usr/share/tilix/schemes
get .bashrc from dropbox
# install emacs
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26
get init.el from Dropbox/env_settings/emacs
# install Gnupg2
sudo apt-get install gnupg2
gpg --full-generate-key
# install notmuch
sudo apt install notmuch
install notmuch package in emacs
# install offlineimap
sudo apt install python-pip
pip install --user offlineimap
(Update Sep. 11: The above pip install does not work on Ubutu 18.04
Offlineimap can be install using apt install)
sudo cp ~/.local/bin/offlineimap /usr/local/bin/
get offline settings from Dropbox/env_settings/offline_notmuch
  offlineimap <-- this is the ~/.config/offlineimap folder
  .offlineimap <-- this is the ~/.offlineimap
  .offlineimaprc
  .offlineimap.py
  .offlineimap.pyc
  .notmuch_config
.authinfo should contain the following
machine imap.gmail.com login zhanglx@utexas.edu port 993 password fgyxviafhuzblzkb
# sign the key
gpg -se .authinfo
chmod 600 .authinfo.gpg

offlineimap # start fetching emails

