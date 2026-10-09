#!/bin/bash
# Wrapper for agentx that syncs the live proxy before each call.
# The VM's egress proxy password rotates frequently, so the stored
# proxy in ~/.agentx/accounts.json goes stale within minutes.
# This wrapper refreshes it from $https_proxy on every invocation.

ACCOUNTS_FILE="$HOME/.agentx/accounts.json"

if [ -n "$https_proxy" ] && [ -f "$ACCOUNTS_FILE" ]; then
    # Update proxy for all accounts using python3 (no jq dependency)
    https_proxy="$https_proxy" python3 -c "
import json, os, sys
f = os.path.expanduser('~/.agentx/accounts.json')
try:
    with open(f) as fh:
        d = json.load(fh)
    proxy = os.environ.get('https_proxy', '')
    changed = False
    # accounts may be a dict or list; handle both
    accounts = d.get('accounts', d)
    if isinstance(accounts, dict):
        for name, acc in accounts.items():
            if isinstance(acc, dict) and acc.get('proxy') != proxy:
                acc['proxy'] = proxy
                changed = True
    elif isinstance(accounts, list):
        for acc in accounts:
            if isinstance(acc, dict) and acc.get('proxy') != proxy:
                acc['proxy'] = proxy
                changed = True
    if changed:
        with open(f, 'w') as fh:
            json.dump(d, fh)
except Exception as e:
    sys.stderr.write(f'proxy sync warning: {e}\n')
" 2>/dev/null
fi

exec "$(dirname "$0")/agentx" "$@"
