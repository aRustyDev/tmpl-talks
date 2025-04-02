#!/usr/bin/env bash

gh auth login
gh project create --owner=@me \
--template "" \
--title "{{talk_title}}"

gh repo rename [<new-name>] \
--repo x\
-y

gh gist clone <gist> [<directory>] [-- <gitflags>...]

for i in $(yq '.tasks[]' .config/talk.yaml); do
    gh project add-user --user $user --project "{{talk_title}}"
done
