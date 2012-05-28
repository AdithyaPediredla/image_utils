/*
 * ImfExtraAttributes.h
 *
 *  Created on: May 27, 2012
 *      Author: igkiou
 */

#ifndef IMFEXTRAATTRIBUTES_H_
#define IMFEXTRAATTRIBUTES_H_

#include <ImfHeader.h>
#include <ImfFloatAttribute.h>
#include <ImfStringAttribute.h>
#include <ImfChromaticitiesAttribute.h>
#include <ImfEnvmapAttribute.h>
#include <ImfKeyCodeAttribute.h>
#include <ImfTimeCodeAttribute.h>
#include <ImfRationalAttribute.h>
#include <ImfVecAttribute.h>
//#include <ImfVectorAttribute.h>

#define IMF_EXTRA_ATTRIBUTE_DEF(name,suffix,type)				      \
									      \
    void			 add##suffix (Header &header, const type &v); \
    bool			 has##suffix (const Header &header);	      \
    const TypedAttribute<type> & name##Attribute (const Header &header);      \
    TypedAttribute<type> &	 name##Attribute (Header &header);	      \
    const type &		 name (const Header &header);		      \
    type &			 name (Header &header);


namespace Imf {

IMF_EXTRA_ATTRIBUTE_DEF (gain, Gain, float)
IMF_EXTRA_ATTRIBUTE_DEF (wavelength, Wavelength, float)

//IMF_EXTRA_ATTRIBUTE_DEF (apertures, Apertures, std::vector<float>)
//IMF_EXTRA_ATTRIBUTE_DEF (expTimes, ExpTimes, std::vector<float>)
//IMF_EXTRA_ATTRIBUTE_DEF (gains, Gains, std::vector<float>)

IMF_EXTRA_ATTRIBUTE_DEF (extTube, ExtTube, std::string)
IMF_EXTRA_ATTRIBUTE_DEF (lens, Lens, std::string)
IMF_EXTRA_ATTRIBUTE_DEF (material, Material, std::string)

} // namespace Imf

#endif /* IMFEXTRAATTRIBUTES_H_ */