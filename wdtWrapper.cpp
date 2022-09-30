//
//  wdtWrapper.cpp
//  wdtFw
//
//  Created by Gevorg Hmayakyan on 08.09.22.
//


#include <string>
#include "wdtWrapper.hpp"
#include <wdt/Receiver.h>
#include <wdt/Wdt.h>
#include <wdt/WdtResourceController.h>
#include <wdt/WdtTransferRequest.h>
#include <wdt/Reporting.h>
#include <folly/String.h>
#include <gflags/gflags.h>
#include <glog/logging.h>
#include <signal.h>
#include <chrono>
#include <fstream>
#include <future>
#include <iostream>
#include <thread>
facebook::wdt::SenderPtr *ptr = NULL;
int initializeWdt(const char* url, const char *dir) {
    facebook::wdt::Wdt &wdt = facebook::wdt::Wdt::initializeWdt("wdtWrapper");
    std::unique_ptr<facebook::wdt::WdtTransferRequest> reqPtr =
    std::make_unique<facebook::wdt::WdtTransferRequest>(url);
    reqPtr->directory = dir;
    facebook::wdt::WdtTransferRequest &req = *reqPtr;
    int retCode = wdt.wdtSend(req, &ptr);
    return retCode;
}

double getProgress() {
    if(NULL != ptr) {
        std::unique_ptr<facebook::wdt::TransferReport> transfer = (*ptr)->getTransferReport();
        long total = transfer->getTotalFileSize();
        long current = transfer->getSummary().getEffectiveDataBytes();
        double progress = (double)current * 100.0/(double)total;
        return progress;
    }
    return -1.0;
}


