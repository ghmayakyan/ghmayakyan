//
//  wdtWrapper.hpp
//  wdtFw
//
//  Created by Gevorg Hmayakyan on 08.09.22.
//

#ifndef wdtWrapper_hpp
#define wdtWrapper_hpp

#include <stdio.h>


__BEGIN_DECLS
    int initializeWdt(const char* url, const char* dir);
    double getProgress();
__END_DECLS
#endif /* wdtWrapper_hpp */
