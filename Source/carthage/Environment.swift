//
//  Environment.swift
//  Carthage
//
//  Created by J.D. Healy on 2/6/15.
//  Copyright (c) 2015 Carthage. All rights reserved.
//

import CarthageKit
import Foundation
import Result

internal func getEnvironmentVariable(_ variable: String) -> Result<String, CarthageError> {
	let environment = ProcessInfo.processInfo.environment

	if let value = environment[variable] {
		return .success(value)
	} else {
		return .failure(CarthageError.missingEnvironmentVariable(variable: variable))
	}
}

/// Information about the possible parent terminal.
internal struct Terminal {
	/// Terminal type retrieved from `TERM` environment variable.
	static var terminalType: String? {
		return getEnvironmentVariable("TERM").value
	}
	
	/// Whether terminal type is `dumb`.
	static var isDumb: Bool {
		return (terminalType?.caseInsensitiveCompare("dumb") == .orderedSame) ?? false
	}
	
	/// Whether STDOUT is a TTY.
	static var isTTY: Bool {
		return isatty(STDOUT_FILENO) != 0
	}
}
