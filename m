Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B8920795
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wirenboard-ru.20150623.gappssmtp.com header.i=@wirenboard-ru.20150623.gappssmtp.com header.b="HdTbBMM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIDQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgIDQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:00:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFBC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:00:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a22so2164336ljp.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnqlNlm15niueNVt3HNm1T5lozYuryfIQXmO/BzyCeU=;
        b=HdTbBMM15ZLCYIpz4BY8lmsAzTVk/Zml7OuQ5Fd2ggF95C2uwHhTWs1gyW3cOcWKDD
         Mfb48uRAKufJ7MNXwRL0IuD3wb5A9AHoaFLnd2TBvsZlJn5m+BNVxhTlAG4Ov0omLgxY
         VPWsTgTP3pY7LqGRJ87x4JQnHGdpuCBOV4ugEuchjbbtCWqzRRGL8iRtcCdG+2kKngV5
         HKPSJ6v4LHE4Gr3PEmtR+azVFmSqfCu8TMnITIeciib4xKSVBrMxoli5IG5TfJ4j7zKE
         lWRM3DgZmNuZdq9Sd0uUN+OdK+uTMbHRLIbgWwb/ts34dT/ekafL+r55Mb3STS7e76ZL
         M/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnqlNlm15niueNVt3HNm1T5lozYuryfIQXmO/BzyCeU=;
        b=oJ9mvo2FLFptRW+Y0/s/mHsf0eQTEZoMaOj06ujD/Jf/9FryNQ6QSdqmlE91xan4YS
         mwAGvFRqrCR9yFszReOSz0kAVF09U5H7JiZhCw7Dgc+7n3o4B//WIbEXsOR8pg3/yfMA
         CHO7hxeTbKYEq2ci5+dvd5fMrDArARy0R8V+bywlbawA/nc4uIC4AnFoAlo3i/bY2vDg
         r0pHtZFMpLCmEJso/iBwK+RNnnetdAv+XWhhGF1AVW3gN+j283Qv1EuXpbWuSjgntlHO
         QeqiQIYjZKb/0gy9D3BP/KLVyPKYy8j9Q0MjM5+ccjd49JokrMffykfwBQGOO8lOQk8+
         yBBw==
X-Gm-Message-State: AOAM531Cs7h7EzjBDBwOP6bVffe3HyebCGsL9go/0hppmAfKfPZjsPMM
        /gKIynR6Xd21xTT8EDHSVrhEvQ==
X-Google-Smtp-Source: ABdhPJzmw+CjMTc8INvYqlyxbTNKkRjqZ2iBhJJi5guUvCQEkWVCHdF3ZHYFaiMymZq7CL5CJOB7bg==
X-Received: by 2002:a05:651c:1073:: with SMTP id y19mr4333354ljm.57.1599235218902;
        Fri, 04 Sep 2020 09:00:18 -0700 (PDT)
Received: from localhost.localdomain ([176.59.72.156])
        by smtp.googlemail.com with ESMTPSA id 68sm1358114ljj.135.2020.09.04.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:00:18 -0700 (PDT)
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Subject: [PATCH 1/2] w1: w1_therm: Add sysfs entries to control conversion time and driver features
Date:   Fri,  4 Sep 2020 19:00:03 +0300
Message-Id: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion time of common DS18B20 clones deviates from
datasheet specs. Allow adjustment and automatic measure of the
conversion time.

Add 'conv_time' sysfs attribute:
  *read*: Current conversion time in milliseconds.
  *write*:
     '0': Set default conversion time.
     '1': Measure and set the conversion time. Make a
          single temperature conversion, poll and measure
          an actual value. Measured value is increased
          by 20% for temperature drift. A new conversion
          time is returned by reading the same attribute.
     other positive value:
        Set the conversion time in milliseconds.

The setting is active until a resolution change. Then it is reset to
default conversion time for a new resolution.

Add 'features' sysfs attribute to control optional driver settings
per device. Bit masks to read/write (logical OR):
  1: Enable check for conversion success. If byte 6 of
     scratchpad memory is 0xC after conversion, and
     temperature reads 85.00 (powerup value) or 127.94
     (insufficient power) - return a conversion error.

  2: Enable poll for conversion completion. Generate read cycles
     after the conversion start and wait for 1's. In parasite
     power mode this feature is not available.

There are some clones of DS18B20 with fixed 12 bit resolution. Make the
driver verify the resolution by reading back the device after resolution
change.

Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
---
 .../ABI/testing/sysfs-driver-w1_therm         |  47 +++
 Documentation/w1/slaves/w1_therm.rst          |  37 +-
 drivers/w1/slaves/w1_therm.c                  | 357 ++++++++++++++++--
 3 files changed, 410 insertions(+), 31 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 9b488c0afdfa..b44b51a88c5e 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -53,6 +53,9 @@ Description:
 			or resolution to set in bit
 			* '-xx': xx is kernel error when reading the resolution
 			* Anything else: do nothing
+		Some DS18B20 clones are fixed in 12-bit resolution, so the
+		actual resolution is read back from the chip and verified. Error
+		is reported if the results differ.
 Users:		any user space application which wants to communicate with
 		w1_term device
 
@@ -114,3 +117,47 @@ Description:
 		of the bulk read command (not the current temperature).
 Users:		any user space application which wants to communicate with
 		w1_term device
+
+
+What:		/sys/bus/w1/devices/.../conv_time
+Date:		July 2020
+Contact:	Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
+Description:
+		(RW) Get, set, or measure a temperature conversion time. The
+		setting remains active until a resolution change. Then it is
+		reset to default (datasheet) conversion time for a new
+		resolution.
+
+		*read*: Actual conversion time in milliseconds. *write*:
+			'0': Set the default conversion time from the datasheet.
+			'1': Measure and set the conversion time. Make a single
+			     temperature conversion, measure an actual value.
+			     Increase it by 20% for temperature range. A new
+			     conversion time can be obtained by reading this
+			     same attribute.
+			other positive value:
+			     Set the conversion time in milliseconds.
+
+Users:		An application using the w1_term device
+
+
+What:		/sys/bus/w1/devices/.../features
+Date:		July 2020
+Contact:	Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
+Description:
+		(RW) Control optional driver settings.
+		Bit masks to read/write (logical OR):
+
+                1: Enable check for conversion success. If byte 6 of
+                   scratchpad memory is 0xC after conversion, and
+                   temperature reads 85.00 (powerup value) or 127.94
+                   (insufficient power) - return a conversion error.
+
+                2: Enable poll for conversion completion. Generate read cycles
+                   after the conversion start and wait for 1's. In parasite
+                   power mode this feature is not available.
+
+		*read*:  Currently selected features, bitwise OR.
+		*write*: Select features, bitwise OR.
+
+Users:		An application using the w1_term device
diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
index cc4edae17751..f1148181f53e 100644
--- a/Documentation/w1/slaves/w1_therm.rst
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -52,6 +52,19 @@ read is sent but one sensor is not read immediately, the next access to
 temperature on this device will return the temperature measured at the
 time of issue of the bulk read command (not the current temperature).
 
+A strong pullup will be applied during the conversion if required.
+
+``conv_time`` sysfs entry is used to get current conversion time (read), and
+adjust it (write). A temperature conversion time depends on the device type and
+it's current resolution. Default conversion time is set by the driver according
+to the device datasheet. A conversion time for many original device clones
+deviate from datasheet specs. There are three options: 1) manually set the
+correct conversion time by writing a value in milliseconds to ``conv_time``; 2)
+auto measure and set a conversion time by writing ``1`` to
+``conv_time``; 3) use ``features`` entry to enable poll for conversion
+completion. Options 2, 3 can't be used in parasite power mode. To get back to
+the default conversion time write ``0`` to ``conv_time``.
+
 Writing a value between 9 and 12 to the sysfs w1_slave file will change the
 precision of the sensor for the next readings. This value is in (volatile)
 SRAM, so it is reset when the sensor gets power-cycled.
@@ -61,11 +74,14 @@ has to be written to the sysfs w1_slave file. Since the EEPROM has a limited
 amount of writes (>50k), this command should be used wisely.
 
 Alternatively, resolution can be set or read (value from 9 to 12) using the
-dedicated resolution sysfs entry on each device. This sysfs entry is not
-present for devices not supporting this feature. Driver will adjust the
-correct conversion time for each device regarding to its resolution setting.
-In particular, strong pullup will be applied if required during the conversion
-duration.
+dedicated resolution sysfs entry on each device. This sysfs entry is not present
+for devices not supporting this feature.
+
+Some non-genuine DS18B20 chips are
+fixed in 12-bit mode only, so the actual resolution is read back from the chip
+and verified by the driver.
+
+Note: Changing the resolution reverts the conversion time to default.
 
 The write-only sysfs entry eeprom is an alternative for EEPROM operations:
   * 'save': will save device RAM to EEPROM
@@ -104,3 +120,14 @@ location of the chip in the 1-wire bus without needing pre-existing
 knowledge of the bus ordering.  Support is provided through the sysfs
 w1_seq file.  The file will contain a single line with an integer value
 representing the device index in the bus starting at 0.
+
+``features`` sysfs entry controls optional driver settings per device.
+Insufficient power in parasite mode, line noise and insufficient conversion time
+may lead to conversion failure. Original DS18B20 and some clones allow for
+detection of invalid conversion. Write bit mask ``1`` to ``features`` to enable
+checking the conversion success. If byte 6 of scratchpad memory is 0xC after
+conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
+power), the driver returns a conversion error. Bit mask ``2`` enables poll for
+conversion completion (normal power only) by generating read cycles on the bus
+after conversion starts. In parasite power mode this feature is not available.
+Feature bit masks may be combined (OR).
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index c1b4eda16719..9b2d96335a70 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/hwmon.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 
 #include <linux/w1.h>
 
@@ -65,6 +66,20 @@ static u16 bulk_read_device_counter; /* =0 as per C standard */
 #define MIN_TEMP	-55	/* min temperature that can be mesured */
 #define MAX_TEMP	125	/* max temperature that can be mesured */
 
+/* Allowed values for sysfs conv_time attribute */
+#define CONV_TIME_DEFAULT 0
+#define CONV_TIME_MEASURE 1
+
+/* Bits in sysfs "features" value */
+#define W1_THERM_CHECK_RESULT 1	/* Enable conversion success check */
+#define W1_THERM_POLL_COMPLETION 2	/* Poll for conversion completion */
+#define W1_THERM_FEATURES_MASK 3		/* All values mask */
+
+/* Poll period in milliseconds. Should be less then a shortest operation on the device */
+#define W1_POLL_PERIOD 32
+#define W1_POLL_CONVERT_TEMP 2000	/* Timeout for W1_CONVERT_TEMP, ms */
+#define W1_POLL_RECALL_EEPROM 500	/* Timeout for W1_RECALL_EEPROM, ms*/
+
 /* Helpers Macros */
 
 /*
@@ -88,6 +103,20 @@ static u16 bulk_read_device_counter; /* =0 as per C standard */
 #define SLAVE_RESOLUTION(sl) \
 	(((struct w1_therm_family_data *)(sl->family_data))->resolution)
 
+/*
+ * return the conv_time_override of the sl slave
+ * always test family data existence before using this macro
+ */
+ #define SLAVE_CONV_TIME_OVERRIDE(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->conv_time_override)
+
+/*
+ * return the features of the sl slave
+ * always test family data existence before using this macro
+ */
+ #define SLAVE_FEATURES(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->features)
+
 /*
  * return whether or not a converT command has been issued to the slave
  * * 0: no bulk read is pending
@@ -136,6 +165,8 @@ struct w1_therm_family_converter {
  *				-x error or undefined
  * @resolution: current device resolution
  * @convert_triggered: conversion state of the device
+ * @conv_time_override: user selected conversion time or CONV_TIME_DEFAULT
+ * @features: bit mask - enable temperature validity check, poll for completion
  * @specific_functions: pointer to struct of device specific function
  */
 struct w1_therm_family_data {
@@ -144,6 +175,8 @@ struct w1_therm_family_data {
 	int external_powered;
 	int resolution;
 	int convert_triggered;
+	int conv_time_override;
+	unsigned int features;
 	struct w1_therm_family_converter *specific_functions;
 };
 
@@ -285,6 +318,19 @@ static ssize_t therm_bulk_read_store(struct device *device,
 static ssize_t therm_bulk_read_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+static ssize_t conv_time_show(struct device *device,
+			      struct device_attribute *attr, char *buf);
+
+static ssize_t conv_time_store(struct device *device,
+			       struct device_attribute *attr, const char *buf,
+			       size_t size);
+
+static ssize_t features_show(struct device *device,
+			      struct device_attribute *attr, char *buf);
+
+static ssize_t features_store(struct device *device,
+			       struct device_attribute *attr, const char *buf,
+			       size_t size);
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
@@ -294,6 +340,8 @@ static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
 static DEVICE_ATTR_RW(alarms);
+static DEVICE_ATTR_RW(conv_time);
+static DEVICE_ATTR_RW(features);
 
 static DEVICE_ATTR_RW(therm_bulk_read); /* attribut at master level */
 
@@ -328,6 +376,8 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
 	&dev_attr_alarms.attr,
+	&dev_attr_conv_time.attr,
+	&dev_attr_features.attr,
 	NULL,
 };
 
@@ -337,6 +387,8 @@ static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
 	&dev_attr_alarms.attr,
+	&dev_attr_conv_time.attr,
+	&dev_attr_features.attr,
 	NULL,
 };
 
@@ -348,6 +400,8 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
 	&dev_attr_alarms.attr,
+	&dev_attr_conv_time.attr,
+	&dev_attr_features.attr,
 	NULL,
 };
 
@@ -466,7 +520,10 @@ static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
 	if (!sl->family_data)
 		return -ENODEV;	/* device unknown */
 
-	/* return time in ms for conversion operation */
+	if (SLAVE_CONV_TIME_OVERRIDE(sl) != CONV_TIME_DEFAULT)
+		return SLAVE_CONV_TIME_OVERRIDE(sl);
+
+	/* Return the conversion time from datasheet, depending on resolution */
 	switch (SLAVE_RESOLUTION(sl)) {
 	case 9:
 		ret = 95;
@@ -486,8 +543,13 @@ static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
 
 static inline int w1_DS18S20_convert_time(struct w1_slave *sl)
 {
-	(void)(sl);
-	return 750; /* always 750ms for DS18S20 */
+	if (!sl->family_data)
+		return -ENODEV;	/* device unknown */
+
+	if (SLAVE_CONV_TIME_OVERRIDE(sl) == CONV_TIME_DEFAULT)
+		return 750; /* default for DS18S20 */
+	else
+		return SLAVE_CONV_TIME_OVERRIDE(sl);
 }
 
 static inline int w1_DS18B20_write_data(struct w1_slave *sl,
@@ -507,7 +569,7 @@ static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
 {
 	int ret;
 	u8 new_config_register[3];	/* array of data to be written */
-	struct therm_info info;
+	struct therm_info info, info2;
 
 	/* resolution of DS18B20 is in the range [9..12] bits */
 	if (val < 9 || val > 12)
@@ -532,8 +594,18 @@ static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
 
 	/* Write data in the device RAM */
 	ret = w1_DS18B20_write_data(sl, new_config_register);
+	if (ret)
+		return ret;
 
-	return ret;
+	/* Some DS18B20 clones don't support resolution change, read back to verify */
+	ret = read_scratchpad(sl, &info2);
+	if (ret)
+		return ret;
+
+	if ((info2.rom[4] & 0x9F) == (info.rom[4] & 0x9F))
+		return 0;
+	else
+		return -EIO;
 }
 
 static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
@@ -699,6 +771,22 @@ static inline bool bus_mutex_lock(struct mutex *lock)
 	return true;
 }
 
+/**
+ * check_family_data() - Check if family data and specific functions are present
+ * @sl: W1 device data
+ *
+ * Return: 0 - OK, negative value - error
+ */
+static int check_family_data(struct w1_slave *sl)
+{
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(&sl->dev,
+			 "%s: Device is not supported by the driver\n", __func__);
+		return -EINVAL;  /* No device family */
+	}
+	return 0;
+}
+
 /**
  * support_bulk_read() - check if slave support bulk read
  * @sl: device to check the ability
@@ -883,6 +971,34 @@ static int reset_select_slave(struct w1_slave *sl)
 	return 0;
 }
 
+/**
+ * w1_poll_completion - Poll for operation completion, with timeout
+ * @dev_master: the device master of the bus
+ * @tout_ms: timeout in milliseconds
+ *
+ * The device is answering 0's while an operation is in progress and 1's after it completes
+ * Timeout may happen if the previous command was not recognised due to a line noise
+ *
+ * Return: 0 - OK, negative error - timeout
+ */
+int w1_poll_completion(struct w1_master *dev_master, int tout_ms)
+{
+	int i;
+
+	for (i = 0; i < tout_ms/W1_POLL_PERIOD; i++) {
+		/* Delay is before poll, for device to recognize a command */
+		msleep(W1_POLL_PERIOD);
+
+		/* Compare all 8 bits to mitigate a noise on the bus */
+		if (w1_read_8(dev_master) == 0xFF)
+			break;
+	}
+	if (i == tout_ms/W1_POLL_PERIOD)
+		return -EIO;
+
+	return 0;
+}
+
 static int convert_t(struct w1_slave *sl, struct therm_info *info)
 {
 	struct w1_master *dev_master = sl->master;
@@ -898,6 +1014,13 @@ static int convert_t(struct w1_slave *sl, struct therm_info *info)
 					(!SLAVE_POWERMODE(sl) &&
 					w1_strong_pullup));
 
+	if (strong_pullup && SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
+		dev_warn(&sl->dev,
+			"%s: Disabling W1_THERM_POLL_COMPLETION in parasite power mode.\n",
+			__func__);
+		SLAVE_FEATURES(sl) &= ~W1_THERM_POLL_COMPLETION;
+	}
+
 	/* get conversion duration device and id dependent */
 	t_conv = conversion_time(sl);
 
@@ -933,15 +1056,38 @@ static int convert_t(struct w1_slave *sl, struct therm_info *info)
 				}
 				mutex_unlock(&dev_master->bus_mutex);
 			} else { /*no device need pullup */
-				mutex_unlock(&dev_master->bus_mutex);
-
-				sleep_rem = msleep_interruptible(t_conv);
-				if (sleep_rem != 0) {
-					ret = -EINTR;
-					goto dec_refcnt;
+				if (SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
+					ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
+					if (ret) {
+						dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
+						goto mt_unlock;
+					}
+					mutex_unlock(&dev_master->bus_mutex);
+				} else {
+					/* Fixed delay */
+					mutex_unlock(&dev_master->bus_mutex);
+					sleep_rem = msleep_interruptible(t_conv);
+					if (sleep_rem != 0) {
+						ret = -EINTR;
+						goto dec_refcnt;
+					}
 				}
 			}
 			ret = read_scratchpad(sl, info);
+
+			/* If enabled, check for conversion success */
+			if ((SLAVE_FEATURES(sl) & W1_THERM_CHECK_RESULT) &&
+				(info->rom[6] == 0xC) &&
+				((info->rom[1] == 0x5 && info->rom[0] == 0x50) ||
+				(info->rom[1] == 0x7 && info->rom[0] == 0xFF))
+			) {
+				/* Invalid reading (scratchpad byte 6 = 0xC)
+				 * due to insufficient conversion time
+				 * or power failure.
+				 */
+				ret = -EIO;
+			}
+
 			goto dec_refcnt;
 		}
 
@@ -955,6 +1101,76 @@ static int convert_t(struct w1_slave *sl, struct therm_info *info)
 	return ret;
 }
 
+static int conv_time_measure(struct w1_slave *sl, int *conv_time)
+{
+	struct therm_info inf,
+		*info = &inf;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
+	bool strong_pullup;
+
+	if (!sl->family_data)
+		goto error;
+
+	strong_pullup = (w1_strong_pullup == 2 ||
+		(!SLAVE_POWERMODE(sl) &&
+		w1_strong_pullup));
+
+	if (strong_pullup) {
+		pr_info("%s: Measure with strong_pullup is not supported.\n", __func__);
+		return -EINVAL;
+	}
+
+	memset(info->rom, 0, sizeof(info->rom));
+
+	/* prevent the slave from going away in sleep */
+	atomic_inc(THERM_REFCNT(sl->family_data));
+
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	/* Didn't acquire the mutex */
+		goto dec_refcnt;
+	}
+
+	while (max_trying-- && ret) { /* ret should be 0 */
+		info->verdict = 0;
+		info->crc = 0;
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			int j_start, j_end;
+
+			/*no device need pullup */
+			w1_write_8(dev_master, W1_CONVERT_TEMP);
+
+			j_start = jiffies;
+			ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
+			if (ret) {
+				dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
+				goto mt_unlock;
+			}
+			j_end = jiffies;
+			/* 1.2x increase for variation and changes over temperature range */
+			*conv_time = jiffies_to_msecs(j_end-j_start)*12/10;
+			pr_debug("W1 Measure complete, conv_time = %d, HZ=%d.\n",
+				*conv_time, HZ);
+			if (*conv_time <= CONV_TIME_MEASURE) {
+				ret = -EIO;
+				goto mt_unlock;
+			}
+			mutex_unlock(&dev_master->bus_mutex);
+			ret = read_scratchpad(sl, info);
+			goto dec_refcnt;
+		}
+
+	}
+mt_unlock:
+	mutex_unlock(&dev_master->bus_mutex);
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
+
 static int read_scratchpad(struct w1_slave *sl, struct therm_info *info)
 {
 	struct w1_master *dev_master = sl->master;
@@ -1118,10 +1334,7 @@ static int recall_eeprom(struct w1_slave *sl)
 		if (!reset_select_slave(sl)) {
 
 			w1_write_8(dev_master, W1_RECALL_EEPROM);
-
-			ret = 1; /* Slave will pull line to 0 */
-			while (ret)
-				ret = 1 - w1_touch_bit(dev_master, 1);
+			ret = w1_poll_completion(dev_master, W1_POLL_RECALL_EEPROM);
 		}
 
 	}
@@ -1345,11 +1558,13 @@ static ssize_t w1_slave_store(struct device *device,
 	}
 
 	if (ret) {
-		dev_info(device,
-			"%s: writing error %d\n", __func__, ret);
-		/* return size to avoid call back again */
-	} else
-		SLAVE_RESOLUTION(sl) = val;
+		dev_warn(device, "%s: Set resolution - error %d\n", __func__, ret);
+		/* Propagate error to userspace */
+		return ret;
+	}
+	SLAVE_RESOLUTION(sl) = val;
+	/* Reset the conversion time to default - it depends on resolution */
+	SLAVE_CONV_TIME_OVERRIDE(sl) = CONV_TIME_DEFAULT;
 
 	return size; /* always return size to avoid infinite calling */
 }
@@ -1465,12 +1680,12 @@ static ssize_t resolution_store(struct device *device,
 	/* get the correct function depending on the device */
 	ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
 
-	if (ret) {
-		dev_info(device,
-			"%s: writing error %d\n", __func__, ret);
-		/* return size to avoid call back again */
-	} else
-		SLAVE_RESOLUTION(sl) = val;
+	if (ret)
+		return ret;
+
+	SLAVE_RESOLUTION(sl) = val;
+	/* Reset the conversion time to default because it depends on resolution */
+	SLAVE_CONV_TIME_OVERRIDE(sl) = CONV_TIME_DEFAULT;
 
 	return size;
 }
@@ -1660,6 +1875,96 @@ static ssize_t therm_bulk_read_show(struct device *device,
 	return sprintf(buf, "%d\n", ret);
 }
 
+static ssize_t conv_time_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device is not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+	return sprintf(buf, "%d\n", conversion_time(sl));
+}
+
+static ssize_t conv_time_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	int val, ret = 0;
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	if (kstrtoint(buf, 10, &val)) /* converting user entry to int */
+		return -EINVAL;
+
+	if (check_family_data(sl))
+		return -ENODEV;
+
+	if (val != CONV_TIME_MEASURE) {
+		if (val >= CONV_TIME_DEFAULT)
+			SLAVE_CONV_TIME_OVERRIDE(sl) = val;
+		else
+			return -EINVAL;
+
+	} else {
+		int conv_time;
+
+		ret = conv_time_measure(sl, &conv_time);
+		if (ret)
+			return -EIO;
+		SLAVE_CONV_TIME_OVERRIDE(sl) = conv_time;
+	}
+	return size;
+}
+
+static ssize_t features_show(struct device *device,
+			     struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			 "%s: Device not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+	return sprintf(buf, "%u\n", SLAVE_FEATURES(sl));
+}
+
+static ssize_t features_store(struct device *device,
+			      struct device_attribute *attr, const char *buf, size_t size)
+{
+	int val, ret = 0;
+	bool strong_pullup;
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	ret = kstrtouint(buf, 10, &val); /* converting user entry to int */
+	if (ret)
+		return -EINVAL;  /* invalid number */
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device, "%s: Device not supported by the driver\n", __func__);
+		return -ENODEV;
+	}
+
+	if ((val & W1_THERM_FEATURES_MASK) != val)
+		return -EINVAL;
+
+	SLAVE_FEATURES(sl) = val;
+
+	strong_pullup = (w1_strong_pullup == 2 ||
+			 (!SLAVE_POWERMODE(sl) &&
+			  w1_strong_pullup));
+
+	if (strong_pullup && SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
+		dev_warn(&sl->dev,
+			 "%s: W1_THERM_POLL_COMPLETION disabled in parasite power mode.\n",
+			 __func__);
+		SLAVE_FEATURES(sl) &= ~W1_THERM_POLL_COMPLETION;
+	}
+
+	return size;
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
-- 
2.25.1

