#!/usr/bin/env bash
set -euo pipefail

export RED='\033[1;38;5;196m'
export YELLOW='\033[1;38;5;220m'
export GREEN='\033[1;38;5;82m'
export GRAY='\033[38;5;250m'
export RESET='\033[0m'

cd "$(dirname "${BASH_SOURCE[0]}")"

echo -e "${YELLOW}# Checking files at path $PWD${RESET}"
find . -type f -print0 | while IFS= read -r -d '' file; do
	if [[ "$file" != *"/.git/"* && "$file" != *"/.mypy_cache/"* ]]; then
		if sops -d "$file" >/dev/null 2>&1; then
			echo -e "${GREEN}++ Updating keys for encrypted file: $file${RESET}"
			if ! sops updatekeys --yes "$file"; then
				echo -e "${RED}!! Failed to update keys for file $file${RESET}"
			fi
		else
			echo -e "${GRAY}-- DO not update file: $file${RESET}"
		fi
	fi
done
