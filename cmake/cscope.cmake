if(NOT DEFINED CSCOPE_EXECUTABLE)
	find_program(CSCOPE_EXECUTABLE cscope)
endif()

if (CSCOPE_EXECUTABLE)
	set(CSCOPE_OPTS "-bqR")

	add_custom_target(cscope
		COMMAND ${CSCOPE_EXECUTABLE} ${CSCOPE_OPTS} -s ${CMAKE_SOURCE_DIR}/src
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		)
	add_custom_target(cscopeclean
		COMMAND rm -f cscope*out
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		)
endif()
