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
# Build MBM GPS implementation: gps.$(TARGET_DEVICE)
#########################################################################

ifeq ($(strip $(BOARD_USES_MBM_GPS)),true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := gps.$(TARGET_DEVICE)
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	src/mbm_gps.c \
	src/nmea_reader.h \
	src/nmea_reader.c \
	src/nmea_tokenizer.h \
	src/nmea_tokenizer.c \
	src/gpsctrl/gps_ctrl.c \
	src/gpsctrl/gps_ctrl.h \
	src/gpsctrl/atchannel.c \
	src/gpsctrl/atchannel.h \
	src/gpsctrl/at_tok.c \
	src/gpsctrl/at_tok.h \
	src/gpsctrl/nmeachannel.c \
	src/gpsctrl/nmeachannel.h \
	src/gpsctrl/supl.c \
	src/gpsctrl/supl.h \
	src/gpsctrl/pgps.c \
	src/gpsctrl/pgps.h \
	src/mbm_service_handler.c \
	src/mbm_service_handler.h \
	src/gpsctrl/misc.c \
	src/gpsctrl/misc.h

LOCAL_SHARED_LIBRARIES := \
	libutils \
	libcutils \
	libdl \
	libc

LOCAL_CFLAGS := -Wall -Wextra
#LOCAL_CFLAGS += -DLOG_NDEBUG=0
#LOCAL_CFLAGS += -DSINGLE_SHOT

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

include $(BUILD_SHARED_LIBRARY)

endif
