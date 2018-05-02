////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_top_module_hierarchy_H
#define H_Work_top_module_hierarchy_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_top_module_hierarchy: public HSim__s6 {
public:

    HSim__s1 SE[3];

    HSim__s1 SA[5];
    Work_top_module_hierarchy(const char * name);
    ~Work_top_module_hierarchy();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_top_module_hierarchy(const char *name);

#endif
