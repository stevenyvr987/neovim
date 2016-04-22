if(NOT DEFINED CTAGS_EXECUTABLE)
	find_program(CTAGS_EXECUTABLE ctags)
endif()

if (CTAGS_EXECUTABLE)
	set(CTAGS_OPTS
		"--recurse"
		"--c-kinds=+px"
		"--exclude=Makefile"
		"--tag-relative"
		"--fields=+S"
		"--sort=foldcase"
		"--totals"
		)
	add_custom_target(tags
		COMMAND ${CTAGS_EXECUTABLE} ${CTAGS_OPTS} ${CMAKE_CURRENT_SOURCE_DIR}
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		)
	add_custom_target(tagsclean
		COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/tags
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		)
endif()
