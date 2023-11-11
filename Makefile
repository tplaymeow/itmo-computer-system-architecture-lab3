bootstrap: install_swift_format

install_swift_format:
	@brew install swift-format

lint:
	@swift-format lint \
	--ignore-unparsable-files \
	--recursive \
	--strict \
	./Sources ./Tests Package.swift

format:
	@swift-format \
	--ignore-unparsable-files \
	--in-place \
	--recursive \
	./Sources ./Tests Package.swift

test:
	@TOOLCHAINS=swift swift test
