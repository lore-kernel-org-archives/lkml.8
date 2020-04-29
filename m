Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405A7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A474208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYtgmvau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgD2XCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2XCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:02:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F0C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:02:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so6076061wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4r45ilX3gBcGCiuJH0tMW4pWLLOnkd2bRLn+l472Kw=;
        b=rYtgmvaur8yO6kE6JrgdPBep6nRVXcWaoJV8o0/WdQNFkepPI3/WfHr9nDbd35Jb2G
         wMgHjGJAVfCN6zVrigmY1iXt0shxxMIhWIJM4jdtZVqaNx7Jx95ua6eH76CSEbnjyC8E
         vtkPOFH+xOkZkohNyCUBbdM01Gbc/jefHrI8vQ82cn506ugFHb5wI5b7+F5RfxZBIGVO
         P4+gI7E9E1C1lenrAA/UOXhlNsn7hwYvIAq5+8hxK54su+qBYZmcKPnp7jf0K+giIb2E
         zATSFSyOJ4p2TO2D/svmDv4ge63Ee4j+XPqkj4gd0xC0nAx25Zo7zGO/PU/vAaOhy39G
         hlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4r45ilX3gBcGCiuJH0tMW4pWLLOnkd2bRLn+l472Kw=;
        b=TTw0qAR9oJ4BAMfjdaa+N4EdwZOZGLGK9BEF6dc/JIRzrbpg7DDcUuMgtz5XbWDNDm
         CpdlFYgNsCzCGmc4PZyau4WjhqCzBf1481GOeew7VpA+JjRsA/NAaZp32Z8HHysFbLiI
         O/3Hn0yN5tdLz4yseATuJErP9Etd/lUB0bu8/PIEEXyd04idm/CUg1VZVGdz46DkBskD
         4iipZ//E3wTmiQ+WWpGkaKESdO5fVzwRQHfJnpgnlm6zA/pHGD2AYYWFGDZgFBKTlUy0
         K4bygPDdfr4kBGprMPRuV2BnjHoi3zCcohw5E9EkZNKuew+UQbZLniUzFqbYf3lMtiSM
         /Z8g==
X-Gm-Message-State: AGi0PuYQYyyLUxxX7OI4hy+J6lnFn2BBvr23IUEp0XX9tD6t8LB8+lPh
        mBxVch3Fp8vqFn1UNgVe3ezBix6z
X-Google-Smtp-Source: APiQypJfYOwR69GZm5C3hXsw628cP53azSwMXuhbE3S0GPf7lonD19gam79H5lQAv6VZW/vPRcpLuw==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr190458wmi.52.1588201320537;
        Wed, 29 Apr 2020 16:02:00 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id h6sm9672093wmf.31.2020.04.29.16.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:02:00 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v4 7/9] w1_therm: optimizing temperature reading timings
Date:   Thu, 30 Apr 2020 01:01:47 +0200
Message-Id: <20200429230147.200512-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimizing temperature reading by reducing waiting conversion time
according to device resolution settings, as per device specification.
This is device dependent as not all the devices supports resolution
setting, so it has been added in device family structures.

The process to read the temperature on the device has been adapted in
a new function convert_t() to deal with this timing. Strong pull up is
also applied during the required time, according to device power status
needs and strong_pullup module parameter.

An new sysfs entry has been added to ouptut only temperature. The old
entry w1_slave has been kept for compatibility, without changing its
output format.

Updating doc in Documentation/ABI/testing/sysfs-driver-w1_therm
accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 .../ABI/testing/sysfs-driver-w1_therm         |  12 +
 drivers/w1/slaves/w1_therm.c                  | 266 +++++++++++-------
 drivers/w1/slaves/w1_therm.h                  |  34 ++-
 3 files changed, 215 insertions(+), 97 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 9dcbbed..279e13d 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -41,6 +41,18 @@ Users:		any user space application which wants to communicate with
 		w1_term device
 
 
+What:		/sys/bus/w1/devices/.../temperature
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RO) return the temperature in 1/1000 degC.
+		Note that the conversion duration depend on the resolution (if
+		device support this feature). It takes 94ms in 9bits
+		resolution, 750ms for 12bits.
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../w1_slave
 Date:		Apr 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index caa4615..2c89d9f 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -49,6 +49,10 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  *			(i.e. TH, TL and config register)
  *		.9..12: set the device resolution in RAM (if supported)
  *		.Else : do nothing
+ *
+ * temperature (RO):
+ *	. temperature in 1/1000°
+ *
  * ext_power (RO):
  *	. -xx : xx is kernel error
  *	. 0 : device parasite powered
@@ -73,6 +77,7 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
@@ -81,13 +86,16 @@ static struct attribute *w1_therm_attrs[] = {
 
 static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
 	NULL,
 };
+
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
@@ -202,6 +210,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f			= &w1_therm_family_DS18S20,
 		.convert		= w1_DS18S20_convert_temp,
+		.get_conversion_time	= w1_DS18S20_convert_time,
 		.set_resolution	= NULL,	// no config register
 		.get_resolution	= NULL,	// no config register
 		.write_data		= w1_DS18S20_write_data,
@@ -209,6 +218,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f			= &w1_therm_family_DS1822,
 		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
@@ -216,6 +226,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f			= &w1_therm_family_DS18B20,
 		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
@@ -223,6 +234,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f			= &w1_therm_family_DS28EA00,
 		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
@@ -230,6 +242,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f			= &w1_therm_family_DS1825,
 		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
@@ -238,6 +251,37 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 
 /*------------------------ Device dependent func---------------------------*/
 
+static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
+{
+	int ret;
+
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
+	}
+	return ret;
+}
+
+static inline int w1_DS18S20_convert_time(struct w1_slave *sl)
+{
+	(void)(sl);
+	return 750; /* always 750ms for DS18S20 */
+}
+
 static inline int w1_DS18B20_write_data(struct w1_slave *sl,
 				const u8 *data)
 {
@@ -312,8 +356,10 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 {
 	int t, h;
 
-	if (!rom[7])
+	if (!rom[7]) {
+		pr_debug("%s: Invalid argument for conversion\n", __func__);
 		return 0;
+	}
 
 	if (rom[1] == 0)
 		t = ((s32)rom[0] >> 1)*1000;
@@ -363,6 +409,28 @@ static inline bool bus_mutex_lock(struct mutex *lock)
 	return true;
 }
 
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
 /*-------------------------Interface Functions------------------------------*/
 
 static int w1_therm_add_slave(struct w1_slave *sl)
@@ -438,107 +506,74 @@ static int reset_select_slave(struct w1_slave *sl)
 	return 0;
 }
 
-static inline int w1_convert_temp(u8 rom[9], u8 fid)
+static int convert_t(struct w1_slave *sl, struct therm_info *info)
 {
-	int i;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_conv;
+	int ret = -ENODEV;
+	bool strong_pullup;
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i)
-		if (w1_therm_families[i].f->fid == fid)
-			return w1_therm_families[i].convert(rom);
+	if (!sl->family_data)
+		goto error;
 
-	return 0;
-}
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
 
-static ssize_t read_therm(struct device *device,
-			  struct w1_slave *sl, struct therm_info *info)
-{
-	struct w1_master *dev = sl->master;
-	u8 external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	/* get conversion duration device and id dependent */
+	t_conv = conversion_time(sl);
 
-	if (!family_data) {
-		ret = -ENODEV;
-		goto error;
-	}
+	memset(info->rom, 0, sizeof(info->rom));
 
-	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
 		goto dec_refcnt;
+	}
 
-	memset(info->rom, 0, sizeof(info->rom));
-
-	while (max_trying--) {
+	while (max_trying-- && ret) { /* ret should be 0 */
 
 		info->verdict = 0;
 		info->crc = 0;
-
+		/* safe version to select slave */
 		if (!reset_select_slave(sl)) {
-			int count = 0;
-			unsigned int tm = 750;
 			unsigned long sleep_rem;
 
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
-
-			if (reset_select_slave(sl))
-				continue;
-
 			/* 750ms strong pullup (or delay) after the convert */
-			if (w1_strong_pullup == 2 ||
-					(!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
-
-			w1_write_8(dev, W1_CONVERT_TEMP);
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
-				}
-			}
-
-			if (!reset_select_slave(sl)) {
-
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				count = w1_read_block(dev, info->rom, 9);
-				if (count != 9) {
-					dev_warn(device, "w1_read_block() "
-						"returned %u instead of 9.\n",
-						count);
+					goto dec_refcnt;
 				}
-
-				info->crc = w1_calc_crc8(info->rom, 8);
-
-				if (info->rom[8] == info->crc)
-					info->verdict = 1;
 			}
+			ret = read_scratchpad(sl, info);
+			goto dec_refcnt;
 		}
 
-		if (info->verdict)
-			break;
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
@@ -769,27 +804,33 @@ static ssize_t w1_slave_show(struct device *device,
 	u8 *family_data = sl->family_data;
 	int ret, i;
 	ssize_t c = PAGE_SIZE;
-	u8 fid = sl->family->fid;
 
-	ret = read_therm(device, sl, &info);
-	if (ret)
-		return ret;
+	ret = convert_t(sl, &info);
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
+			temperature_from_RAM(sl, info.rom));
+
 	ret = PAGE_SIZE - c;
 	return ret;
 }
@@ -799,24 +840,62 @@ static ssize_t w1_slave_store(struct device *device,
 			      size_t size)
 {
 	struct w1_slave *sl = dev_to_w1_slave(device);
-	int val, ret, i;
+	int val, ret = 0;
 
-	ret = kstrtoint(buf, 10, &val);
-	if (ret)
-		return ret;
+	ret = kstrtoint(buf, 10, &val); /* converting user entry to int */
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
-		if (w1_therm_families[i].f->fid == sl->family->fid) {
-	/* zero value indicates to write current configuration to eeprom */
-			if (val == 0)
-				ret = copy_scratchpad(sl);
-			else
-				ret = w1_therm_families[i].set_resolution(sl,
-									val);
-			break;
-		}
+	if (ret) {	/* conversion error */
+		dev_info(device,
+			"%s: conversion error. err= %d\n", __func__, ret);
+		return size;	/* return size to avoid call back again*/
 	}
-	return ret ? : size;
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
+	ret = convert_t(sl, &info);
+
+	if (ret < 0) {
+		dev_dbg(device,
+			"%s: Temperature data may be corrupted. err=%d\n",
+			__func__, ret);
+		return 0;
+	}
+
+	return sprintf(buf, "%d\n", temperature_from_RAM(sl, info.rom));
 }
 
 static ssize_t ext_power_show(struct device *device,
@@ -927,12 +1006,11 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
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
 
@@ -941,7 +1019,7 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
 			return ret;
 		}
 
-		*val = w1_convert_temp(info.rom, fid);
+		*val = temperature_from_RAM(sl, info.rom);
 		ret = 0;
 		break;
 	default:
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
index 7202627..6929991 100644
--- a/drivers/w1/slaves/w1_therm.h
+++ b/drivers/w1/slaves/w1_therm.h
@@ -54,6 +54,7 @@ struct w1_therm_family_converter {
 	u16		reserved;
 	struct w1_family	*f;
 	int		(*convert)(u8 rom[9]);
+	int		(*get_conversion_time)(struct w1_slave *sl);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
 	int		(*write_data)(struct w1_slave *sl, const u8 *data);
@@ -95,6 +96,9 @@ struct therm_info {
 static inline int w1_DS18B20_convert_temp(u8 rom[9]);
 static inline int w1_DS18S20_convert_temp(u8 rom[9]);
 
+static inline int w1_DS18B20_convert_time(struct w1_slave *sl);
+static inline int w1_DS18S20_convert_time(struct w1_slave *sl);
+
 static inline int w1_DS18B20_write_data(struct w1_slave *sl, const u8 *data);
 static inline int w1_DS18S20_write_data(struct w1_slave *sl, const u8 *data);
 
@@ -141,6 +145,20 @@ static struct w1_therm_family_converter *device_family(struct w1_slave *sl);
  */
 static inline bool bus_mutex_lock(struct mutex *lock);
 
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
 /*---------------------------Hardware Functions-----------------------------*/
 
 /**
@@ -156,13 +174,12 @@ static inline bool bus_mutex_lock(struct mutex *lock);
  */
 static int reset_select_slave(struct w1_slave *sl);
 
-/** read_therm()
+/** convert_t()
  * @param sl pointer to the slave to read
  * @param info pointer to a structure to store the read results
  * @return 0 if success, -kernel error code otherwise
  */
-static ssize_t read_therm(struct device *device,
-			struct w1_slave *sl, struct therm_info *info);
+static int convert_t(struct w1_slave *sl, struct therm_info *info);
 
 /** read_scratchpad()
  * @param sl pointer to the slave to read
@@ -220,6 +237,16 @@ static ssize_t w1_slave_store(struct device *device,
 
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
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
 /** @brief A callback function to output the power mode of the device
  *	Once done, it is stored in the sl->family_data to avoid doing the test
  *	during data read
@@ -254,6 +281,7 @@ static ssize_t eeprom_store(struct device *device,
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
-- 
2.26.2

