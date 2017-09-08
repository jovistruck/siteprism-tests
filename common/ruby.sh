#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$BIN_DIR/colours.sh"

RUBY_MIN_VERSION="${1:-}"
RUBY_MAX_VERSION="${2:-}"

if [[ -z "$RUBY_MIN_VERSION" ]]; then
    echo -e "${RED}Usage: $0 <ruby-min-version> [ruby-max-version]${NC}" >&2
    exit 1
fi

if ! ruby --version >/dev/null 2>&1; then
    echo -e "${RED}Cannot find ruby executable on PATH; exiting...${NC}" >&2
    exit 1
fi

RUBY_CURRENT_VERSION="$(ruby --version | awk '{print $2}' | awk -F 'p' '{print $1}')"

RUBY_VERSIONS="$RUBY_CURRENT_VERSION\n$RUBY_MIN_VERSION"
if [[ -n "$RUBY_MAX_VERSION" ]]; then
    RUBY_VERSIONS="$RUBY_VERSIONS\n$RUBY_MAX_VERSION"
fi

SORTED_VERSION=$(echo -e "$RUBY_VERSIONS" | sort -t '.' -k 1,1 -k 2,2 -k 3,3)

if [[ $(echo -e "$SORTED_VERSION" | head -1) != "$RUBY_MIN_VERSION" ]]; then
    echo -e "${RED}Current Ruby is $RUBY_CURRENT_VERSION at $(which ruby); required min version of $RUBY_MIN_VERSION${NC}" >&2
    exit 1
fi

if [[ -n "$RUBY_MAX_VERSION" ]]; then
    if [[ $(echo -e "$SORTED_VERSION" | tail -1) != "$RUBY_MAX_VERSION" ]]; then
        echo -e "${RED}Current Ruby is $RUBY_CURRENT_VERSION at $(which ruby); required max version of $RUBY_MAX_VERSION${NC}" >&2
        exit 1
    fi
fi

if ! bundle --version >/dev/null 2>&1; then
    echo -e "${RED}Cannot find bundle executable on PATH; attempting installation${NC}" >&2
    if ! gem install bundler >/dev/null 2>&1; then
        echo -e "${RED}Bundler installation failed; exiting...${NC}" >&2
        exit 1
    fi
    if rbenv version >/dev/null 2>&1; then
        rbenv rehash
    fi
fi

echo -e "${GREEN}Found acceptable Ruby version $RUBY_CURRENT_VERSION${NC}"
