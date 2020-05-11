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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D439C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251C22075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r21J5PxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbgEKUhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:37:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:37:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so12647427wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=As+obOU8Avea+HqR1XY9g+H3vW0Q/Ubtjr0Vo6m9Hyc=;
        b=r21J5PxTEHhdxwjASeaKkd24LClYA9/WLH7wKkq/gYh4cNys19JNhPFqQ8dNsvcgDw
         rBJsmAI5scmkUnc0zIrDWQ7atb6b7NeG1Zv1k2F0kvUIuc65ijEiQtNPNfNLf/0FPQRS
         0/XpnEXziyCoGj1EsL7KSNjRdD6z5rjsLAaM66EqJQQlOF+BjmO586tYOFO68vmL4B6q
         UF21njzDa4rIhJZQQb3JZrik+pQNoqQw7TGUbEoPCkN/oHLDxA+QS6LqxgC6hxdSrCN2
         BYAyor/ePUbKKqqyPLIddblicLPQG8ZAl/9TOHa2fCZ+mnIHxBzolhhzuH8F07GIieUl
         dA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=As+obOU8Avea+HqR1XY9g+H3vW0Q/Ubtjr0Vo6m9Hyc=;
        b=G23wMvXDivu90XlDZoSwZAiWKn5paGKv7lQgt/ihBOhZnejDtUxuGsN+1Pbb31QR12
         hIxy3eC59e+KChe0kSnGmqBWQLtZukFNEuj/7rTSwnXXkRPwTonzEwuZRxXs9rVgdmp3
         WXvGfw3juIkwyi86+oQcfsdzKZmZz/tdz+d3diEvoVA57TurbRYLpDge2Dypzl+6pcOQ
         /5YPKUl9jJgEVsWBFUOi4MqLXyYlK0bHmQ6Ozy3eNnGR0aczhIhSb2poeGEy3gXM8QRA
         XiG3fGFBjau44oxHTMDkROrXflk0YG1yvwBlZEylHQnv42XO0c7G6N2JpMt04UQjdxln
         ewdg==
X-Gm-Message-State: AGi0PuZlWaxSuAWt3Vkcy7XVR7XdMG1T+I3Rtjg6wBDkSEw/G9pdrUs9
        7GKYnl/vtGnrpyoZr1YlKYk=
X-Google-Smtp-Source: APiQypKI0nO+kbZwOQ1jJC4R/gmLrfsm4iAd4l88ZJxrcAJKoieYHdIj1CnyssiQ/+GCVvogtrLSsg==
X-Received: by 2002:adf:e44a:: with SMTP id t10mr17205648wrm.414.1589229438717;
        Mon, 11 May 2020 13:37:18 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id w15sm3370628wmi.35.2020.05.11.13.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:37:17 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v7 5/9] w1_therm: adding resolution sysfs entry
Date:   Mon, 11 May 2020 22:37:08 +0200
Message-Id: <20200511203708.410649-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding resolution sysfs entry (RW) to get or set the device resolution
Write values are managed as follow:
	* '9..12': resolution to set in bit
	* Anything else: do nothing
Read values are :
	* '9..12': device resolution in bit
	* '-xx': xx is kernel error when reading the resolution

Only supported devices will show the sysfs entry. A new family has been
created for DS18S20 devices as they do not implement resolution feature.

The resolution of each device is check when the device is
discover by the bus master, in 'w1_therm_add_slave(struct w1_slave *)'.
The status is stored in the device structure w1_therm_family_data so
that the driver always knows the resolution of each device, which could
be used later to determine the required conversion duration (resolution
dependent).

The resolution is re evaluate each time a user read or write the sysfs
entry.

To avoid looping through the w1_therm_families at run time, the pointer
'specific_functions' is set up to the correct 'w1_therm_family_converter'
when the slave is added (which mean when it is discovered by the master).
This initialization is done by a helper function 
'device_family(struct w1_slave *sl)', and a dedicated macro 
'SLAVE_SPECIFIC_FUNC(sl)' allow the access to the specific function of the
slave device.

'read_scratchpad' and 'write_scratchpad' are the hardware functions to
access the device RAM, as per protocol specification.

It cancel the former 'precision' functions, which was only set and never
read (so not stored in the device struct).

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

 .../ABI/testing/sysfs-driver-w1_therm         |  17 +
 drivers/w1/slaves/w1_therm.c                  | 442 ++++++++++++++----
 2 files changed, 361 insertions(+), 98 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 99d73ee..7ed95e9 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -10,6 +10,23 @@ Users:		any user space application which wants to communicate with
 		w1_term device
 
 
+What:		/sys/bus/w1/devices/.../resolution
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) get or set the device resolution (on supported devices,
+		if not, this entry is not present). Note that the resolution
+		will be changed only in device RAM, so it will be cleared when
+		power is lost. Trigger a 'save' to EEPROM command to keep
+		values after power-on. Read or write are :
+			* '9..12': device resolution in bit
+			or resolution to set in bit
+			* '-xx': xx is kernel error when reading the resolution
+			* Anything else: do nothing
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../w1_slave
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index a148f2d..e30dab8 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -51,6 +51,13 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
 /* Helpers Macros */
 
+/*
+ * return a pointer on the slave w1_therm_family_converter struct:
+ * always test family data existence before using this macro
+ */
+#define SLAVE_SPECIFIC_FUNC(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->specific_functions)
+
 /*
  * return the power mode of the sl slave : 1-ext, 0-parasite, <0 unknown
  * always test family data existence before using this macro
@@ -58,6 +65,13 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 #define SLAVE_POWERMODE(sl) \
 	(((struct w1_therm_family_data *)(sl->family_data))->external_powered)
 
+/*
+ * return the resolution in bit of the sl slave : <0 unknown
+ * always test family data existence before using this macro
+ */
+#define SLAVE_RESOLUTION(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->resolution)
+
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
@@ -70,7 +84,8 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * @reserved: not used here
  * @f: pointer to the device binding structure
  * @convert: pointer to the device conversion function
- * @precision: pointer to the device precision function
+ * @set_resolution: pointer to the device set_resolution function
+ * @get_resolution: pointer to the device get_resolution function
  * @eeprom: pointer to eeprom function
  */
 struct w1_therm_family_converter {
@@ -78,7 +93,8 @@ struct w1_therm_family_converter {
 	u16		reserved;
 	struct w1_family	*f;
 	int		(*convert)(u8 rom[9]);
-	int		(*precision)(struct device *device, int val);
+	int		(*set_resolution)(struct w1_slave *sl, int val);
+	int		(*get_resolution)(struct w1_slave *sl);
 	int		(*eeprom)(struct device *device);
 };
 
@@ -89,11 +105,15 @@ struct w1_therm_family_converter {
  * @external_powered:	1 device powered externally,
  *				0 device parasite powered,
  *				-x error or undefined
+ * @resolution: current device resolution
+ * @specific_functions: pointer to struct of device specific function
  */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
 	int external_powered;
+	int resolution;
+	struct w1_therm_family_converter *specific_functions;
 };
 
 /**
@@ -126,6 +146,25 @@ struct therm_info {
  */
 static int reset_select_slave(struct w1_slave *sl);
 
+/**
+ * read_scratchpad() - read the data in device RAM
+ * @sl: pointer to the slave to read
+ * @info: pointer to a structure to store the read results
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int read_scratchpad(struct w1_slave *sl, struct therm_info *info);
+
+/**
+ * write_scratchpad() - write nb_bytes in the device RAM
+ * @sl: pointer to the slave to write in
+ * @data: pointer to an array of 3 bytes, as 3 bytes MUST be written
+ * @nb_bytes: number of bytes to be written (2 for DS18S20, 3 otherwise)
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
+
 /**
  * read_powermode() - Query the power mode of the slave
  * @sl: slave to retrieve the power mode
@@ -154,11 +193,18 @@ static ssize_t w1_seq_show(struct device *device,
 static ssize_t ext_power_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+static ssize_t resolution_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+static ssize_t resolution_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
 static DEVICE_ATTR_RO(ext_power);
+static DEVICE_ATTR_RW(resolution);
 
 /* Interface Functions declaration */
 
@@ -185,6 +231,13 @@ static void w1_therm_remove_slave(struct w1_slave *sl);
 /* Family attributes */
 
 static struct attribute *w1_therm_attrs[] = {
+	&dev_attr_w1_slave.attr,
+	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
+	NULL,
+};
+
+static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_ext_power.attr,
 	NULL,
@@ -194,12 +247,14 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
 	NULL,
 };
 
 /* Attribute groups */
 
 ATTRIBUTE_GROUPS(w1_therm);
+ATTRIBUTE_GROUPS(w1_ds18s20);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
 #if IS_REACHABLE(CONFIG_HWMON)
@@ -261,6 +316,13 @@ static struct w1_family_ops w1_therm_fops = {
 	.chip_info	= W1_CHIPINFO,
 };
 
+static struct w1_family_ops w1_ds18s20_fops = {
+	.add_slave	= w1_therm_add_slave,
+	.remove_slave	= w1_therm_remove_slave,
+	.groups		= w1_ds18s20_groups,
+	.chip_info	= W1_CHIPINFO,
+};
+
 static struct w1_family_ops w1_ds28ea00_fops = {
 	.add_slave	= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
@@ -272,7 +334,7 @@ static struct w1_family_ops w1_ds28ea00_fops = {
 
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
-	.fops = &w1_therm_fops,
+	.fops = &w1_ds18s20_fops,
 };
 
 static struct w1_family w1_therm_family_DS18B20 = {
@@ -300,92 +362,67 @@ static struct w1_family w1_therm_family_DS1825 = {
 /* write configuration to eeprom */
 static inline int w1_therm_eeprom(struct device *device);
 
-/* DS18S20 does not feature configuration register */
-static inline int w1_DS18S20_precision(struct device *device, int val)
+static inline int w1_DS18B20_write_data(struct w1_slave *sl,
+				const u8 *data)
 {
-	return 0;
+	return write_scratchpad(sl, data, 3);
 }
 
-/* Set precision for conversion */
-static inline int w1_DS18B20_precision(struct device *device, int val)
+static inline int w1_DS18S20_write_data(struct w1_slave *sl,
+				const u8 *data)
 {
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], crc;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
-	uint8_t precision_bits;
-	uint8_t mask = 0x60;
-
-	if (val > 12 || val < 9) {
-		pr_warn("Unsupported precision\n");
-		ret = -EINVAL;
-		goto error;
-	}
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
+	/* No config register */
+	return write_scratchpad(sl, data, 2);
+}
 
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
-	}
+static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
+{
+	int ret = -ENODEV;
+	u8 new_config_register[3];	/* array of data to be written */
+	struct therm_info info;
 
-	while (max_trying--) {
-		crc = 0;
+	/* resolution of DS18B20 is in the range [9..12] bits */
+	if (val < 9 || val > 12)
+		return -EINVAL;
+
+	val -= 9; /* soustract 9 the lowest resolution in bit */
+	val = (val << 5); /* shift to position bit 5 & bit 6 */
+
+	/*
+	 * Read the scratchpad to change only the required bits
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
 
-		if (!reset_select_slave(sl)) {
-			int count = 0;
+	/* Write data in the device RAM */
+	ret = w1_DS18B20_write_data(sl, new_config_register);
 
-			/* read values to only alter precision bits */
-			w1_write_8(dev, W1_READ_SCRATCHPAD);
-			count = w1_read_block(dev, rom, 9);
-			if (count != 9)
-				dev_warn(device, "w1_read_block() returned %u instead of 9.\n",	count);
+	return ret;
+}
 
-			crc = w1_calc_crc8(rom, 8);
-			if (rom[8] == crc) {
-				rom[4] = (rom[4] & ~mask) | (precision_bits & mask);
+static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
+{
+	int ret = -ENODEV;
+	u8 config_register;
+	struct therm_info info;
 
-				if (!reset_select_slave(sl)) {
-					w1_write_8(dev, W1_WRITE_SCRATCHPAD);
-					w1_write_8(dev, rom[2]);
-					w1_write_8(dev, rom[3]);
-					w1_write_8(dev, rom[4]);
+	ret = read_scratchpad(sl, &info);
 
-					break;
-				}
-			}
-		}
+	if (!ret)	{
+		config_register = info.rom[4]; /* config register is byte 4 */
+		config_register &= 0x60; /* 0b01100000 keep only bit 5 & 6 */
+		config_register = (config_register >> 5);	/* shift */
+		config_register += 9; /* add 9 the lowest resolution in bit */
+		ret = (int) config_register;
 	}
-
-	mutex_unlock(&dev->bus_mutex);
-dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
-error:
 	return ret;
 }
 
@@ -438,37 +475,62 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f		= &w1_therm_family_DS18S20,
 		.convert	= w1_DS18S20_convert_temp,
-		.precision	= w1_DS18S20_precision,
+		.set_resolution	= NULL,	/* no config register */
+		.get_resolution	= NULL,	/* no config register */
 		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS1822,
 		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
 		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS18B20,
 		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18B20_precision,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
 		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS28EA00,
 		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
 		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS1825,
 		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
+		.set_resolution	= w1_DS18B20_set_resolution,
+		.get_resolution	= w1_DS18B20_get_resolution,
 		.eeprom		= w1_therm_eeprom
 	}
 };
 
 /* Helpers Functions */
 
+/**
+ * device_family() - Retrieve a pointer on &struct w1_therm_family_converter
+ * @sl: slave to retrieve the device specific structure
+ *
+ * Return: pointer to the slaves's family converter, NULL if not known
+ */
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
 /**
  * bus_mutex_lock() - Acquire the mutex
  * @lock: w1 bus mutex to acquire
@@ -522,6 +584,9 @@ static inline int w1_convert_temp(u8 rom[9], u8 fid)
 
 static int w1_therm_add_slave(struct w1_slave *sl)
 {
+	struct w1_therm_family_converter *sl_family_conv;
+
+	/* Allocate memory */
 	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
 		GFP_KERNEL);
 	if (!sl->family_data)
@@ -529,6 +594,15 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 
 	atomic_set(THERM_REFCNT(sl->family_data), 1);
 
+	/* Get a pointer to the device specific function struct */
+	sl_family_conv = device_family(sl);
+	if (!sl_family_conv) {
+		kfree(sl->family_data);
+		return -ENODEV;
+	}
+	/* save this pointer to the device structure */
+	SLAVE_SPECIFIC_FUNC(sl) = sl_family_conv;
+
 	/* Getting the power mode of the device {external, parasite} */
 	SLAVE_POWERMODE(sl) = read_powermode(sl);
 
@@ -539,6 +613,18 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 			 __func__, SLAVE_POWERMODE(sl));
 	}
 
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
 	return 0;
 }
 
@@ -665,6 +751,93 @@ error:
 	return ret;
 }
 
+static int read_scratchpad(struct w1_slave *sl, struct therm_info *info)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
+
+	info->verdict = 0;
+
+	if (!sl->family_data)
+		goto error;
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
+
+	}
+	mutex_unlock(&dev_master->bus_mutex);
+
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
+
+static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
+
+	if (!sl->family_data)
+		goto error;
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
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			w1_write_8(dev_master, W1_WRITE_SCRATCHPAD);
+			w1_write_block(dev_master, data, nb_bytes);
+			ret = 0;
+		}
+	}
+	mutex_unlock(&dev_master->bus_mutex);
+
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
+
 static inline int w1_therm_eeprom(struct device *device)
 {
 	struct w1_slave *sl = dev_to_w1_slave(device);
@@ -815,26 +988,38 @@ static ssize_t w1_slave_store(struct device *device,
 			      struct device_attribute *attr, const char *buf,
 			      size_t size)
 {
-	int val, ret;
+	int val, ret = 0;
 	struct w1_slave *sl = dev_to_w1_slave(device);
-	int i;
 
-	ret = kstrtoint(buf, 0, &val);
-	if (ret)
-		return ret;
+	ret = kstrtoint(buf, 10, &val); /* converting user entry to int */
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
-		if (w1_therm_families[i].f->fid == sl->family->fid) {
-	/* zero value indicates to write current configuration to eeprom */
-			if (val == 0)
-				ret = w1_therm_families[i].eeprom(device);
-			else
-				ret = w1_therm_families[i].precision(device,
-									val);
-			break;
-		}
+	if (ret) {	/* conversion error */
+		dev_info(device,
+			"%s: conversion error. err= %d\n", __func__, ret);
+		return size;	/* return size to avoid call back again */
+	}
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return size;  /* No device family */
 	}
-	return ret ? : size;
+
+	if (val == 0)	/* val=0 : trigger a EEPROM save */
+		ret = SLAVE_SPECIFIC_FUNC(sl)->eeprom(device);
+	else {
+		if (SLAVE_SPECIFIC_FUNC(sl)->set_resolution)
+			ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
+	}
+
+	if (ret) {
+		dev_info(device,
+			"%s: writing error %d\n", __func__, ret);
+		/* return size to avoid call back again */
+	} else
+		SLAVE_RESOLUTION(sl) = val;
+
+	return size; /* always return size to avoid infinite calling */
 }
 
 static ssize_t ext_power_show(struct device *device,
@@ -859,6 +1044,67 @@ static ssize_t ext_power_show(struct device *device,
 	return sprintf(buf, "%d\n", SLAVE_POWERMODE(sl));
 }
 
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
+		return size;	/* return size to avoid call back again */
+	}
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return size;  /* No device family */
+	}
+
+	/*
+	 * Don't deal with the val enterd by user,
+	 * only device knows what is correct or not
+	 */
+
+	/* get the correct function depending on the device */
+	ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
+
+	if (ret) {
+		dev_info(device,
+			"%s: writing error %d\n", __func__, ret);
+		/* return size to avoid call back again */
+	} else
+		SLAVE_RESOLUTION(sl) = val;
+
+	return size;
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
-- 
2.26.2

