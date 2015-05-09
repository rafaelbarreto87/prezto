function pick_tmux_session() {
    # if already inside a TMUX session, ignore
    if [[ "$TMUX" == "" ]]; then
        # present menu for user to choose which workspace to open
        PS3="Please choose your session: "
        choices=($(tmux list-sessions -F "#S" 2> /dev/null) "NEW SESSION")
        echo "Available tmux sessions"
        echo "-----------------------"
        echo
        select opt in "${choices[@]}"; do
            case "$opt" in
                "NEW SESSION")
                    printf "Enter a name for the new session: "
                    read session_name
                    tmux new -s "$session_name"
                    break
                    ;;
                "")
                    echo "invalid choice"
                    break
                    ;;
                *)
                    tmux attach -t "$opt"
                    break
                    ;;
            esac
        done
    fi
}
