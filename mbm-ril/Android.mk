#########################################################################
# Copyright (C) ST-Ericsson AB 2008-2014
# Copyright 2006 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#########################################################################
# Determine android version based on API (PLATFORM_SDK_VERSION)
# API Level 14 Android 4.0 to 4.0.2 Ice Cream Sandwich
# API Level 15 Android 4.0.3 to 4.0.4 Ice Cream Sandwich
# API Level 16 Android 4.1 Jelly Bean
# API Level 17 Android 4.2 Jelly Bean
# API Level 18 Android 4.3 Jelly Bean
# API Level 19 Android 4.4 KitKat
#########################################################################

API_ICS:= 14 15
API_JB:= 16
API_KK:= 19
#
# Only KitKat (19) supported in this version
#
API_SUPPORTED:= $(API_KK)
#
# Check if supported
ifeq "$(findstring $(PLATFORM_SDK_VERSION),$(API_SUPPORTED))" ""
  $(error MBM: Unsupported Android version; $(PLATFORM_SDK_VERSION))
endif

# If supported Ice Cream Sandwich API
ifneq "$(findstring $(PLATFORM_SDK_VERSION), $(API_ICS))" ""
  MBM_ICS := true
  LOCAL_CFLAGS += -DMBM_ICS
  $(warning MBM: Ice Cream Sandwich is set: $(MBM_ICS))
endif

# If supported Jelly Bean API
ifneq "$(findstring $(PLATFORM_SDK_VERSION), $(API_JB))" ""
  MBM_JB := true
  LOCAL_CFLAGS += -DMBM_JB
  $(warning MBM: Jelly Bean is set: $(MBM_JB))
endif

# If supported KitKat API
ifneq "$(findstring $(PLATFORM_SDK_VERSION), $(API_KK))" ""
  MBM_KK := true
  LOCAL_CFLAGS += -DMBM_KK
  $(warning MBM: Kit Kat is set: $(MBM_KK))
endif

#########################################################################
# Build MBM RIL implementation: libmbm-ril
# Based on reference-ril
# Modified for ST-Ericsson U300 modems.
# Author: Christian Bejram <christian.bejram@stericsson.com>
#########################################################################

ifeq ($(strip $(BOARD_USES_MBM_RIL)),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= libmbm-ril
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES:= \
    u300-ril.c \
    u300-ril-config.h \
    u300-ril-messaging.c \
    u300-ril-messaging.h \
    u300-ril-network.c \
    u300-ril-network.h \
    u300-ril-pdp.c \
    u300-ril-pdp.h \
    u300-ril-requestdatahandler.c \
    u300-ril-requestdatahandler.h \
    u300-ril-device.c \
    u300-ril-device.h \
    u300-ril-sim.c \
    u300-ril-sim.h \
    u300-ril-oem.c \
    u300-ril-oem.h \
    u300-ril-error.c \
    u300-ril-error.h \
    u300-ril-stk.c \
    u300-ril-stk.h \
    atchannel.c \
    atchannel.h \
    misc.c \
    misc.h \
    fcp_parser.c \
    fcp_parser.h \
    at_tok.c \
    at_tok.h \
    net-utils.c \
    net-utils.h

LOCAL_SHARED_LIBRARIES := \
    libcutils libutils libril
# libnetutils

# For asprinf
LOCAL_CFLAGS := -D_GNU_SOURCE

LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(TOP)/hardware/ril/libril/

# Disable prelink, or add to build/core/prelink-linux-arm.map
LOCAL_PRELINK_MODULE := false

# Build shared library
LOCAL_SHARED_LIBRARIES += \
    libcutils libutils
LOCAL_LDLIBS += -lpthread
LOCAL_LDLIBS += -lrt
LOCAL_CFLAGS += -DRIL_SHLIB
LOCAL_CFLAGS += -Wall
include $(BUILD_SHARED_LIBRARY)

endif
