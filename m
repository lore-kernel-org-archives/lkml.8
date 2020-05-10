Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A163EC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6957F20731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghfVnnT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEJOSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729124AbgEJOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:18:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1765C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:18:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so7577076wrt.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0x+fRt5Q+ggIohL0zxhI7duLwGdSNRarcY4DgRotwM=;
        b=ghfVnnT/eZs4zw14VWyPSn4/kd3WZR8BPt7wgbM55j4tBSsQJkjOHn336+j6WTl/G7
         hvKMbduyyWnLvnI1ao4tUM/vhV18AIXCZ6R23oFjkYlTG+rJDwf3Jj1aOGN5Y286kAmI
         Bo0PdJXlAxMv+xmV5C8RpNrARoXy0Of9l3bNQphdPW36omTSlkFEmKSQAe91gzwPaId2
         0vpfMGQoGhvRLeT4A9Wf3Hy5Ie5K0cvF0atjxRHNEhoIa9PHInaq1vBgCJ5vTXz8KvZt
         0YXI+cd0ye5JRmLRmBxzZCLjDIGY4sZNAR+VPVXK5WucGUlfbwYtgBlXH2IXpIEBKc9L
         1rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0x+fRt5Q+ggIohL0zxhI7duLwGdSNRarcY4DgRotwM=;
        b=qpKfK1hsh22S1JXd6qzDl+ClkLILG8ZJqvr0CMwrs6TZHs8HoB877VP3pINGlgHSAf
         7ttGViRL0/yCnQBOVWqPsBA3tzVT7JA6oJyevrVn/WaSWQ9r0FlaiYTlDvmI57WxO+Nw
         prDvB69rW84I0KGCP9Vtext4dpbygaf0XGha0l9dbk5pMZMIX/bTqkWaSETAY+KQPbmG
         F5yd+FtEPa0IR/QRChFKusxyZR7oO55rCooL85jT7fpjJ2BHmOW0JkRgGbUaS4JeJ/PX
         l949AGbXRvQDoiUK/blrDyRVoV98sK+MU0FNuWOjZym2AhAxQa1bnsHRr2akgjzL+5Yk
         1Kdg==
X-Gm-Message-State: AGi0PuZVWr7JKW7AHNbjHY+tF1s4QXUqOalIdPV3x+3pT/Wqf8H14eDY
        q5YViNjrBu9PZ4UpmSHLhYc=
X-Google-Smtp-Source: APiQypJDJIdW+o52t4FWfTbFRW662mxTeWoC0kUE9EWa/WSPmVIGJ3/BIVxanKepXaVAajQ9GV7oGA==
X-Received: by 2002:adf:e788:: with SMTP id n8mr12153858wrm.317.1589120282311;
        Sun, 10 May 2020 07:18:02 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id a24sm22451040wmb.24.2020.05.10.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:18:01 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 7/9] w1_therm: optimizing temperature read timings
Date:   Sun, 10 May 2020 16:17:53 +0200
Message-Id: <20200510141753.173765-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimizing temperature reading by reducing waiting conversion time
according to device resolution settings, as per device specification.
This is device dependent as not all the devices supports resolution
setting, so it has been added in device family structures.

The process to read the temperature on the device has been adapted in a
new function 'convert_t()', which replace the former 'read_therm()', is
introduce to deal with this timing. Strong pull up is also applied during
the required time, according to device power status needs and
'strong_pullup' module parameter.

'temperature_from_RAM()' function is introduced to get the correct
temperature computation (device dependent) from device RAM data.

An new sysfs entry has been added to ouptut only temperature. The old
entry w1_slave has been kept for compatibility, without changing its
output format.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include
Changes in v6:
- Formatting code comments according to kernel-doc requirements

 .../ABI/testing/sysfs-driver-w1_therm         |  12 +
 drivers/w1/slaves/w1_therm.c                  | 284 ++++++++++++------
 2 files changed, 201 insertions(+), 95 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 8b7ee89..6ffd3e3 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -41,6 +41,18 @@ Users:		any user space application which wants to communicate with
 		w1_term device
 
 
+What:		/sys/bus/w1/devices/.../temperature
+Date:		May 2020
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
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index c90a91f..93855ca 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -89,6 +89,7 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * @reserved: not used here
  * @f: pointer to the device binding structure
  * @convert: pointer to the device conversion function
+ * @get_conversion_time: pointer to the device conversion time function
  * @set_resolution: pointer to the device set_resolution function
  * @get_resolution: pointer to the device get_resolution function
  */
@@ -97,6 +98,7 @@ struct w1_therm_family_converter {
 	u16		reserved;
 	struct w1_family	*f;
 	int		(*convert)(u8 rom[9]);
+	int		(*get_conversion_time)(struct w1_slave *sl);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
 };
@@ -149,6 +151,15 @@ struct therm_info {
  */
 static int reset_select_slave(struct w1_slave *sl);
 
+/**
+ * convert_t() - Query the device for temperature conversion and read
+ * @sl: pointer to the slave to read
+ * @info: pointer to a structure to store the read results
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int convert_t(struct w1_slave *sl, struct therm_info *info);
+
 /**
  * read_scratchpad() - read the data in device RAM
  * @sl: pointer to the slave to read
@@ -209,6 +220,9 @@ static ssize_t w1_slave_store(struct device *device,
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+static ssize_t temperature_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 static ssize_t ext_power_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
@@ -225,6 +239,7 @@ static ssize_t eeprom_store(struct device *device,
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
@@ -255,6 +270,7 @@ static void w1_therm_remove_slave(struct w1_slave *sl);
 
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
@@ -263,6 +279,7 @@ static struct attribute *w1_therm_attrs[] = {
 
 static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
 	NULL,
@@ -271,6 +288,7 @@ static struct attribute *w1_ds18s20_attrs[] = {
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
@@ -385,6 +403,37 @@ static struct w1_family w1_therm_family_DS1825 = {
 
 /* Device dependent func */
 
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
@@ -461,8 +510,10 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 {
 	int t, h;
 
-	if (!rom[7])
+	if (!rom[7]) {
+		pr_debug("%s: Invalid argument for conversion\n", __func__);
 		return 0;
+	}
 
 	if (rom[1] == 0)
 		t = ((s32)rom[0] >> 1)*1000;
@@ -481,34 +532,39 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
-		.f		= &w1_therm_family_DS18S20,
-		.convert	= w1_DS18S20_convert_temp,
-		.set_resolution	= NULL,	// no config register
-		.get_resolution	= NULL,	// no config register
+		.f				= &w1_therm_family_DS18S20,
+		.convert			= w1_DS18S20_convert_temp,
+		.get_conversion_time	= w1_DS18S20_convert_time,
+		.set_resolution		= NULL,	// no config register
+		.get_resolution		= NULL,	// no config register
 	},
 	{
-		.f		= &w1_therm_family_DS1822,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS1822,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	},
 	{
-		.f		= &w1_therm_family_DS18B20,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS18B20,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	},
 	{
-		.f		= &w1_therm_family_DS28EA00,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS28EA00,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	},
 	{
-		.f		= &w1_therm_family_DS1825,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS1825,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	}
 };
 
@@ -562,15 +618,45 @@ static inline bool bus_mutex_lock(struct mutex *lock)
 	return true;
 }
 
-static inline int w1_convert_temp(u8 rom[9], u8 fid)
+/**
+ * conversion_time() - get the Tconv for the slave
+ * @sl: device to get the conversion time
+ *
+ * On device supporting resolution settings, conversion time depend
+ * on the resolution setting. This helper function get the slave timing,
+ * depending on its current setting.
+ *
+ * Return: conversion time in ms, negative values are kernel error code
+ */
+static inline int conversion_time(struct w1_slave *sl)
 {
-	int i;
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->get_conversion_time(sl);
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i)
-		if (w1_therm_families[i].f->fid == fid)
-			return w1_therm_families[i].convert(rom);
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
 
-	return 0;
+	return -ENODEV;  /* No device family */
+}
+
+/**
+ * temperature_from_RAM() - Convert the read info to temperature
+ * @sl: device that sent the RAM data
+ * @rom: read value on the slave device RAM
+ *
+ * Device dependent, the function bind the correct computation method.
+ *
+ * Return: temperature in 1/1000degC, 0 on error.
+ */
+static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
+{
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->convert(rom);
+
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
+
+	return 0;  /* No device family */
 }
 
 /* Interface Functions */
@@ -650,96 +736,74 @@ static int reset_select_slave(struct w1_slave *sl)
 	return 0;
 }
 
-static ssize_t read_therm(struct device *device,
-			  struct w1_slave *sl, struct therm_info *info)
+static int convert_t(struct w1_slave *sl, struct therm_info *info)
 {
-	struct w1_master *dev = sl->master;
-	u8 external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_conv;
+	int ret = -ENODEV;
+	bool strong_pullup;
 
-	if (!family_data) {
-		ret = -ENODEV;
+	if (!sl->family_data)
 		goto error;
-	}
 
-	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
-		goto dec_refcnt;
+	/* get conversion duration device and id dependent */
+	t_conv = conversion_time(sl);
 
 	memset(info->rom, 0, sizeof(info->rom));
 
-	while (max_trying--) {
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
+
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
+
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
@@ -970,27 +1034,33 @@ static ssize_t w1_slave_show(struct device *device,
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
@@ -1033,6 +1103,31 @@ static ssize_t w1_slave_store(struct device *device,
 	return size; /* always return size to avoid infinite calling */
 }
 
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
+}
+
 static ssize_t ext_power_show(struct device *device,
 	struct device_attribute *attr, char *buf)
 {
@@ -1141,12 +1236,11 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
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
 
@@ -1155,7 +1249,7 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
 			return ret;
 		}
 
-		*val = w1_convert_temp(info.rom, fid);
+		*val = temperature_from_RAM(sl, info.rom);
 		ret = 0;
 		break;
 	default:
-- 
2.26.2

