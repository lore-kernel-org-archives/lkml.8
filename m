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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A2C47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212F9208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxpc1GJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgEJACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEJACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:02:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C1C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 17:02:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so14667441wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PODLJbAL3aKNTz2wq5tBbpZjGMHrYYHJUquDM1A2nPM=;
        b=Lxpc1GJ6igO899mfM8veSPa445fpec7jh1DTO4txJxIYJxNbdzX+xFVMkjCbmvcKs5
         lqVIH+Fj+BqqM0kuPt4om6Y7NPXJlWqtiNgoPZPIp4TJ+oeugTX59b7QXhNPryp8EnTz
         Kin2oIyWiib/sw6CSlGmFI0bj20U/cAU9HiNJi6vkI6J/n/ldXZuUnZGoIOhPUxQvSuG
         iCH+3ulZIYw9hV6I3QwZ0bupWu4onLQSs9d/MSq/bwXtgbEYj3u2iMybar69PK8gcXvk
         gaR1rFH39+Rp0tmXSleMN5NP+WsTOwufg10AoEhq9GU1nTTeV5h3rikW7KXRG9DGTDdS
         yO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PODLJbAL3aKNTz2wq5tBbpZjGMHrYYHJUquDM1A2nPM=;
        b=M2s0b/lG5suRLZBQLwvhLbMXZ0z/jROZ/JZ223RgK32qo71Q9PGNO3l/9akvhk56PE
         DKNl2sMYE2vpxxdQRU5rJ04DbVWJXnrGQ0Gv5izaZ4IzhcOD3hridWAcuYy044ZYqjKM
         e62EkK150YA2lXjk6cx6HQO8l+jXOhhnNGnVAluTVMUmNNwzkHDPT0BKVwG3u0rkQrzq
         pZF/yzqVrygGZrHMKZD+XkhThz2Du7SMdL2aiGj5jX7MwRdU8hNg2d6A21eTpc14JBEB
         OWIt47jguFEUjCTvP0HWVZRegpln/f/AHwpG84n0gBa1W93ocq3RdNRxUDgCbb9rG+P5
         hr7g==
X-Gm-Message-State: AGi0PuYu0wgtMa1elfoJk3tAz4IqSY4zHphoVyEgqkMbGHPTs6VpVu9I
        utI5a+EpL5R6F5dl9xNJYjfnz5Ke
X-Google-Smtp-Source: APiQypKtJyeoDEKlq+Tb43+QKOA0LPNzkW9UHbXmKUvAcJ6u3f10kLX7MjAvi4erWZKx0cz7ZT++1Q==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr7189002wmk.167.1589068961173;
        Sat, 09 May 2020 17:02:41 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id m15sm19751050wmc.35.2020.05.09.17.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:02:40 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 8/9] w1_therm: adding alarm sysfs entry
Date:   Sun, 10 May 2020 02:02:32 +0200
Message-Id: <20200510000232.425500-1-akira215corp@gmail.com>
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

 .../ABI/testing/sysfs-driver-w1_therm         |  16 ++
 drivers/w1/slaves/w1_therm.c                  | 158 ++++++++++++++++++
 2 files changed, 174 insertions(+)

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
index 2955cae..cd65d0b 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -57,6 +57,9 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 #define EEPROM_CMD_WRITE    "save"	/* cmd for write eeprom sysfs */
 #define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
 
+#define MIN_TEMP	-55	/* min temperature that can be mesured */
+#define MAX_TEMP	125	/* max temperature that can be mesured */
+
 /*-------------------------------Macros-------------------------------------*/
 
 /* return a pointer on the slave w1_therm_family_converter struct:
@@ -97,6 +100,7 @@ struct w1_therm_family_converter {
 	int		(*get_conversion_time)(struct w1_slave *sl);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
+	int		(*write_data)(struct w1_slave *sl, const u8 *data);
 };
 
 /**
@@ -248,6 +252,18 @@ static ssize_t resolution_store(struct device *device,
 static ssize_t eeprom_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
+/** \brief A callback function to set the alarms level
+ *  \param device represents the master device
+ */
+static ssize_t alarms_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+/** \brief A callback function to get the alarms level
+ *  \return Low and High alarm, separate by one space
+ */
+static ssize_t alarms_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
@@ -256,6 +272,7 @@ static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
+static DEVICE_ATTR_RW(alarms);
 
 /*--------------------Interface Functions declaration-----------------------*/
 
@@ -280,6 +297,7 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -288,6 +306,7 @@ static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -298,6 +317,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -543,6 +563,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18S20_convert_time,
 		.set_resolution		= NULL,	// no config register
 		.get_resolution		= NULL,	// no config register
+		.write_data			= w1_DS18S20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS1822,
@@ -550,6 +571,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS18B20,
@@ -557,6 +579,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS28EA00,
@@ -564,6 +587,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	},
 	{
 		.f				= &w1_therm_family_DS1825,
@@ -571,6 +595,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.get_conversion_time	= w1_DS18B20_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data			= w1_DS18B20_write_data,
 	}
 };
 
@@ -651,6 +676,19 @@ static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
 	return 0;  /* No device family */
 }
 
+/** int_to_short() safe casting of int to short
+ * min/max values are defined by macro
+ * \param i integer to be converted to short
+ * \return a short in the range of min/max value
+ */
+static inline s8 int_to_short(int i)
+{
+	/* Prepare to cast to short by eliminating out of range values */
+	i = i > MAX_TEMP ? MAX_TEMP : i;
+	i = i < MIN_TEMP ? MIN_TEMP : i;
+	return (s8) i;
+}
+
 /*-------------------------Interface Functions------------------------------*/
 
 static int w1_therm_add_slave(struct w1_slave *sl)
@@ -1221,6 +1259,126 @@ static ssize_t eeprom_store(struct device *device,
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

