Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C82C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB37206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An0QkdMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgD2W7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2W7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:59:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE113C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:59:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so4549359wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aziuUmOM+gKRKIuATSEfXR5eFvvKhx1PXQfXWSGyIao=;
        b=An0QkdMTZoxdmCiSpCFGBi6lrQFWkSv4dELwYbQGaVanDiOYm4VLDJuupiYAX80bQj
         Ks/fAkCpaFwiEiuzJUDGChj67ZVg6rN1GLb/cWgjAiI1BKnP0fxzNuYyfxYMbnsAkJ93
         6i1VWjoEjXR119n/fsLLUpwRfHCUSjKC7s2ZhTAkzbS4MfZM10nm4cug2mCOOA4plVyB
         M0naX+rHByj44jd2bYCJguzWm+q7J+Nudr8n8uJBc+CMPlUUKS02b9wW+HUiV8CvCsQP
         m3UPtxDbz6tcr+IiT2nns/gygTlFPYPuiUuf+CzH6sAuZ/sq7nH6C2kXN4JaNC+rT5i1
         2aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aziuUmOM+gKRKIuATSEfXR5eFvvKhx1PXQfXWSGyIao=;
        b=axkp7GKlQ9idHjvXS37HKfLwjPeV4JT1sSLdQluNW6FQTac5UQruiVzekMsQgzyqx4
         jWAmrcMf+pbO0e3ndBhO4YGH7Tdkc/CNLMKPzz9MFL56vqZ6nYOAcc4aE67mBzlAOBc+
         Xv2kxxorlT7q2m2Z0HkI9YwaGi2CXALWuVlOjoTN8coxS1FB2DO7zGbmgKCzhG9OeoUD
         SpMmliiSP77DgssITvIbqSBl3lG/5dfySFmau615F9uVPVnIAOIs4zn4xU4uJZsSvoB4
         pPs500TGqDbH5Ohi8UORSDdQcsWPOMvyM4r1k83jZSh9doe51mfbTYYLNVAQ0XcGEWkg
         gDGQ==
X-Gm-Message-State: AGi0PubpOWace+NhkWPXGgnwWHp8FamStCefBKpDnrE7hY3BWrAvfQSe
        vdAi0Q/2eJhL6q/gzjpnNqf4yxj6
X-Google-Smtp-Source: APiQypK7X0+ZUNtETQZK7Rr6SJlYd4qUBijW0liTpoQwM6+Mfh2330KgT26PdtgpWwfLb6Hj9/aEpw==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr508540wrr.96.1588201169424;
        Wed, 29 Apr 2020 15:59:29 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id 19sm9571911wmo.3.2020.04.29.15.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:59:28 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v4 1/9] w1_therm: creating w1_therm.h
Date:   Thu, 30 Apr 2020 00:59:15 +0200
Message-Id: <20200429225915.198956-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating w1_therm.h header to organize code. Organize the w1_therm.c file
to gather hardware functions, device specific functions, interface
functions and sysfs functions.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 drivers/w1/slaves/w1_therm.c | 302 +++++++++++++++--------------------
 drivers/w1/slaves/w1_therm.h | 138 ++++++++++++++++
 2 files changed, 269 insertions(+), 171 deletions(-)
 create mode 100644 drivers/w1/slaves/w1_therm.h

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 18f08d7..f027360 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -5,19 +5,15 @@
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
 
-#include <linux/w1.h>
+#include "w1_therm.h"
 
 #define W1_THERM_DS18S20	0x10
 #define W1_THERM_DS1822		0x22
@@ -41,55 +37,6 @@
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
-
-static DEVICE_ATTR_RW(w1_slave);
-static DEVICE_ATTR_RO(w1_seq);
-
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	NULL,
@@ -101,6 +48,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	NULL,
 };
 
+/*------------------------------attribute groups----------------------------*/
 ATTRIBUTE_GROUPS(w1_therm);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
@@ -154,6 +102,7 @@ static const struct hwmon_chip_info w1_chip_info = {
 #define W1_CHIPINFO	NULL
 #endif
 
+/*------------------------------family operations---------------------------*/
 static struct w1_family_ops w1_therm_fops = {
 	.add_slave	= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
@@ -168,6 +117,7 @@ static struct w1_family_ops w1_ds28ea00_fops = {
 	.chip_info	= W1_CHIPINFO,
 };
 
+/*--------------------family binding on operations struct-------------------*/
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
 	.fops = &w1_therm_fops,
@@ -193,26 +143,7 @@ static struct w1_family w1_therm_family_DS1825 = {
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
-
+/*----------------------Device capability description-----------------------*/
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f		= &w1_therm_family_DS18S20,
@@ -246,78 +177,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	}
 };
 
-static inline int w1_therm_eeprom(struct device *device)
-{
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
-
-	if (!sl->family_data) {
-		ret = -ENODEV;
-		goto error;
-	}
-
-	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
-
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
-		goto dec_refcnt;
-
-	memset(rom, 0, sizeof(rom));
-
-	while (max_trying--) {
-		if (!w1_reset_select_slave(sl)) {
-			unsigned int tm = 10;
-			unsigned long sleep_rem;
-
-			/* check if in parasite mode */
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
-
-			if (w1_reset_select_slave(sl))
-				continue;
-
-			/* 10ms strong pullup/delay after the copy command */
-			if (w1_strong_pullup == 2 ||
-			    (!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
-
-			w1_write_8(dev, W1_COPY_SCRATCHPAD);
-
-			if (external_power) {
-				mutex_unlock(&dev->bus_mutex);
-
-				sleep_rem = msleep_interruptible(tm);
-				if (sleep_rem != 0) {
-					ret = -EINTR;
-					goto dec_refcnt;
-				}
-
-				ret = mutex_lock_interruptible(&dev->bus_mutex);
-				if (ret != 0)
-					goto dec_refcnt;
-			} else if (!w1_strong_pullup) {
-				sleep_rem = msleep_interruptible(tm);
-				if (sleep_rem != 0) {
-					ret = -EINTR;
-					goto mt_unlock;
-				}
-			}
-
-			break;
-		}
-	}
-
-mt_unlock:
-	mutex_unlock(&dev->bus_mutex);
-dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
-error:
-	return ret;
-}
+/*------------------------ Device dependent func---------------------------*/
 
 /* DS18S20 does not feature configuration register */
 static inline int w1_DS18S20_precision(struct device *device, int val)
@@ -434,40 +294,40 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 	return t;
 }
 
-static inline int w1_convert_temp(u8 rom[9], u8 fid)
+/*-------------------------Interface Functions------------------------------*/
+static int w1_therm_add_slave(struct w1_slave *sl)
 {
-	int i;
+	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
+		GFP_KERNEL);
+	if (!sl->family_data)
+		return -ENOMEM;
+	atomic_set(THERM_REFCNT(sl->family_data), 1);
+	return 0;
+}
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i)
-		if (w1_therm_families[i].f->fid == fid)
-			return w1_therm_families[i].convert(rom);
+static void w1_therm_remove_slave(struct w1_slave *sl)
+{
+	int refcnt = atomic_sub_return(1, THERM_REFCNT(sl->family_data));
 
-	return 0;
+	while (refcnt) {
+		msleep(1000);
+		refcnt = atomic_read(THERM_REFCNT(sl->family_data));
+	}
+	kfree(sl->family_data);
+	sl->family_data = NULL;
 }
 
-static ssize_t w1_slave_store(struct device *device,
-			      struct device_attribute *attr, const char *buf,
-			      size_t size)
+/*------------------------Hardware Functions--------------------------*/
+
+static inline int w1_convert_temp(u8 rom[9], u8 fid)
 {
-	int val, ret;
-	struct w1_slave *sl = dev_to_w1_slave(device);
 	int i;
 
-	ret = kstrtoint(buf, 0, &val);
-	if (ret)
-		return ret;
+	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i)
+		if (w1_therm_families[i].f->fid == fid)
+			return w1_therm_families[i].convert(rom);
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
-		if (w1_therm_families[i].f->fid == sl->family->fid) {
-			/* zero value indicates to write current configuration to eeprom */
-			if (val == 0)
-				ret = w1_therm_families[i].eeprom(device);
-			else
-				ret = w1_therm_families[i].precision(device, val);
-			break;
-		}
-	}
-	return ret ? : size;
+	return 0;
 }
 
 static ssize_t read_therm(struct device *device,
@@ -564,6 +424,81 @@ error:
 	return ret;
 }
 
+static inline int w1_therm_eeprom(struct device *device)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	struct w1_master *dev = sl->master;
+	u8 rom[9], external_power;
+	int ret, max_trying = 10;
+	u8 *family_data = sl->family_data;
+
+	if (!sl->family_data) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	/* prevent the slave from going away in sleep */
+	atomic_inc(THERM_REFCNT(family_data));
+
+	ret = mutex_lock_interruptible(&dev->bus_mutex);
+	if (ret != 0)
+		goto dec_refcnt;
+
+	memset(rom, 0, sizeof(rom));
+
+	while (max_trying--) {
+		if (!w1_reset_select_slave(sl)) {
+			unsigned int tm = 10;
+			unsigned long sleep_rem;
+
+			/* check if in parasite mode */
+			w1_write_8(dev, W1_READ_PSUPPLY);
+			external_power = w1_read_8(dev);
+
+			if (w1_reset_select_slave(sl))
+				continue;
+
+			/* 10ms strong pullup/delay after the copy command */
+			if (w1_strong_pullup == 2 ||
+			    (!external_power && w1_strong_pullup))
+				w1_next_pullup(dev, tm);
+
+			w1_write_8(dev, W1_COPY_SCRATCHPAD);
+
+			if (external_power) {
+				mutex_unlock(&dev->bus_mutex);
+
+				sleep_rem = msleep_interruptible(tm);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto dec_refcnt;
+				}
+
+				ret = mutex_lock_interruptible(&dev->bus_mutex);
+				if (ret != 0)
+					goto dec_refcnt;
+			} else if (!w1_strong_pullup) {
+				sleep_rem = msleep_interruptible(tm);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto mt_unlock;
+				}
+			}
+
+			break;
+		}
+	}
+
+mt_unlock:
+	mutex_unlock(&dev->bus_mutex);
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(family_data));
+error:
+	return ret;
+}
+
+/*------------------------Interface sysfs--------------------------*/
+
 static ssize_t w1_slave_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
@@ -597,6 +532,31 @@ static ssize_t w1_slave_show(struct device *device,
 	return ret;
 }
 
+static ssize_t w1_slave_store(struct device *device,
+			      struct device_attribute *attr, const char *buf,
+			      size_t size)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int val, ret, i;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
+		if (w1_therm_families[i].f->fid == sl->family->fid) {
+	/* zero value indicates to write current configuration to eeprom */
+			if (val == 0)
+				ret = w1_therm_families[i].eeprom(device);
+			else
+				ret = w1_therm_families[i].precision(device,
+								val);
+			break;
+		}
+	}
+	return ret ? : size;
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
new file mode 100644
index 0000000..8aa69cc
--- /dev/null
+++ b/drivers/w1/slaves/w1_therm.h
@@ -0,0 +1,138 @@
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
+	u8			broken;
+	u16			reserved;
+	struct w1_family	*f;
+	int			(*convert)(u8 rom[9]);
+	int			(*precision)(struct device *device, int val);
+	int			(*eeprom)(struct device *device);
+};
+
+/**
+ * struct w1_therm_family_data
+ * @param rom data
+ * @param refcnt ref count
+ */
+struct w1_therm_family_data {
+	uint8_t rom[9];
+	atomic_t refcnt;
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
+/* write configuration to eeprom */
+static inline int w1_therm_eeprom(struct device *device);
+
+/* Set precision for conversion */
+static inline int w1_DS18B20_precision(struct device *device, int val);
+static inline int w1_DS18S20_precision(struct device *device, int val);
+
+/* The return value is millidegrees Centigrade. */
+static inline int w1_DS18B20_convert_temp(u8 rom[9]);
+static inline int w1_DS18S20_convert_temp(u8 rom[9]);
+
+/*-------------------------------Macros--------------------------------------*/
+
+/* return the address of the refcnt in the family data */
+#define THERM_REFCNT(family_data) \
+	(&((struct w1_therm_family_data *)family_data)->refcnt)
+
+/*---------------------------Hardware Functions-----------------------------*/
+
+/** read_therm()
+ * @param sl pointer to the slave to read
+ * @param info pointer to a structure to store the read results
+ * @return 0 if success, -kernel error code otherwise
+ */
+static ssize_t read_therm(struct device *device,
+			struct w1_slave *sl, struct therm_info *info);
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
+/*-----------------------------Attributes declarations----------------------*/
+
+static DEVICE_ATTR_RW(w1_slave);
+static DEVICE_ATTR_RO(w1_seq);
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
+#endif /* __W1_THERM_H */
\ No newline at end of file
-- 
2.26.2

