Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48348C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8EA20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK4Zhc5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgDNRDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728549AbgDNRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:03:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:03:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c195so12964992wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DG+G/RDFf8r13xaXpiH3ZYncoYxc1Ve079jcKy4ITdQ=;
        b=EK4Zhc5w0jtL8rqNeVgK6Ej8/m2TkrR6J4FPYNp7XHW0h/7h1i/uQKqsVJ7rutF3Xx
         xeUeodRtYEowNPkwId4D/vCPDeDSsI56LDpdNsbkdIVTsO2WqlAik3cCCVvg4g5zC065
         fRJH27LvVI/+dBLZSI3ZKvN12kuTtvOmqQEj/x69PHmCRjIZNmF8l303lhdYqGRQqn4l
         J/a8D7+jX9D1+m3qUOwNB+a4XhfWTgf6ej9C9GptiWznBBCGNJM3O7MDnJs9TfoX+MHi
         U3p/Ye1SgD9dDIw4g2dXM5oIcRZpTv8tDMgzR5V+xgY/uYfSLEc48u8gin/AoI68KcFN
         uE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DG+G/RDFf8r13xaXpiH3ZYncoYxc1Ve079jcKy4ITdQ=;
        b=N6F1aXDZ3HIyIBOmgEJeEkGWvEwH2FTx7hR4CjmF7s9Hn0D3FEjYrctWpUqL23XLZo
         53youNnA4rEKVFLW2Hi0hh0KYYNN31GhTSh1emES5KCQtlPgydt7lVriHh5gFspONre4
         4arovQeJ7F3TZ2jQAjg2u8pYGj0eRr3wH39HelePZohpA/4i0yHFRNEvZz+iZYoxhxzz
         W4mcwbayBhrYOJsL/7YEE7ZSizLJhWGFLWVU7Y53jUA3LremxTcFHOgF5NHBRdOemrqN
         8H+FUfASuUroBfGTVHmIuFjv2G/909om0AdGGJxZVZfo/R6BJDccOjSJrNDHpmSmZTXM
         wZPw==
X-Gm-Message-State: AGi0PuZMLALE6YBDCNpvgv+BsJ+yOPRzQ4C4m24z4lu3egwMDD7miaZk
        Prn7KEQleo64E2uRyDgB98o=
X-Google-Smtp-Source: APiQypLNJcfB/V5DeHqgVszBXtRuHIWziS32VCfin+y4vMhDcIV+teVUyWi/cay6qjxIE+dvXEN1gA==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr792377wmd.90.1586883809123;
        Tue, 14 Apr 2020 10:03:29 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id h2sm1264860wro.9.2020.04.14.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:03:27 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Cc:     akira215corp@gmail.com
Subject: [PATCH] Changes in w1_therm.c and adding w1_therm.h
Date:   Tue, 14 Apr 2020 19:02:48 +0200
Message-Id: <20200414170248.299534-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akira SHIMAHARA <akira215corp@gmail.com>

Patch for enhacement of w1_therm module. Added features :
 - Bulk read : send one command for all the slaves 
 		on the bus to trigger temperature conversion
 - Optimized conversion time regarding to device resolution
 - Dedicated sysfs entry for powering read,
 		resolution set/get, eeprom save/restore
 - Alarms settings and reading
 - Code optimization to mitigate bus traffic
 		(devices information are stored to avoid
		interrogating each device every-time)

Following sysfs entry are added :
 - temperature (RO) : return the temperature in 1/1000°
 - ext_power (RO) : return the power status of the device
 - resolution (RW) : get or set the device resolution (supported devices)
 - eeprom (WO) :trigger a save or restore to/from device EEPROM
 - alarms (RW) : read or write TH and TL in the device RAM
 - therm_bulk_read (RW) : Attribute at master level to trigger 
 		bulk read and to survey the progress of devices conversions
 - w1_slave has been kept for compatibility

Main motivation was to improve temperature reading speed, which depend
on resolution settings of devices. The module store the powwer status and
the resolution of each device so that during reading operation, no
transaction is required on the bus, which improve speed.
The harware status is checked as soon as a new device is detected, 
when a user change occured, or when the corresponding sys file is 
accessed by user.

The bulk read allow to trigger convserion of all devices on the bus at
the same time. It will apply a strong pull up on the line if at least
one device required it. The duration of the pull up is the max time
required by a device on the line.

Please let me know any feedback you have on this patch.

Thanks ahead,

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 drivers/w1/slaves/w1_therm.c | 1406 ++++++++++++++++++++++++++--------
 drivers/w1/slaves/w1_therm.h |  386 ++++++++++
 2 files changed, 1470 insertions(+), 322 deletions(-)
 create mode 100644 drivers/w1/slaves/w1_therm.h

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index e028e00927991..743735948b5c5 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -5,19 +5,16 @@
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
  */
 
-#include <asm/types.h>
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
-#include <linux/device.h>
-#include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/hwmon.h>
+#include <linux/string.h>
 
-#include <linux/w1.h>
+#include "w1_therm.h"
 
 #define W1_THERM_DS18S20	0x10
 #define W1_THERM_DS1822		0x22
@@ -41,69 +38,95 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
-struct w1_therm_family_data {
-	uint8_t rom[9];
-	atomic_t refcnt;
-};
-
-struct therm_info {
-	u8 rom[9];
-	u8 crc;
-	u8 verdict;
-};
-
-/* return the address of the refcnt in the family data */
-#define THERM_REFCNT(family_data) \
-	(&((struct w1_therm_family_data *)family_data)->refcnt)
-
-static int w1_therm_add_slave(struct w1_slave *sl)
-{
-	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
-		GFP_KERNEL);
-	if (!sl->family_data)
-		return -ENOMEM;
-	atomic_set(THERM_REFCNT(sl->family_data), 1);
-	return 0;
-}
-
-static void w1_therm_remove_slave(struct w1_slave *sl)
-{
-	int refcnt = atomic_sub_return(1, THERM_REFCNT(sl->family_data));
-
-	while (refcnt) {
-		msleep(1000);
-		refcnt = atomic_read(THERM_REFCNT(sl->family_data));
-	}
-	kfree(sl->family_data);
-	sl->family_data = NULL;
-}
-
-static ssize_t w1_slave_show(struct device *device,
-	struct device_attribute *attr, char *buf);
-
-static ssize_t w1_slave_store(struct device *device,
-	struct device_attribute *attr, const char *buf, size_t size);
-
-static ssize_t w1_seq_show(struct device *device,
-	struct device_attribute *attr, char *buf);
+/*
+ * sysfile interface:
+ * w1_slave (RW) : Old driver way, kept for compatibility
+ *	read :
+ *		return 2 lines with the hexa output of the device
+ *		return the CRC check
+ *		return temperature in 1/1000°
+ *	write :
+ *		.0 :save the 2 or 3 bytes to the device EEPROM
+ *			(i.e. TH, TL and config register)
+ *		.9..12: set the device resolution in RAM (if supported)
+ *		.Else : do nothing
+ *
+ * temperature (RO):
+ *	. temperature in 1/1000°
+ *
+ * ext_power (RO):
+ *	. -xx : xx is kernel error refer to /usr/include/asm/errno.h
+ *	. 0 : device parasite powered
+ *	. 1 : device externally powered
+ *
+ * resolution (RW):
+ *	. -xx	: xx is kernel error refer to /usr/include/asm/errno.h
+ *	. 9..12	: resolution set in bit (or resolution to set in bit)
+ *
+ * eeprom (WO): be aware that eeprom writing cycles count is limited
+ *	. 'save'	:	save device RAM to EEPROM
+ *	. 'restore'	:	restore EEPROM data in device RAM
+ *				(device do that automatically on power-up)
+ *
+ * therm_bulk_read (RW): Attribute at master level
+ *	. 'trigger' : trigger a bulk read on all supporting device on the bus
+ *  read value:
+ *	. -1 : conversion is in progress in 1 or more sensor
+ *	.  1 : conversion complete but at least one sensor has not been read
+ *	.  0 : no bulk operation. Reading temp will trigger a conversion
+ * caveat : if a bulk read is sent but one sensor is not read immediately,
+ *	the next access to temperature will return the temperature measured
+ *	at the time of issue of the bulk read command
+ *
+ * alarms (RW) : read TH and TL (Temperature High an Low) alarms
+ *	Values shall be space separated and in the device range
+ *	(typically -55° to 125°)
+ *	Values are integer are they are store in a 8bit field in the device
+ *	Lowest value is automatically put to TL
+ *
+ */
 
-static DEVICE_ATTR_RW(w1_slave);
-static DEVICE_ATTR_RO(w1_seq);
+/*
+ * struct attribute for each device type
+ * This will enable entry in sysfs, it should match device capability
+ */
 
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
+	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
+	NULL,
+};
+
+static struct attribute *w1_ds18s20_attrs[] = {
+	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
+	&dev_attr_ext_power.attr,
+	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
+	&dev_attr_temperature.attr,
+	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
+/*------------------------------attribute groups----------------------------*/
 ATTRIBUTE_GROUPS(w1_therm);
+ATTRIBUTE_GROUPS(w1_ds18s20);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *dev, u32 attr, int channel,
 			long *val);
@@ -154,23 +177,32 @@ static const struct hwmon_chip_info w1_chip_info = {
 #define W1_CHIPINFO	NULL
 #endif
 
+/*------------------------------family operations---------------------------*/
 static struct w1_family_ops w1_therm_fops = {
-	.add_slave	= w1_therm_add_slave,
+	.add_slave		= w1_therm_add_slave,
+	.remove_slave	= w1_therm_remove_slave,
+	.groups			= w1_therm_groups,
+	.chip_info		= W1_CHIPINFO,
+};
+
+static struct w1_family_ops w1_ds18s20_fops = {
+	.add_slave		= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
-	.groups		= w1_therm_groups,
-	.chip_info	= W1_CHIPINFO,
+	.groups			= w1_ds18s20_groups,
+	.chip_info		= W1_CHIPINFO,
 };
 
 static struct w1_family_ops w1_ds28ea00_fops = {
-	.add_slave	= w1_therm_add_slave,
+	.add_slave		= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
-	.groups		= w1_ds28ea00_groups,
-	.chip_info	= W1_CHIPINFO,
+	.groups			= w1_ds28ea00_groups,
+	.chip_info		= W1_CHIPINFO,
 };
 
+/*--------------------family binding on operations struct-------------------*/
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
-	.fops = &w1_therm_fops,
+	.fops = &w1_ds18s20_fops,
 };
 
 static struct w1_family w1_therm_family_DS18B20 = {
@@ -193,377 +225,741 @@ static struct w1_family w1_therm_family_DS1825 = {
 	.fops = &w1_therm_fops,
 };
 
-struct w1_therm_family_converter {
-	u8			broken;
-	u16			reserved;
-	struct w1_family	*f;
-	int			(*convert)(u8 rom[9]);
-	int			(*precision)(struct device *device, int val);
-	int			(*eeprom)(struct device *device);
-};
-
-/* write configuration to eeprom */
-static inline int w1_therm_eeprom(struct device *device);
-
-/* Set precision for conversion */
-static inline int w1_DS18B20_precision(struct device *device, int val);
-static inline int w1_DS18S20_precision(struct device *device, int val);
-
-/* The return value is millidegrees Centigrade. */
-static inline int w1_DS18B20_convert_temp(u8 rom[9]);
-static inline int w1_DS18S20_convert_temp(u8 rom[9]);
+/*----------------------Device capability description-----------------------*/
 
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
-		.f		= &w1_therm_family_DS18S20,
-		.convert	= w1_DS18S20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f				= &w1_therm_family_DS18S20,
+		.convert		= w1_DS18S20_convert_temp,
+		.get_conversion_time	= w1_DS18S20_convert_time,
+		.set_resolution	= NULL,	// no config register
+		.get_resolution	= NULL,	// no config register
+		.write_data		= w1_DS18S20_write_data,
+		.bulk_read		= true
 	},
 	{
-		.f		= &w1_therm_family_DS1822,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f				= &w1_therm_family_DS1822,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.bulk_read		= true
 	},
 	{
-		.f		= &w1_therm_family_DS18B20,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18B20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f				= &w1_therm_family_DS18B20,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.bulk_read		= true
 	},
 	{
-		.f		= &w1_therm_family_DS28EA00,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f				= &w1_therm_family_DS28EA00,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.bulk_read		= false
 	},
 	{
-		.f		= &w1_therm_family_DS1825,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f				= &w1_therm_family_DS1825,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.bulk_read		= true
 	}
 };
 
-static inline int w1_therm_eeprom(struct device *device)
+/*------------------------ Device dependent func---------------------------*/
+
+static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
 {
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	int ret;
 
-	if (!sl->family_data) {
-		ret = -ENODEV;
-		goto error;
+	if (!sl->family_data)
+		return -ENODEV;	/* device unknown */
+
+	/* return time in ms for conversion operation */
+	switch (SLAVE_RESOLUTION(sl)) {
+	case 9:
+		ret = 95;
+		break;
+	case 10:
+		ret = 190;
+		break;
+	case 11:
+		ret = 375;
+		break;
+	case 12:
+	default:
+		ret = 750;
 	}
+	return ret;
+}
 
-	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+static inline int w1_DS18S20_convert_time(struct w1_slave *sl)
+{
+	(void)(sl);
+	return 750; /* always 750ms for DS18S20 */
+}
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
-		goto dec_refcnt;
+static inline int w1_DS18B20_write_data(struct w1_slave *sl,
+				const u8 *data)
+{
+	return write_scratchpad(sl, data, 3);
+}
 
-	memset(rom, 0, sizeof(rom));
+static inline int w1_DS18S20_write_data(struct w1_slave *sl,
+				const u8 *data)
+{
+	/* No config register */
+	return write_scratchpad(sl, data, 2);
+}
 
-	while (max_trying--) {
-		if (!w1_reset_select_slave(sl)) {
-			unsigned int tm = 10;
-			unsigned long sleep_rem;
+static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
+{
+	int ret = -ENODEV;
+	u8 new_config_register[3];	/* array of data to be written */
+	struct therm_info info;
+
+	/* resolution of DS18B20 is in the range [9..12] bits */
+	if (val < 9 || val > 12)
+		return -EINVAL;
+
+	val -= 9; /* soustract 9 the lowest resolution in bit */
+	val = (val << 5); /* shift to position bit 5 & bit 6 */
+
+	/* Read the scratchpad to change only the required bits
+	 * (bit5 & bit 6 from byte 4)
+	 */
+	ret = read_scratchpad(sl, &info);
+	if (!ret) {
+		new_config_register[0] = info.rom[2];
+		new_config_register[1] = info.rom[3];
+		/* config register is byte 4 & mask 0b10011111*/
+		new_config_register[2] = (info.rom[4] & 0x9F) |
+					(u8) val;
+	} else
+		return ret;
+
+	/* Write data in the device RAM */
+	ret = w1_DS18B20_write_data(sl, new_config_register);
+
+	return ret;
+}
+
+static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
+{
+	int ret = -ENODEV;
+	u8 config_register;
+	struct therm_info info;
+
+	ret = read_scratchpad(sl, &info);
+
+	if (!ret)	{
+		config_register = info.rom[4]; // config register is byte 4
+		config_register &= 0x60; // 0b01100000 keep only bit 5 & 6
+		config_register = (config_register >> 5);	// shift
+		config_register += 9; // add 9 the lowest resolution in bit
+		ret = (int) config_register;
+	}
+	return ret;
+}
+
+
+static inline int w1_DS18B20_convert_temp(u8 rom[9])
+{
+	s16 t = le16_to_cpup((__le16 *)rom);
+
+	return t*1000/16;
+}
+
+static inline int w1_DS18S20_convert_temp(u8 rom[9])
+{
+	int t, h;
+
+	if (!rom[7]) {
+		pr_debug("%s: Invalid argument for conversion\n", __func__);
+		return 0;
+	}
+
+	if (rom[1] == 0)
+		t = ((s32)rom[0] >> 1)*1000;
+	else
+		t = 1000*(-1*(s32)(0x100-rom[0]) >> 1);
+
+	t -= 250;
+	h = 1000*((s32)rom[7] - (s32)rom[6]);
+	h /= (s32)rom[7];
+	t += h;
+
+	return t;
+}
 
-			/* check if in parasite mode */
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
+/*------------------------ Helpers Functions----------------------------*/
 
-			if (w1_reset_select_slave(sl))
-				continue;
+static struct w1_therm_family_converter *device_family(struct w1_slave *sl)
+{
+	struct w1_therm_family_converter *ret = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
+		if (w1_therm_families[i].f->fid == sl->family->fid) {
+			ret = &w1_therm_families[i];
+			break;
+		}
+	}
+	return ret;
+}
+
+static inline bool bus_mutex_lock(struct mutex *lock)
+{
+	int max_trying = W1_THERM_MAX_TRY;
+	/* try to acquire the mutex, if not, sleep retry_delay before retry) */
+	while (mutex_lock_interruptible(lock) != 0 && max_trying > 0) {
+		unsigned long sleep_rem;
+
+		sleep_rem = msleep_interruptible(W1_THERM_RETRY_DELAY);
+		if (!sleep_rem)
+			max_trying--;
+	}
+
+	if (!max_trying)
+		return false;	/* Didn't acquire the bus mutex */
+
+	return true;
+}
+
+
+static inline bool bulk_read_support(struct w1_slave *sl)
+{
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->bulk_read;
+
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
+
+	return false;  /* No device family */
+}
+
+static inline int conversion_time(struct w1_slave *sl)
+{
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->get_conversion_time(sl);
+
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
+
+	return -ENODEV;  /* No device family */
+}
+
+static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
+{
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->convert(rom);
+
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
+
+	return 0;  /* No device family */
+}
+
+static inline s8 int_to_short(int i)
+{
+	/* Prepare to cast to short by eliminating out of range values */
+	i = i > MAX_TEMP ? MAX_TEMP : i;
+	i = i < MIN_TEMP ? MIN_TEMP : i;
+	return (s8) i;
+}
+/*-------------------------Interface Functions------------------------------*/
+
+static int w1_therm_add_slave(struct w1_slave *sl)
+{
+	struct w1_therm_family_converter *sl_family_conv;
+
+	/* Allocate memory*/
+	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
+		GFP_KERNEL);
+	if (!sl->family_data)
+		return -ENOMEM;
+	atomic_set(THERM_REFCNT(sl->family_data), 1);
+
+	/* Get a pointer to the device specific function struct */
+	sl_family_conv = device_family(sl);
+	if (!sl_family_conv) {
+		kfree(sl->family_data);
+		return -ENODEV;
+	}
+	SLAVE_SPECIFIC_FUNC(sl) = sl_family_conv;
+
+	if (bulk_read_support(sl)) {
+		/* add the sys entry to trigger bulk_read
+		 * at master level only the 1st time
+		 */
+		if (!bulk_read_device_counter) {
+			int err = device_create_file(&sl->master->dev,
+				&dev_attr_therm_bulk_read);
+
+			if (err)
+				dev_warn(&sl->dev,
+				"%s: Device has been added, but bulk read is unavailable. err=%d\n",
+				__func__, err);
+		}
+		/* Increment the counter */
+		bulk_read_device_counter++;
+	}
+
+	/* Getting the power mode of the device {external, parasite}*/
+	SLAVE_POWERMODE(sl) = read_powermode(sl);
+
+	if (SLAVE_POWERMODE(sl) < 0) {
+		/* no error returned as device has been added */
+		dev_warn(&sl->dev,
+			"%s: Device has been added, but power_mode may be corrupted. err=%d\n",
+			 __func__, SLAVE_POWERMODE(sl));
+	}
+
+	/* Getting the resolution of the device */
+	if (SLAVE_SPECIFIC_FUNC(sl)->get_resolution) {
+		SLAVE_RESOLUTION(sl) =
+			SLAVE_SPECIFIC_FUNC(sl)->get_resolution(sl);
+		if (SLAVE_RESOLUTION(sl) < 0) {
+			/* no error returned as device has been added */
+			dev_warn(&sl->dev,
+				"%s:Device has been added, but resolution may be corrupted. err=%d\n",
+				__func__, SLAVE_RESOLUTION(sl));
+		}
+	}
+
+	/* Finally initialize convert_triggered flag */
+	SLAVE_CONVERT_TRIGGERED(sl) = 0;
+
+	return 0;
+}
+
+static void w1_therm_remove_slave(struct w1_slave *sl)
+{
+	int refcnt = atomic_sub_return(1, THERM_REFCNT(sl->family_data));
+
+	if (bulk_read_support(sl)) {
+		bulk_read_device_counter--;
+		/* Delete the entry if no more device support the feature */
+		if (!bulk_read_device_counter)
+			device_remove_file(&sl->master->dev,
+				&dev_attr_therm_bulk_read);
+	}
 
-			/* 10ms strong pullup/delay after the copy command */
-			if (w1_strong_pullup == 2 ||
-			    (!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
+	while (refcnt) {
+		msleep(1000);
+		refcnt = atomic_read(THERM_REFCNT(sl->family_data));
+	}
+	kfree(sl->family_data);
+	sl->family_data = NULL;
+
+}
+
+/*------------------------Hardware Functions--------------------------*/
+
+/* Safe version of reser_select_slave - avoid using the one in w_io.c */
+static int reset_select_slave(struct w1_slave *sl)
+{
+	u8 match[9] = { W1_MATCH_ROM, };
+	u64 rn = le64_to_cpu(*((u64 *)&sl->reg_num));
+
+	if (w1_reset_bus(sl->master))
+		return -ENODEV;
+
+	memcpy(&match[1], &rn, 8);
+	w1_write_block(sl->master, match, 9);
+
+	return 0;
+}
+
+static int convert_t(struct w1_slave *sl, struct therm_info *info)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_conv;
+	int ret = -ENODEV;
+	bool strong_pullup;
+
+	if (!sl->family_data)
+		goto error;
+
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
+
+	/* get conversion duration device and id dependent */
+	t_conv = conversion_time(sl);
+
+	memset(info->rom, 0, sizeof(info->rom));
+
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
+
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
+
+	while (max_trying-- && ret) { /* ret should be 0 */
+
+		info->verdict = 0;
+		info->crc = 0;
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			unsigned long sleep_rem;
 
-			w1_write_8(dev, W1_COPY_SCRATCHPAD);
+			/* 750ms strong pullup (or delay) after the convert */
+			if (strong_pullup)
+				w1_next_pullup(dev_master, t_conv);
 
-			if (external_power) {
-				mutex_unlock(&dev->bus_mutex);
+			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
-				sleep_rem = msleep_interruptible(tm);
+			if (strong_pullup) { /*some device need pullup */
+				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
-					goto dec_refcnt;
+					goto mt_unlock;
 				}
+				mutex_unlock(&dev_master->bus_mutex);
+			} else { /*no device need pullup */
+				mutex_unlock(&dev_master->bus_mutex);
 
-				ret = mutex_lock_interruptible(&dev->bus_mutex);
-				if (ret != 0)
-					goto dec_refcnt;
-			} else if (!w1_strong_pullup) {
-				sleep_rem = msleep_interruptible(tm);
+				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
-					goto mt_unlock;
+					goto dec_refcnt;
 				}
 			}
-
-			break;
+			ret = read_scratchpad(sl, info);
+			goto dec_refcnt;
 		}
+
 	}
 
 mt_unlock:
-	mutex_unlock(&dev->bus_mutex);
+	mutex_unlock(&dev_master->bus_mutex);
 dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
+	atomic_dec(THERM_REFCNT(sl->family_data));
 error:
 	return ret;
 }
 
-/* DS18S20 does not feature configuration register */
-static inline int w1_DS18S20_precision(struct device *device, int val)
-{
-	return 0;
-}
 
-static inline int w1_DS18B20_precision(struct device *device, int val)
+static int read_scratchpad(struct w1_slave *sl, struct therm_info *info)
 {
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], crc;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
-	uint8_t precision_bits;
-	uint8_t mask = 0x60;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
 
-	if (val > 12 || val < 9) {
-		pr_warn("Unsupported precision\n");
-		ret = -EINVAL;
-		goto error;
-	}
+	info->verdict = 0;
 
-	if (!sl->family_data) {
-		ret = -ENODEV;
+	if (!sl->family_data)
 		goto error;
-	}
+
+	memset(info->rom, 0, sizeof(info->rom));
 
 	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
 		goto dec_refcnt;
+	}
 
-	memset(rom, 0, sizeof(rom));
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			u8 nb_bytes_read;
+
+			w1_write_8(dev_master, W1_READ_SCRATCHPAD);
+
+			nb_bytes_read = w1_read_block(dev_master, info->rom, 9);
+			if (nb_bytes_read != 9) {
+				dev_warn(&sl->dev,
+					"w1_read_block(): returned %u instead of 9.\n",
+					nb_bytes_read);
+				ret = -EIO;
+			}
+
+			info->crc = w1_calc_crc8(info->rom, 8);
+
+			if (info->rom[8] == info->crc) {
+				info->verdict = 1;
+				ret = 0;
+			} else
+				ret = -EIO; /* CRC not checked */
+		}
 
-	/* translate precision to bitmask (see datasheet page 9) */
-	switch (val) {
-	case 9:
-		precision_bits = 0x00;
-		break;
-	case 10:
-		precision_bits = 0x20;
-		break;
-	case 11:
-		precision_bits = 0x40;
-		break;
-	case 12:
-	default:
-		precision_bits = 0x60;
-		break;
 	}
+	mutex_unlock(&dev_master->bus_mutex);
 
-	while (max_trying--) {
-		crc = 0;
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
 
-		if (!w1_reset_select_slave(sl)) {
-			int count = 0;
+static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
 
-			/* read values to only alter precision bits */
-			w1_write_8(dev, W1_READ_SCRATCHPAD);
-			count = w1_read_block(dev, rom, 9);
-			if (count != 9)
-				dev_warn(device, "w1_read_block() returned %u instead of 9.\n",	count);
+	if (!sl->family_data)
+		goto error;
 
-			crc = w1_calc_crc8(rom, 8);
-			if (rom[8] == crc) {
-				rom[4] = (rom[4] & ~mask) | (precision_bits & mask);
+	/* prevent the slave from going away in sleep */
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-				if (!w1_reset_select_slave(sl)) {
-					w1_write_8(dev, W1_WRITE_SCRATCHPAD);
-					w1_write_8(dev, rom[2]);
-					w1_write_8(dev, rom[3]);
-					w1_write_8(dev, rom[4]);
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
 
-					break;
-				}
-			}
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			w1_write_8(dev_master, W1_WRITE_SCRATCHPAD);
+			w1_write_block(dev_master, data, nb_bytes);
+			ret = 0;
 		}
 	}
+	mutex_unlock(&dev_master->bus_mutex);
 
-	mutex_unlock(&dev->bus_mutex);
 dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
+	atomic_dec(THERM_REFCNT(sl->family_data));
 error:
 	return ret;
 }
 
-static inline int w1_DS18B20_convert_temp(u8 rom[9])
+static int copy_scratchpad(struct w1_slave *sl)
 {
-	s16 t = le16_to_cpup((__le16 *)rom);
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_write, ret = -ENODEV;
+	bool strong_pullup;
 
-	return t*1000/16;
-}
+	if (!sl->family_data)
+		goto error;
 
-static inline int w1_DS18S20_convert_temp(u8 rom[9])
-{
-	int t, h;
+	t_write = W1_THERM_EEPROM_WRITE_DELAY;
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
 
-	if (!rom[7])
-		return 0;
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-	if (rom[1] == 0)
-		t = ((s32)rom[0] >> 1)*1000;
-	else
-		t = 1000*(-1*(s32)(0x100-rom[0]) >> 1);
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
 
-	t -= 250;
-	h = 1000*((s32)rom[7] - (s32)rom[6]);
-	h /= (s32)rom[7];
-	t += h;
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			unsigned long sleep_rem;
 
-	return t;
-}
+			/* 10ms strong pullup (or delay) after the convert */
+			if (strong_pullup)
+				w1_next_pullup(dev_master, t_write);
 
-static inline int w1_convert_temp(u8 rom[9], u8 fid)
-{
-	int i;
+			w1_write_8(dev_master, W1_COPY_SCRATCHPAD);
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i)
-		if (w1_therm_families[i].f->fid == fid)
-			return w1_therm_families[i].convert(rom);
+			if (strong_pullup) {
+				sleep_rem = msleep_interruptible(t_write);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto mt_unlock;
+				}
+			}
+			ret = 0;
+		}
 
-	return 0;
+	}
+
+mt_unlock:
+	mutex_unlock(&dev_master->bus_mutex);
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
 }
 
-static ssize_t w1_slave_store(struct device *device,
-			      struct device_attribute *attr, const char *buf,
-			      size_t size)
+static int recall_eeprom(struct w1_slave *sl)
 {
-	int val, ret;
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	int i;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
 
-	ret = kstrtoint(buf, 0, &val);
-	if (ret)
-		return ret;
+	if (!sl->family_data)
+		goto error;
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
-		if (w1_therm_families[i].f->fid == sl->family->fid) {
-			/* zero value indicates to write current configuration to eeprom */
-			if (val == 0)
-				ret = w1_therm_families[i].eeprom(device);
-			else
-				ret = w1_therm_families[i].precision(device, val);
-			break;
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
+
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
+
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+
+			w1_write_8(dev_master, W1_RECALL_EEPROM);
+
+			ret = 1; /* Slave will pull line to 0 */
+			while (ret)
+				ret = 1 - w1_touch_bit(dev_master, 1);
 		}
+
 	}
-	return ret ? : size;
+
+	mutex_unlock(&dev_master->bus_mutex);
+
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
 }
 
-static ssize_t read_therm(struct device *device,
-			  struct w1_slave *sl, struct therm_info *info)
+static int read_powermode(struct w1_slave *sl)
 {
-	struct w1_master *dev = sl->master;
-	u8 external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int  ret = -ENODEV;
 
-	if (!family_data) {
-		ret = -ENODEV;
+	if (!sl->family_data)
 		goto error;
-	}
 
 	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
 		goto dec_refcnt;
+	}
 
-	memset(info->rom, 0, sizeof(info->rom));
+	while ((max_trying--) && (ret < 0)) {
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			w1_write_8(dev_master, W1_READ_PSUPPLY);
+			/* Read only one bit,
+			 * 1 is externally powered,
+			 * 0 is parasite powered
+			 */
+			ret = w1_touch_bit(dev_master, 1);
+			/* ret should be either 1 either 0 */
+		}
+	}
+	mutex_unlock(&dev_master->bus_mutex);
 
-	while (max_trying--) {
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
 
-		info->verdict = 0;
-		info->crc = 0;
+static int trigger_bulk_read(struct w1_master *dev_master)
+{
+	struct w1_slave *sl = NULL; /* used to iterate through slaves */
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_conv = 0;
+	int ret = -ENODEV;
+	bool strong_pullup = false;
+
+	/* Check whether there are parasite powered device on the bus,
+	 * and compute duration of conversion for these devices
+	 * so we can apply a strong pullup if required
+	 */
+	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
+		if (!sl->family_data)
+			goto error;
+		if (bulk_read_support(sl)) {
+			int t_cur = conversion_time(sl);
+
+			t_conv = t_cur > t_conv ? t_cur : t_conv;
+			strong_pullup = strong_pullup ||
+					(w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
+		}
+	}
 
-		if (!w1_reset_select_slave(sl)) {
-			int count = 0;
-			unsigned int tm = 750;
-			unsigned long sleep_rem;
+	/* t_conv is the max conversion time required on the bus
+	 * If its 0, no device support the bulk read feature
+	 */
+	if (!t_conv)
+		goto error;
 
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto error;
+	}
 
-			if (w1_reset_select_slave(sl))
-				continue;
+	while ((max_trying--) && (ret < 0)) { /* ret should be either 0 */
 
-			/* 750ms strong pullup (or delay) after the convert */
-			if (w1_strong_pullup == 2 ||
-					(!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
+		if (!w1_reset_bus(dev_master)) {	/* Just reset the bus */
+			unsigned long sleep_rem;
 
-			w1_write_8(dev, W1_CONVERT_TEMP);
+			w1_write_8(dev_master, W1_SKIP_ROM);
 
-			if (external_power) {
-				mutex_unlock(&dev->bus_mutex);
+			if (strong_pullup)	/* Apply pullup if required */
+				w1_next_pullup(dev_master, t_conv);
 
-				sleep_rem = msleep_interruptible(tm);
-				if (sleep_rem != 0) {
-					ret = -EINTR;
-					goto dec_refcnt;
-				}
+			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
-				ret = mutex_lock_interruptible(&dev->bus_mutex);
-				if (ret != 0)
-					goto dec_refcnt;
-			} else if (!w1_strong_pullup) {
-				sleep_rem = msleep_interruptible(tm);
+			/* set a flag to instruct that converT pending */
+			list_for_each_entry(sl,
+				&dev_master->slist, w1_slave_entry) {
+				if (bulk_read_support(sl))
+					SLAVE_CONVERT_TRIGGERED(sl) = -1;
+			}
+
+			if (strong_pullup) { /*some device need pullup */
+				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
 					goto mt_unlock;
 				}
-			}
-
-			if (!w1_reset_select_slave(sl)) {
-
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				count = w1_read_block(dev, info->rom, 9);
-				if (count != 9) {
-					dev_warn(device, "w1_read_block() "
-						"returned %u instead of 9.\n",
-						count);
+				mutex_unlock(&dev_master->bus_mutex);
+			} else {
+				mutex_unlock(&dev_master->bus_mutex);
+				sleep_rem = msleep_interruptible(t_conv);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto set_flag;
 				}
-
-				info->crc = w1_calc_crc8(info->rom, 8);
-
-				if (info->rom[8] == info->crc)
-					info->verdict = 1;
 			}
+			ret = 0;
+			goto set_flag;
 		}
-
-		if (info->verdict)
-			break;
 	}
 
 mt_unlock:
-	mutex_unlock(&dev->bus_mutex);
-dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
+	mutex_unlock(&dev_master->bus_mutex);
+set_flag:
+	/* set a flag to register convsersion is done */
+	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
+		if (bulk_read_support(sl))
+			SLAVE_CONVERT_TRIGGERED(sl) = 1;
+	}
 error:
 	return ret;
 }
 
+
+/*------------------------Interface Functions--------------------------*/
+
 static ssize_t w1_slave_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
@@ -572,43 +968,402 @@ static ssize_t w1_slave_show(struct device *device,
 	u8 *family_data = sl->family_data;
 	int ret, i;
 	ssize_t c = PAGE_SIZE;
-	u8 fid = sl->family->fid;
 
-	ret = read_therm(device, sl, &info);
-	if (ret)
-		return ret;
+	if (bulk_read_support(sl)) {
+		if (SLAVE_CONVERT_TRIGGERED(sl) < 0) {
+			dev_dbg(device,
+				"%s: Conversion in progress, retry later\n",
+				__func__);
+			return 0;
+		} else if (SLAVE_CONVERT_TRIGGERED(sl) > 0) {
+			/* A bulk read has been issued, read the device RAM */
+			ret = read_scratchpad(sl, &info);
+			SLAVE_CONVERT_TRIGGERED(sl) = 0;
+		} else
+			ret = convert_t(sl, &info);
+	} else
+		ret = convert_t(sl, &info);
+
+	if (ret < 0) {
+		dev_dbg(device,
+			"%s: Temperature data may be corrupted. err=%d\n",
+			__func__, ret);
+		return 0;
+	}
 
 	for (i = 0; i < 9; ++i)
 		c -= snprintf(buf + PAGE_SIZE - c, c, "%02x ", info.rom[i]);
 	c -= snprintf(buf + PAGE_SIZE - c, c, ": crc=%02x %s\n",
 		      info.crc, (info.verdict) ? "YES" : "NO");
+
 	if (info.verdict)
 		memcpy(family_data, info.rom, sizeof(info.rom));
 	else
-		dev_warn(device, "Read failed CRC check\n");
+		dev_warn(device, "%s:Read failed CRC check\n", __func__);
 
 	for (i = 0; i < 9; ++i)
 		c -= snprintf(buf + PAGE_SIZE - c, c, "%02x ",
 			      ((u8 *)family_data)[i]);
 
 	c -= snprintf(buf + PAGE_SIZE - c, c, "t=%d\n",
-			w1_convert_temp(info.rom, fid));
+		temperature_from_RAM(sl, info.rom));
+
 	ret = PAGE_SIZE - c;
 	return ret;
 }
 
+static ssize_t w1_slave_store(struct device *device,
+			      struct device_attribute *attr, const char *buf,
+			      size_t size)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int val, ret = 0;
+
+	ret = kstrtoint(buf, 10, &val); /* converting user entry to int */
+
+	if (ret) {	/* conversion error */
+		dev_info(device,
+			"%s: conversion error. err= %d\n", __func__, ret);
+		return size;	/* return size to avoid call back again*/
+	}
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return size;  /* No device family */
+	}
+
+	if (val == 0)	/* val=0 : trigger a EEPROM save */
+		ret = copy_scratchpad(sl);
+	else {
+		if (SLAVE_SPECIFIC_FUNC(sl)->set_resolution)
+			ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
+	}
+
+	if (ret) {
+		dev_info(device,
+			"%s: writing error %d\n", __func__, ret);
+		/* return size to avoid call back again*/
+	} else
+		SLAVE_RESOLUTION(sl) = val;
+
+	return size; /* always return size to avoid infinite calling */
+}
+
+static ssize_t temperature_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	struct therm_info info;
+	int ret = 0;
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+
+	if (bulk_read_support(sl)) {
+		if (SLAVE_CONVERT_TRIGGERED(sl) < 0) {
+			dev_dbg(device,
+				"%s: Conversion in progress, retry later\n",
+				__func__);
+			return 0;
+		} else if (SLAVE_CONVERT_TRIGGERED(sl) > 0) {
+			/* A bulk read has been issued, read the device RAM */
+			ret = read_scratchpad(sl, &info);
+			SLAVE_CONVERT_TRIGGERED(sl) = 0;
+		} else
+			ret = convert_t(sl, &info);
+	} else
+		ret = convert_t(sl, &info);
+
+	if (ret < 0) {
+		dev_dbg(device,
+			"%s: Temperature data may be corrupted. err=%d\n",
+			__func__, ret);
+		return 0;
+	}
+
+	return sprintf(buf, "%d\n", temperature_from_RAM(sl, info.rom));
+}
+
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	if (!sl->family_data) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+
+	/* Getting the power mode of the device {external, parasite}*/
+	SLAVE_POWERMODE(sl) = read_powermode(sl);
+
+	if (SLAVE_POWERMODE(sl) < 0) {
+		dev_dbg(device,
+			"%s: Power_mode may be corrupted. err=%d\n",
+			__func__, SLAVE_POWERMODE(sl));
+	}
+	return sprintf(buf, "%d\n", SLAVE_POWERMODE(sl));
+}
+
+static ssize_t resolution_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+
+	/* get the correct function depending on the device */
+	SLAVE_RESOLUTION(sl) = SLAVE_SPECIFIC_FUNC(sl)->get_resolution(sl);
+	if (SLAVE_RESOLUTION(sl) < 0) {
+		dev_dbg(device,
+			"%s: Resolution may be corrupted. err=%d\n",
+			__func__, SLAVE_RESOLUTION(sl));
+	}
+
+	return sprintf(buf, "%d\n", SLAVE_RESOLUTION(sl));
+}
+
+static ssize_t resolution_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int val;
+	int ret = 0;
+
+	ret = kstrtoint(buf, 10, &val); /* converting user entry to int */
+
+	if (ret) {	/* conversion error */
+		dev_info(device,
+			"%s: conversion error. err= %d\n", __func__, ret);
+		return size;	/* return size to avoid call back again*/
+	}
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return size;  /* No device family */
+	}
+
+	/* Don't deal with the val enterd by user,
+	 * only device knows what is correct or not
+	 */
+
+	/* get the correct function depending on the device */
+	ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
+
+	if (ret) {
+		dev_info(device,
+			"%s: writing error %d\n", __func__, ret);
+		/* return size to avoid call back again*/
+	} else
+		SLAVE_RESOLUTION(sl) = val;
+
+	return size;
+}
+
+static ssize_t eeprom_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int ret = -EINVAL; // Invalid argument
+
+	if (size == sizeof(EEPROM_CMD_WRITE)) {
+		if (!strncmp(buf, EEPROM_CMD_WRITE, sizeof(EEPROM_CMD_WRITE)-1))
+			ret = copy_scratchpad(sl);
+	} else if (size == sizeof(EEPROM_CMD_READ)) {
+		if (!strncmp(buf, EEPROM_CMD_READ, sizeof(EEPROM_CMD_READ)-1))
+			ret = recall_eeprom(sl);
+	}
+
+	if (ret)
+		dev_info(device, "%s: error in process %d\n", __func__, ret);
+
+	return size;
+}
+
+static ssize_t alarms_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int ret = -ENODEV;
+	s8 th = 0, tl = 0;
+	struct therm_info scratchpad;
+
+	ret = read_scratchpad(sl, &scratchpad);
+
+	if (!ret)	{
+		th = scratchpad.rom[2]; // TH is byte 2
+		tl = scratchpad.rom[3]; // TL is byte 3
+	} else {
+		dev_info(device,
+			"%s: error reading alarms register %d\n",
+			__func__, ret);
+	}
+
+	return sprintf(buf, "%hd %hd\n", tl, th);
+}
+
+static ssize_t alarms_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	struct therm_info info;
+	u8 new_config_register[3];	/* array of data to be written */
+	int temp, ret = -EINVAL;
+	char *token = NULL;
+	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	char *p_args = kmalloc(size, GFP_KERNEL);
+
+	/* Safe string copys as buf is const */
+	if (!p_args) {
+		dev_warn(device,
+			"%s: error unable to allocate memory %d\n",
+			__func__, -ENOMEM);
+		return size;
+	}
+	strcpy(p_args, buf);
+
+	/* Split string using space char */
+	token = strsep(&p_args, " ");
+
+	if (!token)	{
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, -EINVAL);
+		goto free_m;
+	}
+
+	/* Convert 1st entry to int */
+	ret = kstrtoint (token, 10, &temp);
+	if (ret) {
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, ret);
+		goto free_m;
+	}
+
+	tl = int_to_short(temp);
+
+	/* Split string using space char */
+	token = strsep(&p_args, " ");
+	if (!token)	{
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, -EINVAL);
+		goto free_m;
+	}
+	/* Convert 2nd entry to int */
+	ret = kstrtoint (token, 10, &temp);
+	if (ret) {
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, ret);
+		goto free_m;
+	}
+
+	/* Prepare to cast to short by eliminating out of range values */
+	th = int_to_short(temp);
+
+	/* Reorder if required th and tl */
+	if (tl > th) {
+		tt = tl; tl = th; th = tt;
+	}
+
+	/* Read the scratchpad to change only the required bits
+	 * (th : byte 2 - tl: byte 3)
+	 */
+	ret = read_scratchpad(sl, &info);
+	if (!ret) {
+		new_config_register[0] = th;	// Byte 2
+		new_config_register[1] = tl;	// Byte 3
+		new_config_register[2] = info.rom[4];// Byte 4
+	} else {
+		dev_info(device,
+			"%s: error reading from the slave device %d\n",
+			__func__, ret);
+		goto free_m;
+	}
+
+	/* Write data in the device RAM */
+	if (!SLAVE_SPECIFIC_FUNC(sl)) {
+		dev_info(device,
+			"%s: Device not supported by the driver %d\n",
+			__func__, -ENODEV);
+		goto free_m;
+	}
+
+	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
+	if (ret)
+		dev_info(device,
+			"%s: error writing to the slave device %d\n",
+			__func__, ret);
+
+free_m:
+	/* free allocated memory */
+	kfree(p_args);
+
+	return size;
+}
+
+static ssize_t therm_bulk_read_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct w1_master *dev_master = dev_to_w1_master(device);
+	int ret = -EINVAL; // Invalid argument
+
+	if (size == sizeof(BULK_TRIGGER_CMD))
+		if (!strncmp(buf, BULK_TRIGGER_CMD,
+				sizeof(BULK_TRIGGER_CMD)-1))
+			ret = trigger_bulk_read(dev_master);
+
+	if (ret)
+		dev_info(device,
+			"%s: unable to trigger a bulk read on the bus. err=%d\n",
+			__func__, ret);
+
+	return size;
+}
+
+static ssize_t therm_bulk_read_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_master *dev_master = dev_to_w1_master(device);
+	struct w1_slave *sl = NULL;
+	int ret = 0;
+
+	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
+		if (sl->family_data) {
+			if (bulk_read_support(sl)) {
+				if (SLAVE_CONVERT_TRIGGERED(sl) == -1) {
+					ret = -1;
+					goto show_result;
+				}
+				if (SLAVE_CONVERT_TRIGGERED(sl) == 1)
+					/* continue to check other slaves */
+					ret = 1;
+			}
+		}
+	}
+show_result:
+	return sprintf(buf, "%d\n", ret);
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
 {
 	struct w1_slave *sl = dev_get_drvdata(device);
 	struct therm_info info;
-	u8 fid = sl->family->fid;
 	int ret;
 
 	switch (attr) {
 	case hwmon_temp_input:
-		ret = read_therm(device, sl, &info);
+		ret = convert_t(sl, &info);
 		if (ret)
 			return ret;
 
@@ -617,7 +1372,7 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
 			return ret;
 		}
 
-		*val = w1_convert_temp(info.rom, fid);
+		*val = temperature_from_RAM(sl, info.rom);
 		ret = 0;
 		break;
 	default:
@@ -714,24 +1469,31 @@ static ssize_t w1_seq_show(struct device *device,
 
 static int __init w1_therm_init(void)
 {
-	int err, i;
+	int err, i, nb_registred;
+
+	nb_registred = 0;
 
 	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
 		err = w1_register_family(w1_therm_families[i].f);
 		if (err)
 			w1_therm_families[i].broken = 1;
+		else
+			nb_registred++;
 	}
-
 	return 0;
 }
 
 static void __exit w1_therm_fini(void)
 {
-	int i;
+	int i, nb_unregistred;
+
+	nb_unregistred = 0;
 
 	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i)
-		if (!w1_therm_families[i].broken)
+		if (!w1_therm_families[i].broken) {
 			w1_unregister_family(w1_therm_families[i].f);
+			nb_unregistred++;
+		}
 }
 
 module_init(w1_therm_init);
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
new file mode 100644
index 0000000000000..e48355762810a
--- /dev/null
+++ b/drivers/w1/slaves/w1_therm.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *	w1_therm.h
+ *
+ * Written by Akira Shimahara
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __W1_THERM_H
+#define __W1_THERM_H
+
+#include <asm/types.h>
+
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/w1.h>
+
+/*----------------------------------Defines---------------------------------*/
+/* This command should be in public header w1.h but is not */
+#define W1_RECALL_EEPROM	0xB8
+
+/* Nb of try for an operation */
+#define W1_THERM_MAX_TRY		    5
+
+/* ms delay to retry bus mutex */
+#define W1_THERM_RETRY_DELAY	    20
+
+/* delay in ms to write in EEPROM */
+#define W1_THERM_EEPROM_WRITE_DELAY	10
+
+#define EEPROM_CMD_WRITE    "save"		/* cmd for write eeprom sysfs */
+#define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
+#define BULK_TRIGGER_CMD    "trigger"	/* cmd to trigger a bulk read */
+
+#define MIN_TEMP	-55	/* min temperature that can be mesured */
+#define MAX_TEMP	125	/* max temperature that can be mesured */
+
+/* Counter for devices supporting bulk reading */
+static u16 bulk_read_device_counter; // =0 as per C standard
+
+/*----------------------------------Structs---------------------------------*/
+
+/**
+ * struct w1_therm_family_converter
+ * @brief Used to bind standard function call
+ * to device specific function
+ * it could be routed to NULL if device don't support feature
+ * see helper : device_family()
+ */
+struct w1_therm_family_converter {
+	u8		broken;
+	u16		reserved;
+	struct w1_family	*f;
+	int		(*convert)(u8 rom[9]);
+	int		(*get_conversion_time)(struct w1_slave *sl);
+	int		(*set_resolution)(struct w1_slave *sl, int val);
+	int		(*get_resolution)(struct w1_slave *sl);
+	int		(*write_data)(struct w1_slave *sl, const u8 *data);
+	bool	bulk_read;
+};
+
+/**
+ * struct w1_therm_family_data
+ * @param rom data
+ * @param refcnt ref count
+ * @param external_powered
+ *		1 device powered externally,
+ *		0 device parasite powered,
+ *		-x error or undefined
+ * @param resolution resolution in bit of the device, <O kernel error code
+ */
+struct w1_therm_family_data {
+	uint8_t rom[9];
+	atomic_t refcnt;
+	int external_powered;
+	int resolution;
+	int convert_triggered;
+	struct w1_therm_family_converter *specific_functions;
+};
+
+/**
+ * struct therm_info
+ * @brief Only used to store temperature reading
+ * @param rom RAM device data
+ * @param crc computed crc from rom
+ * @param verdict 1 crc checked, 0 crc not matching
+ */
+struct therm_info {
+	u8 rom[9];
+	u8 crc;
+	u8 verdict;
+};
+
+/*-----------------------Device specific functions-------------------------*/
+
+static inline int w1_DS18B20_convert_temp(u8 rom[9]);
+static inline int w1_DS18S20_convert_temp(u8 rom[9]);
+
+static inline int w1_DS18B20_convert_time(struct w1_slave *sl);
+static inline int w1_DS18S20_convert_time(struct w1_slave *sl);
+
+static inline int w1_DS18B20_write_data(struct w1_slave *sl, const u8 *data);
+static inline int w1_DS18S20_write_data(struct w1_slave *sl, const u8 *data);
+
+static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val);
+static inline int w1_DS18B20_get_resolution(struct w1_slave *sl);
+
+/*-------------------------------Macros--------------------------------------*/
+
+/* return a pointer on the slave w1_therm_family_converter struct:
+ * always test family data existence before
+ */
+#define SLAVE_SPECIFIC_FUNC(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->specific_functions)
+
+/* return the power mode of the sl slave : 1-ext, 0-parasite, <0 unknown
+ * always test family data existence before
+ */
+#define SLAVE_POWERMODE(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->external_powered)
+
+/* return the resolution in bit of the sl slave : <0 unknown
+ *	always test family data existence before
+ */
+#define SLAVE_RESOLUTION(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->resolution)
+
+/*  return whether or not a converT command has been issued to the slave
+ *  0: no bulk read is pending
+ * -1: conversion is in progress
+ *  1: conversion done, result to be read
+ */
+#define SLAVE_CONVERT_TRIGGERED(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->convert_triggered)
+
+/* return the address of the refcnt in the family data */
+#define THERM_REFCNT(family_data) \
+	(&((struct w1_therm_family_data *)family_data)->refcnt)
+
+/*-------------------------- Helpers Functions------------------------------*/
+
+/**  device_family()
+ *   @brief Helper function that provide a pointer
+ *		on the w1_therm_family_converter struct
+ *   @param sl represents the device
+ *   @return pointer to the slaves's family converter, NULL if not known
+ */
+static struct w1_therm_family_converter *device_family(struct w1_slave *sl);
+
+/** bus_mutex_lock() get the mutex & retry
+ *  @param lock w1 bus mutex to get
+ *  @return value true is mutex is acquired and lock, false otherwise
+ */
+static inline bool bus_mutex_lock(struct mutex *lock);
+
+/** support_bulk_read() check is device is supporting bulk read
+ *  @param sl device to get the conversion time
+ *  @return true : bulk read support, false : no support or error
+ */
+static inline bool bulk_read_support(struct w1_slave *sl);
+
+/** conversion_time() get the Tconv fo the device
+ *  @param sl device to get the conversion time
+ *  @return conversion time in ms, negative values kernel error code
+ */
+static inline int conversion_time(struct w1_slave *sl);
+
+/** temperature_from_RAM() return the temperature in 1/100°
+ *  @brief Device dependent, it will select the correct computation method
+ *  @param sl device that sent the RAM data
+ *  @param rom ram read value
+ *  @return temperature in 1/1000°
+ */
+static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9]);
+
+/** int_to_short() safe casting of int to short
+ * min/max values are defined by macro
+ * @param i integer to be converted to short
+ * @return a short in the range of min/max value
+ */
+static inline s8 int_to_short(int i);
+
+/*---------------------------Hardware Functions-----------------------------*/
+
+/**
+ * reset_select_slave() - reset and select a slave
+ * @brief Resets the bus and select the slave by sending either a ROM MATCH
+ * w1_reset_select_slave() from w1_io.c could not be used
+ * here because a SKIP ROM command is sent if only one device is on the line.
+ * At the beginning of the such process, sl->master->slave_count is 1 even if
+ * more devices are on the line, causing collision on the line.
+ * The w1 master lock must be held.
+ * @param sl the slave to select
+ * @return 0 if success, negative kernel error code otherwise
+ */
+static int reset_select_slave(struct w1_slave *sl);
+
+/** convert_t()
+ * @param sl pointer to the slave to read
+ * @param info pointer to a structure to store the read results
+ * @return 0 if success, -kernel error code otherwise
+ */
+static int convert_t(struct w1_slave *sl, struct therm_info *info);
+
+/** read_scratchpad()
+ * @param sl pointer to the slave to read
+ * @param info pointer to a structure to store the read results
+ * @return 0 if success, -kernel error code otherwise
+ */
+static int read_scratchpad(struct w1_slave *sl, struct therm_info *info);
+
+/** write_data()
+ * @param sl pointer to the slave to read
+ * @param data pointer to an array of 3 bytes, as 3 bytes MUST be written
+ * @param nb_bytes Nb bytes to be written (2 for DS18S20, 3 for other devices)
+ * @return 0 if success, -kernel error code otherwise
+ */
+static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
+
+/** copy_scratchpad() - Copy the content of scratchpad in device EEPROM
+ *  @param sl slave involved
+ *  @return 0 if success, -kernel error code otherwise
+ */
+static int copy_scratchpad(struct w1_slave *sl);
+
+/** recall_eeprom()
+ * @brief retrieve EEPROM data to device RAM
+ * @param sl slave involved
+ * @return 0 if success, -kernel error code otherwise
+ */
+static int recall_eeprom(struct w1_slave *sl);
+
+/** read_powermode()
+ * @brief ask the device to get its power mode {external, parasite}
+ * @param sl slave to be interrogated
+ * @return	0 parasite powered device
+ *			1 externally powered device
+ *			<0 kernel error code
+ */
+static int read_powermode(struct w1_slave *sl);
+
+/** trigger_bulk_read()
+ * @brief send a SKIP ROM follow by a CONVERT T commmand
+ * on the bus. It also set a flag in each slave struct to signal
+ * @param dev_master the device master of the bus
+ * @return 0 if success, -kernel error code otherwise
+ */
+static int trigger_bulk_read(struct w1_master *dev_master);
+
+/*----------------------------Interface sysfs-------------------------------*/
+
+/** @brief A callback function to output the temperature Old way
+ *  read temperature and return the result in the sys file
+ *  This has been kept for compatibility
+ */
+static ssize_t w1_slave_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/** @brief A callback function to set the resolution Old way
+ *  This has been kept for compatibility
+ *  @param 0, it write config in the EEPROM
+ *  @param 9..12, it set the resolution in the RAM
+ */
+static ssize_t w1_slave_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+static ssize_t w1_seq_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/** @brief A callback function to output the temperature
+ *  Main differences with w1_slave :
+ *	No hardware check (just read the stored device infos)
+ *	No formatting
+ *  @return temperature (1/1000°)
+ */
+static ssize_t temperature_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/** @brief A callback function to output the power mode of the device
+ *	Once done, it is stored in the sl->family_data to avoid doing the test
+ *	during data read
+ *  @return	0 : device parasite powered
+ *			1 : device externally powered
+ *			-xx : xx is kernel error code
+ */
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/** @brief A callback function to output the resolution of the device
+ *	Once done, it is stored in the sl->family_data to avoid doing the test
+ *	during data read
+ *  @return current resolution of the device in bit
+ */
+static ssize_t resolution_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/** @brief A callback function to store the user resolution in the device RAM
+ *  @param resolution in bit to be set
+ */
+static ssize_t resolution_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+/** @brief A callback function to let the user read/write device EEPROM
+ *  @param check EEPROM_CMD_WRITE & EEPROM_CMD_READ macros
+ */
+static ssize_t eeprom_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+/** @brief A callback function to set the alarms level
+ *  @param device represents the master device
+ */
+static ssize_t alarms_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+/** @brief A callback function to get the alarms level
+ *  @return Low and High alarm, separate by one space
+ */
+static ssize_t alarms_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/** @brief A callback function to trigger bulk read on the bus
+ *  @param check BULK_TRIGGER_CMD macro
+ */
+static ssize_t therm_bulk_read_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+
+/** @brief A callback function to check if bulk read is on progress
+ *  @return	-1 conversion in progress
+ *			1 conversion complete but not read on all sensors
+ *			0 no bulk operation pending
+ */
+static ssize_t therm_bulk_read_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/*-----------------------------Attributes declarations----------------------*/
+
+static DEVICE_ATTR_RW(w1_slave);
+static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(temperature);
+static DEVICE_ATTR_RO(ext_power);
+static DEVICE_ATTR_RW(resolution);
+static DEVICE_ATTR_WO(eeprom);
+static DEVICE_ATTR_RW(alarms);
+
+static DEVICE_ATTR_RW(therm_bulk_read); /* attribut at master level */
+
+/*--------------------------Interface Functions-----------------------------*/
+
+/** w1_therm_add_slave() - Called each time a search discover a new device
+ * @brief used to initialized slave (family datas)
+ * @param sl slave just discovered
+ * @return 0 - If success, negative kernel code otherwise
+ */
+static int w1_therm_add_slave(struct w1_slave *sl);
+
+/** w1_therm_remove_slave() - Called each time a slave is removed
+ * @brief used to free memory
+ * @param sl slave to be removed
+ */
+static void w1_therm_remove_slave(struct w1_slave *sl);
+
+/** w1_DS18B20_set_resolution() write new resolution to the RAM device
+ * @param sl device to set the resolution
+ * @param val  new resolution in bit [9..12]
+ * @return 0 if success, negative kernel error code otherwise
+ */
+static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val);
+
+/** w1_DS18B20_get_resolution() read the device RAM to get current resolution
+ * @param sl slave to get the resolution form
+ * @return resolution in bit [9..12] or negative kernel error code
+ */
+static inline int w1_DS18B20_get_resolution(struct w1_slave *sl);
+
+#endif  /* __W1_THERM_H */

