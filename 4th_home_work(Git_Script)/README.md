### Home work №5: GitHub script on bash

This script checks if there are open pull requests for a repository. An url like "https://github.com/$user/$repo" should be passed to the script

##### Synthax
  >./script "https://github.com/$user/$repo"

##### The script's output is:

* list of the most productive contributors (authors of more than 1 open PR)
* the number of PRs each contributor has created with the labels
* the extra feature is colorized output (it's probably works on linux and mac)
