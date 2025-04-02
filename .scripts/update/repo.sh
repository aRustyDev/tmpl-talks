#!/usr/bin/env bash

# dependency checks

if [ ! -f .config/talk.yaml ]; then
    echo "Error: .config/talk.yaml not found"
    echo "Info: Created .config/talk.yaml"
    touch $GIT_ROOT/.config/talk.yaml
    exit 1
fi
if  [ "Author Name" == $(yq '.authors[0].name' .config/talk.yaml) ] || \
    [ "author@example.com" == $(yq '.authors[0].email' .config/talk.yaml) ]; then
    echo "Error: Fill out .config/talk.yaml first"
    exit 1
fi

GIT_USER=$(git config user.name)
GIT_MAIL=$(git config user.email)
GIT_ROOT=$(git rev-parse --show-toplevel)
AUTHORS="""# This is the official list of Talk authors for copyright purposes.
# This file is distinct from the CONTRIBUTORS files.
# See the latter for an explanation.

# Names should be added to this file as:
# Name or Organization <email address>
# The email address is not required for organizations.

"""

# Replace template variables
for i in {0..$(yq '.authors[] | length' .config/talk.yaml)}; do
    AUTHORS+="$(yq -y --arg i "$i" '.authors[$i] | "\(.name) <\(.email)>"' .config/talk.yaml)\n"
done
echo $AUTHORS > $GIT_ROOT/AUTHORS
sed -i -e 's/{{git_name}}/$GIT_USER/g' $GIT_ROOT/CODEOWNERS
sed -i -e 's/{{git_name}}/$GIT_USER/g' $GIT_ROOT/CONTRIBUTORS
sed -i -e 's/{{git_name}}/$GIT_USER/g' $GIT_ROOT/LICENSE
sed -i -e 's/{{git_email}}/$GIT_MAIL/g' $GIT_ROOT/CONTRIBUTORS
# sed -i -e 's/{{talk_title}}/$GIT_MAIL/g' $GIT_ROOT/.scripts/init/github.sh
