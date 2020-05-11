Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3897C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA17820752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJEAE5y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbgEKUiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbgEKUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:38:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4082DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:38:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y16so5508410wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh5tRfp8hFoQbtcLOPwI0yX1TWzzDo4g9zDKAm7iihs=;
        b=ZJEAE5y7La4UsaMGKf9uQF9t1sOoWlDU6FWn2RKOnzgGOxfb6avGVZOhYH/Q7b8gjw
         wAcT/eRKTG+v50WX7NPueMTeA+1ZqnOzraYAkfJTXtXL5wGwWOUUaDdHOyQcv4cJJTRw
         TuxLvQi6DeJevbS048Ig3kUL9SPBX4X4eH7w/IzztMblBet8XR4nXa4vznSPS/yHL4F2
         gMYRWBGtllohpATfAeezigq3phrYn8ggSGWrU9xj4Ge4pXCVsok6vNLimzFc5ZX1tRuZ
         oK0+Ll7Mxacl1E7NhpT2dfwjYZ7pZ0IP1oEOaL7B5qGujVxh2dZOYtgm3cKQ0ReKz9PQ
         dZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hh5tRfp8hFoQbtcLOPwI0yX1TWzzDo4g9zDKAm7iihs=;
        b=AE1ykgDbpum7L2ed2ShcqPRCZ8uVQvGhFVlPuNkeW1eAL/gXGy/K0nkNqhczV/d82c
         bpYc8u8e/83tnQi2l0PM3h6n22XDUtkuMW/PzJvydlr2DbcHWK4WsCJor9/JOzMPoviy
         p0V2aqQ6oTNsye6+L15uPjBfqtsp1VD3gCD7D+dTkC2vbmOUNu8O7fzxtiJk3rIm2IBJ
         EP3V8IlagxWzt+f2sWz24qj6orLwSSbGIEVi1Tn/xCxGW5xckqGQdxU21xhz371v5miG
         8pwDHoSIt7YKeTyaNymfQ0bNgYGfdVRnqg4zFUb7JI+nUsn3nEnAMZPUNOZyrhgAtFo5
         8PtQ==
X-Gm-Message-State: AGi0PuY7Ney7gHctLvsrb21OWl5XFzU/FEfcaWpihYRAVq5WaX0alJx9
        7whCxOmKKGLk60GWW890hPY=
X-Google-Smtp-Source: APiQypIINkNkOPrhfNt1Qo2N4ScwQj3cOu/w1QAdksjjnqOkEgKISjpsh3+r9dZtI+kXROg7W1YumA==
X-Received: by 2002:adf:dc89:: with SMTP id r9mr19734235wrj.138.1589229492859;
        Mon, 11 May 2020 13:38:12 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id n24sm11914959wmi.40.2020.05.11.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:38:12 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v7 8/9] w1_therm: adding alarm sysfs entry
Date:   Mon, 11 May 2020 22:38:01 +0200
Message-Id: <20200511203801.411253-1-akira215corp@gmail.com>
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
Changes in v7:
- Formatting code comments and correcting comments mistakes

 .../ABI/testing/sysfs-driver-w1_therm         |  16 ++
 drivers/w1/slaves/w1_therm.c                  | 161 ++++++++++++++++++
 2 files changed, 177 insertions(+)

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
index 46756ea..fac9908 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -58,6 +58,9 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 #define EEPROM_CMD_WRITE    "save"	/* cmd for write eeprom sysfs */
 #define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
 
+#define MIN_TEMP	-55	/* min temperature that can be mesured */
+#define MAX_TEMP	125	/* max temperature that can be mesured */
+
 /* Helpers Macros */
 
 /*
@@ -96,6 +99,7 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * @get_conversion_time: pointer to the device conversion time function
  * @set_resolution: pointer to the device set_resolution function
  * @get_resolution: pointer to the device get_resolution function
+ * @write_data: pointer to the device writing function (2 or 3 bytes)
  */
 struct w1_therm_family_converter {
 	u8		broken;
@@ -105,6 +109,7 @@ struct w1_therm_family_converter {
 	int		(*get_conversion_time)(struct w1_slave *sl);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
+	int		(*write_data)(struct w1_slave *sl, const u8 *data);
 };
 
 /**
@@ -239,6 +244,12 @@ static ssize_t resolution_store(struct device *device,
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
@@ -247,6 +258,7 @@ static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
+static DEVICE_ATTR_RW(alarms);
 
 /* Interface Functions declaration */
 
@@ -278,6 +290,7 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -286,6 +299,7 @@ static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -296,6 +310,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -556,6 +571,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18S20_convert_time,
 		.set_resolution		= NULL,	/* no config register */
 		.get_resolution		= NULL,	/* no config register */
+		.write_data			= w1_DS18S20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS1822,
@@ -563,6 +579,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS18B20,
@@ -570,6 +587,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS28EA00,
@@ -577,6 +595,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS1825,
@@ -584,6 +603,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	}
 };
 
@@ -678,6 +698,26 @@ static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
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
@@ -1251,6 +1291,127 @@ static ssize_t eeprom_store(struct device *device,
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
+		th = scratchpad.rom[2]; /* TH is byte 2 */
+		tl = scratchpad.rom[3]; /* TL is byte 3 */
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
+	/*
+	 * Read the scratchpad to change only the required bits
+	 * (th : byte 2 - tl: byte 3)
+	 */
+	ret = read_scratchpad(sl, &info);
+	if (!ret) {
+		new_config_register[0] = th;	/* Byte 2 */
+		new_config_register[1] = tl;	/* Byte 3 */
+		new_config_register[2] = info.rom[4];/* Byte 4 */
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

