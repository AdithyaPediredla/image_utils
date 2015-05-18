/*
 * image_utils//image_utils/include/imformat_mex.h
 *
 *  Created on: Feb 11, 2015
 *      Author: igkiou
 */

#ifndef IMFORMAT_MEX_H_
#define IMFORMAT_MEX_H_

#include "mex_utils.h"

/*
 * TODO: Force all derived types to be non-copyable and non-movable. Check
 * whether deleting copy and move  constructors and operators for Interface is
 * sufficient to enforce this for derived classes.
 */

namespace imformat {

class ImformatInputFileInterface {
public:
	ImformatInputFileInterface(const ImformatInputFileInterface& other) = delete;
	ImformatInputFileInterface& operator=(const ImformatInputFileInterface& other) = delete;

	ImformatInputFileInterface(ImformatInputFileInterface&& other) = delete;
	ImformatInputFileInterface& operator=(ImformatInputFileInterface&& other) = delete;

	virtual mex::MxString getFileName() const = 0;
	virtual mex::MxNumeric<bool> isValidFile() const = 0;
	virtual int getHeight() const = 0;
	virtual int getWidth() const = 0;
	virtual int getNumberOfChannels() const = 0;
	virtual mex::MxArray getAttribute(const mex::MxString& attributeName)
									const = 0;
	virtual mex::MxArray getAttribute() const = 0;
	virtual mex::MxArray readData() = 0;
	virtual ~ImformatInputFileInterface() = default;
};

class ImformatOutputFileInterface {
public:
	ImformatOutputFileInterface(const ImformatOutputFileInterface& other) = delete;
	ImformatOutputFileInterface& operator=(const ImformatOutputFileInterface& other) = delete;

	ImformatOutputFileInterface(ImformatOutputFileInterface&& other) = delete;
	ImformatOutputFileInterface& operator=(ImformatOutputFileInterface&& other) = delete;

	virtual mex::MxString getFileName() const = 0;
	virtual int getHeight() const = 0;
	virtual int getWidth() const = 0;
	virtual void setAttribute(const mex::MxString& attributeName,
							const mex::MxArray& attribute) = 0;
	virtual void setAttribute(const mex::MxStruct& attributes) = 0;
	virtual void writeData(const mex::MxArray& data) = 0;
	virtual ~ImformatOutputFileInterface() = default;
};

}  // namespace imformat

#endif /* IMFORMAT_MEX_H_ */
