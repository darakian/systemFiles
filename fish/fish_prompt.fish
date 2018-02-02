function fish_prompt
	test $SSH_TTY; and printf (set_color red)(whoami)(set_color white)'@'(set_color yellow)(hostname)' '
	if not set -q __git_cb
        set __git_cb ":"(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
	end

    test $USER = 'root'; and echo (set_color red)"#"

    # Main
	echo -n (set_color FFFFFF)"$USER"(set_color 00FFFF)(prompt_pwd)(set_color 00FF00)"$__git_cb"(set_color ff0000)'❯'(set_color ffff00)'❯'(set_color 66ff00)'❯ '(set_color cyan)
end
