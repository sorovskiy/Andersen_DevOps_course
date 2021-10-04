#!/bin/bash

declare -A pulls

if [ ! -n "$1" ]
then
  echo "You need to enter address of repository"
  exit 1
fi

# extracting user and repo from input
user="$(echo $1 | grep / | cut -d/ -f4)"
repo="$(echo $1 | grep / | cut -d/ -f5)"


request="$(curl https://api.github.com/repos/$user/$repo/pulls)" # get the json of pull requests from github api
test="$(echo "$request" | jq .[0])" # checking if there is PR's
if [ "$test" = "null" ]
then
  echo "There is no Pull Requests in this repository"
  exit 1
fi

n="$(echo "$request" | jq .[].title | wc -l)" # getting the number of PR's

for (( i=0; i < $n; i++ )) # creating dictionary of PR's
do
	curr=$(echo "$request" | jq .[$i].user.login)
	if [ -n "${pulls[$curr]}" ]
	then
	  pulls[$curr]=$((${pulls[$curr]} + 1))
	else
	  pulls[$curr]=1
	fi
done

pulls["Hello"]=10

echo -e "\e[42mList of most productive contributors:\e[0m"
for key in "${!pulls[@]}"
do
  if [ ${pulls[$key]} -gt 1 ]
  then
    echo -e "\e[46m$key\e[0m  author has ${pulls[$key]} open PR's"
  fi
done

echo ""
echo -e "\e[42mThe number of PRs each contributor has created with the labels:\e[0m"
for key in "${!pulls[@]}"
do
  labels=""
  for (( i=0; i < n; i++ ))
  do
    user=$(echo "$request" | jq .[$i].user.login)
    if [ $user = $key ]
    then
        lab=$(echo "$request" | jq .[$i].title)
	labels="$labels \e[$((30 + $RANDOM % 6))m$lab\e[0m"
    fi
  done
  echo -e "\e[46m$key\e[0m author has ${pulls[$key]} open PR's with labels $labels"
done

