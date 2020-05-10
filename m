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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0BC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716E420731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/L9T0Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgEJOSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728940AbgEJOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:18:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:18:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so7553765wre.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G01K//RxGlI7OXBlyTnZG0G84koDyLlZg3K7GgEttCE=;
        b=J/L9T0Llprinp/pQKhGYfbj2vxQG7EIeB7JWhAsWcwne107q8OAmXG1RPGBWtfzoQg
         lRRtfC631DQE6sUbQYmowlO99smguVe9HTf+dgFkuGJlczemyeBhi8/XWC7lAR0PcPlu
         fJqECF9tGaWrZzziBj4iKtRpZru1VxXScHKGxvOhdSNmx8g+jW1AeDDE4gRX7Kx71cdO
         kyJJB0zDswQMcLfUX83WIaHJaLGwNfPecEcSnaFVR80FZnmPkZ9qsHKO7jYL0iBZ5I8m
         6xF2LYoyXu8Uty/pewOyWFEv44VKlSkDrBFPevIb/lsltf/Mbyj+e6WMrl/D/1aXYC8y
         ESxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G01K//RxGlI7OXBlyTnZG0G84koDyLlZg3K7GgEttCE=;
        b=p7gnDgdxpzL5tf8+2qL9NJkL3YQQgMoSGDUQwefjpr6j1ZSpU3D71tdIUp+eQgipnr
         NN6KnbXyxT79Wvifgfe3/WcPWWvVmLluFhn3BODA4rIwcFNZudJoFVMn02uBv1e6s/kv
         0vkUWt0w8UcuM6//tqlcrQaITmp7pk2mtMN8dS++4/QSkTIjW1zfM2jIrL3kwNgfwbwm
         DS/WqEJ1GbISTtBrWNDJl8Yoc2mx7Tgwu/EDNfxzjAwOkOqk4vLrljijql0ryY7np8po
         10TmNF1R3zX/dSJ10kRv05pA+lbYN7DHKSSZKGnYoy2wrcO+nygPW8EXNep3imVkdLLa
         cCsg==
X-Gm-Message-State: AGi0PuYHInB/xz40Wv15oSEdHr+vAHVG0UKtv/0AxzSjbErnvlHGIyIY
        39mAHiC7A82z1cnYS5oSQp8=
X-Google-Smtp-Source: APiQypJRO8+zzgT3WdZFTuHSYwOTZK+sqi0iNisxtjwsSXL0aji5cQ78USdPjSLyB7XHoPFo6K1+2Q==
X-Received: by 2002:adf:decb:: with SMTP id i11mr14688357wrn.172.1589120297215;
        Sun, 10 May 2020 07:18:17 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id a10sm14104586wrp.0.2020.05.10.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:18:16 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 8/9] w1_therm: adding alarm sysfs entry
Date:   Sun, 10 May 2020 16:18:10 +0200
Message-Id: <20200510141810.173949-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device alarms settings by a dedicated sysfs entry alarms (RW):
read or write TH and TL in the device RAM. Checking devices in alarm
state could be performed using the master search command.

As alarms temperature level are store in a 8 bit register on the device
and are signed values, a safe cast shall be performed using the min and
max temperature that device are able to measure. This is done by 
int_to_short inline function.

A 'write_data' field is added in the device structure, to bind the
correct writing function, as some devices may have 2 or 3 bytes RAM.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include
Changes in v6:
- Formatting code comments according to kernel-doc requirements

 .../ABI/testing/sysfs-driver-w1_therm         |  16 ++
 drivers/w1/slaves/w1_therm.c                  | 160 ++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 6ffd3e3..f289520 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,19 @@
+What:		/sys/bus/w1/devices/.../alarms
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) read or write TH and TL (Temperature High an Low) alarms.
+		Values shall be space separated and in the device range
+		(typical -55 degC to 125 degC), if not values will be trimmed
+		to device min/max capabilities. Values are integer as they are
+		stored in a 8bit register in the device. Lowest value is
+		automatically put to TL. Once set, alarms could be search at
+		master level, refer to Documentation/w1/w1_generic.rst for
+		detailed information
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../eeprom
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 93855ca..1301b16 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -57,6 +57,9 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 #define EEPROM_CMD_WRITE    "save"	/* cmd for write eeprom sysfs */
 #define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
 
+#define MIN_TEMP	-55	/* min temperature that can be mesured */
+#define MAX_TEMP	125	/* max temperature that can be mesured */
+
 /* Helpers Macros */
 
 /* return a pointer on the slave w1_therm_family_converter struct:
@@ -92,6 +95,7 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * @get_conversion_time: pointer to the device conversion time function
  * @set_resolution: pointer to the device set_resolution function
  * @get_resolution: pointer to the device get_resolution function
+ * @write_data: pointer to the device writing function (2 or 3 bytes)
  */
 struct w1_therm_family_converter {
 	u8		broken;
@@ -101,6 +105,7 @@ struct w1_therm_family_converter {
 	int		(*get_conversion_time)(struct w1_slave *sl);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
+	int		(*write_data)(struct w1_slave *sl, const u8 *data);
 };
 
 /**
@@ -235,6 +240,12 @@ static ssize_t resolution_store(struct device *device,
 static ssize_t eeprom_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
+static ssize_t alarms_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+static ssize_t alarms_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
@@ -243,6 +254,7 @@ static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
+static DEVICE_ATTR_RW(alarms);
 
 /* Interface Functions declaration */
 
@@ -274,6 +286,7 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -282,6 +295,7 @@ static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -292,6 +306,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -537,6 +552,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18S20_convert_time,
 		.set_resolution		= NULL,	// no config register
 		.get_resolution		= NULL,	// no config register
+		.write_data			= w1_DS18S20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS1822,
@@ -544,6 +560,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS18B20,
@@ -551,6 +568,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS28EA00,
@@ -558,6 +576,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS1825,
@@ -565,6 +584,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	}
 };
 
@@ -659,6 +679,26 @@ static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
 	return 0;  /* No device family */
 }
 
+/**
+ * int_to_short() - Safe casting of int to short
+ *
+ * @i: integer to be converted to short
+ *
+ * Device register use 1 byte to store signed integer.
+ * This helper function convert the int in a signed short,
+ * using the min/max values that device can measure as limits.
+ * min/max values are defined by macro.
+ *
+ * Return: a short in the range of min/max value
+ */
+static inline s8 int_to_short(int i)
+{
+	/* Prepare to cast to short by eliminating out of range values */
+	i = i > MAX_TEMP ? MAX_TEMP : i;
+	i = i < MIN_TEMP ? MIN_TEMP : i;
+	return (s8) i;
+}
+
 /* Interface Functions */
 
 static int w1_therm_add_slave(struct w1_slave *sl)
@@ -1230,6 +1270,126 @@ static ssize_t eeprom_store(struct device *device,
 	return size;
 }
 
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
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
-- 
2.26.2

