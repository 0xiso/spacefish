set root (dirname (status -f))
source $root/tests/spacefish_test_setup.fish

function setup
	spacefish_test_setup
	mock php -v 0 "echo \"PHP 7.1.16 (cli) (built: Mar 31 2018 02:59:59) ( NTS )
	Copyright (c) 1997-2018 The PHP Group
	Zend Engine v3.1.0, Copyright (c) 1998-2018 Zend Technologies\""
	mkdir -p /tmp/$filename
	cd /tmp/$filename
end

function teardown
	rm -rf /tmp/$filename
end

@test "Prints section when composer.json is present" (
		touch /tmp/$filename/composer.json

		set_color --bold
		echo -n "via "
		set_color normal
		set_color --bold blue
		echo -n "🐘 v7.1.16"
		set_color normal
		set_color --bold
		echo -n " "
		set_color normal
) = (__sf_section_php)

@test "Prints section when a *.php file is present" (
		touch /tmp/$filename/testfile.php

		set_color --bold
		echo -n "via "
		set_color normal
		set_color --bold blue
		echo -n "🐘 v7.1.16"
		set_color normal
		set_color --bold
		echo -n " "
		set_color normal
) = (__sf_section_php)

@test "Doesn't print the section when composer.json and *.php aren't present" () = (__sf_section_php)

@test "Changing SPACEFISH_PHP_SYMBOL changes the displayed character" (
		touch /tmp/$filename/composer.json
		set SPACEFISH_PHP_SYMBOL "· "

		set_color --bold
		echo -n "via "
		set_color normal
		set_color --bold blue
		echo -n "· v7.1.16"
		set_color normal
		set_color --bold
		echo -n " "
		set_color normal
) = (__sf_section_php)

@test "Changing SPACEFISH_PHP_PREFIX changes the character prefix" (
		touch /tmp/$filename/composer.json
		set sf_exit_code 0
		set SPACEFISH_PHP_PREFIX ·

		set_color --bold
		echo -n "·"
		set_color normal
		set_color --bold blue
		echo -n "🐘 v7.1.16"
		set_color normal
		set_color --bold
		echo -n " "
		set_color normal
) = (__sf_section_php)

@test "Changing SPACEFISH_PHP_SUFFIX changes the character suffix" (
		touch /tmp/$filename/composer.json
		set sf_exit_code 0
		set SPACEFISH_PHP_SUFFIX ·

		set_color --bold
		echo -n "via "
		set_color normal
		set_color --bold blue
		echo -n "🐘 v7.1.16"
		set_color normal
		set_color --bold
		echo -n "·"
		set_color normal
) = (__sf_section_php)

@test "doesn't display the section when SPACEFISH_PHP_SHOW is set to \"false\"" (
		touch /tmp/$filename/composer.json
		set SPACEFISH_PHP_SHOW false
) = (__sf_section_php)
