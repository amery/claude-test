#!/bin/sh
# Reports, by name only, which credentials are in this process's
# environment and in the readable environments of its ancestors.
# Values are never printed.
set -eu

vars='CLAUDE_CODE_OAUTH_TOKEN ACTIONS_ID_TOKEN_REQUEST_TOKEN ACTIONS_RUNTIME_TOKEN DEFAULT_WORKFLOW_TOKEN GITHUB_TOKEN'

for v in $vars; do
	if printenv "$v" > /dev/null; then
		echo "own: $v set"
	else
		echo "own: $v unset"
	fi
done

pid=$PPID
while [ "$pid" -gt 1 ]; do
	comm=$(cat "/proc/$pid/comm")
	if ! lines=$(tr '\0' '\n' < "/proc/$pid/environ"); then
		echo "ancestor $pid ($comm): environment unreadable"
	else
		for v in $vars; do
			case "
$lines" in
			*"
$v="*)
				echo "ancestor $pid ($comm): $v set"
				;;
			esac
		done
	fi
	pid=$(sed -n 's/^PPid:[[:space:]]*//p' "/proc/$pid/status")
done
