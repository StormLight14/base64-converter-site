read -p "Are you sure you want to deploy? (y/n) " answer
if [[ $answer != [yY] ]]; then
  echo "Aborting..."
  exit 0
fi

echo "Building application..."
trunk build

echo "Copying files to remote server..."
ssh storm@storm-dev.ddns.net "rm -r /var/www/html/base64/*"
scp ./dist/* storm@storm-dev.ddns.net:/var/www/html/base64/

echo "Reloading Apache..."
ssh -t storm-dev.ddns.net sudo systemctl reload apache2