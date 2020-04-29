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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F3C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7F0208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saNbGNcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgD2XBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2XBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:01:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E880C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:01:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so3874818wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9cHaY7Jw5bs3W1BBw6ymrf5pZKcT8cGbhL+y3oBN5UY=;
        b=saNbGNcAHnlMCFJMoMLXD9+D094UfddNV+Za2z6zyduh4LEtawT+jldgRAp5VpJ8Zh
         f+l5ISuxwiPjMXtAh1SM/IjtRUDk5vHWeZSgTBabeIrZzVQO5wLqn2DhNPiqvJz9ZGl7
         dVmgKEltPh+lx9WLoy+YwgnnkwOAmvBuXC1GE0z4AB2ueZPDsQDsjXHxzsxyVmsoVbgL
         KoHBLVBvH+DxvW/bTUTVLaVvgLBVxqjN2VnLlhclplparEuwZWY+KoAaYOXWm1gT7QFA
         DSrzzTyyY38vGOUqn20L0Lvqtbn3o0h7tESL7OUV9BzF9zX/3S0fUQvbxnHoJeQN1K7M
         gTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9cHaY7Jw5bs3W1BBw6ymrf5pZKcT8cGbhL+y3oBN5UY=;
        b=T4ntHaE3bKGoXvFXwFzMusueI1O3I8O19CiuiHulD+5i2nxc4B0G4ViKO/BgGGa60Q
         1psLVmL5Nf4BpRa3mTZegwfQU6TsVGiwIJchjCSy5YsRoFjQuQ0bgKMAK8Epx4I2mobf
         DuGV8jlSxbrUZix+4QX4U5xakoS40zCG6icrXJbSreOa0NankNSN2GfW3fYc6Tx6vu0w
         rGH7BDUX6LrDXcSp7rPBXBfXqUxNIudOR57EwAdtc4Ry/6XMVK3QRAdXahpnrMgNQhlu
         rr7YFIHutafbGB6L/HNaSNVEOe+hBYrncA2R3c0GRsBlOyjxFgB9NxvbiGYP3JWOA4ty
         0V7g==
X-Gm-Message-State: AGi0PuYMoQlNJUBN61gmCQqsYrM9EkOBw66OCiCUjXDrAkPCBfFCfIVb
        Z5HPK3UFA3ep+go6k5LDFQ8Ihhp8
X-Google-Smtp-Source: APiQypKZc3JDzNjH9Wkl/KteUhBFiaYBX/3vR8ZUoTCV3xYLIQJlStxhyEGD0kD4P9gGMGFbC4H8uA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr147583wmc.145.1588201273522;
        Wed, 29 Apr 2020 16:01:13 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id 5sm9630618wmg.34.2020.04.29.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:01:13 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v4 5/9] w1_therm: adding resolution sysfs entry
Date:   Thu, 30 Apr 2020 01:00:55 +0200
Message-Id: <20200429230055.199973-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding resolution sysfs entry (RW) to get or set the device resolution
Write values are managed as follow:
	* `9..12`: resolution to set in bit
	* Anything else: do nothing
Read values are :
	* `9..12`: device resolution in bit
	* `-xx`: xx is kernel error when reading the resolution

Only supported devices will show the sysfs entry. A new family has been
created for DS18S20 devices as they do not implement resolution feature.

The resolution of each device is check when the device is
discover by the bus master, in w1_therm_add_slave(struct w1_slave *).
The status is stored in the device structure w1_therm_family_data so
that the driver always knows the resolution of each device, which could
be used later to determine the required conversion duration (resolution
dependent).

The resolution is re evaluate each time a user read or write the sysfs
entry.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 .../ABI/testing/sysfs-driver-w1_therm         |  17 +
 drivers/w1/slaves/w1_therm.c                  | 404 ++++++++++++++----
 drivers/w1/slaves/w1_therm.h                  |  91 +++-
 3 files changed, 408 insertions(+), 104 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 9aaf625..e52dd6a 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -10,6 +10,23 @@ Users:		any user space application which wants to communicate with
 		w1_term device
 
 
+What:		/sys/bus/w1/devices/.../resolution
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) get or set the device resolution (on supported devices,
+		if not, this entry is not present). Note that the resolution
+		will be changed only in device RAM, so it will be cleared when
+		power is lost. Trigger a `save` to EEPROM command to keep
+		values after power-on. Read or write are :
+			* `9..12`: device resolution in bit
+			or resolution to set in bit
+			* `-xx`: xx is kernel error when reading the resolution
+			* Anything else: do nothing
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../w1_slave
 Date:		Apr 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index f10a210..382d679 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -37,23 +37,59 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
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
+ * ext_power (RO):
+ *	. -xx : xx is kernel error
+ *	. 0 : device parasite powered
+ *	. 1 : device externally powered
+ *
+ * resolution (RW):
+ *	. -xx	: xx is kernel error
+ *	. 9..12	: resolution set in bit (or resolution to set in bit)
+ */
+
+/*
+ * struct attribute for each device type
+ * This will enable entry in sysfs, it should match device capability
+ */
+
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
 	NULL,
 };
 
+static struct attribute *w1_ds18s20_attrs[] = {
+	&dev_attr_w1_slave.attr,
+	&dev_attr_ext_power.attr,
+	NULL,
+};
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
 	NULL,
 };
 
 /*------------------------------attribute groups----------------------------*/
 ATTRIBUTE_GROUPS(w1_therm);
+ATTRIBUTE_GROUPS(w1_ds18s20);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *dev, u32 attr, int channel,
 			long *val);
@@ -112,6 +148,13 @@ static struct w1_family_ops w1_therm_fops = {
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
@@ -122,7 +165,7 @@ static struct w1_family_ops w1_ds28ea00_fops = {
 /*--------------------family binding on operations struct-------------------*/
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
-	.fops = &w1_therm_fops,
+	.fops = &w1_ds18s20_fops,
 };
 
 static struct w1_family w1_therm_family_DS18B20 = {
@@ -148,124 +191,109 @@ static struct w1_family w1_therm_family_DS1825 = {
 /*----------------------Device capability description-----------------------*/
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
-		.f		= &w1_therm_family_DS18S20,
-		.convert	= w1_DS18S20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS18S20,
+		.convert		= w1_DS18S20_convert_temp,
+		.set_resolution	= NULL,	// no config register
+		.get_resolution	= NULL,	// no config register
+		.write_data		= w1_DS18S20_write_data,
+		.eeprom			= w1_therm_eeprom
 	},
 	{
-		.f		= &w1_therm_family_DS1822,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS1822,
+		.convert		= w1_DS18B20_convert_temp,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.eeprom			= w1_therm_eeprom
 	},
 	{
-		.f		= &w1_therm_family_DS18B20,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18B20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS18B20,
+		.convert		= w1_DS18B20_convert_temp,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.eeprom			= w1_therm_eeprom
 	},
 	{
-		.f		= &w1_therm_family_DS28EA00,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS28EA00,
+		.convert		= w1_DS18B20_convert_temp,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.eeprom			= w1_therm_eeprom
 	},
 	{
-		.f		= &w1_therm_family_DS1825,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS1825,
+		.convert		= w1_DS18B20_convert_temp,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
+		.eeprom			= w1_therm_eeprom
 	}
 };
 
 /*------------------------ Device dependent func---------------------------*/
 
-/* DS18S20 does not feature configuration register */
-static inline int w1_DS18S20_precision(struct device *device, int val)
+static inline int w1_DS18B20_write_data(struct w1_slave *sl,
+				const u8 *data)
 {
-	return 0;
+	return write_scratchpad(sl, data, 3);
 }
 
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
+		config_register = info.rom[4]; // config register is byte 4
+		config_register &= 0x60; // 0b01100000 keep only bit 5 & 6
+		config_register = (config_register >> 5);	// shift
+		config_register += 9; // add 9 the lowest resolution in bit
+		ret = (int) config_register;
 	}
-
-	mutex_unlock(&dev->bus_mutex);
-dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
-error:
 	return ret;
 }
 
@@ -298,6 +326,20 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 
 /*------------------------ Helpers Functions----------------------------*/
 
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
 static inline bool bus_mutex_lock(struct mutex *lock)
 {
 	int max_trying = W1_THERM_MAX_TRY;
@@ -318,14 +360,26 @@ static inline bool bus_mutex_lock(struct mutex *lock)
 }
 
 /*-------------------------Interface Functions------------------------------*/
+
 static int w1_therm_add_slave(struct w1_slave *sl)
 {
+	struct w1_therm_family_converter *sl_family_conv;
+
+	/* Allocate memory*/
 	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
 		GFP_KERNEL);
 	if (!sl->family_data)
 		return -ENOMEM;
 	atomic_set(THERM_REFCNT(sl->family_data), 1);
 
+	/* Get a pointer to the device specific function struct */
+	sl_family_conv = device_family(sl);
+	if (!sl_family_conv) {
+		kfree(sl->family_data);
+		return -ENODEV;
+	}
+	SLAVE_SPECIFIC_FUNC(sl) = sl_family_conv;
+
 	/* Getting the power mode of the device {external, parasite}*/
 	SLAVE_POWERMODE(sl) = read_powermode(sl);
 
@@ -335,6 +389,19 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 			"%s: Device has been added, but power_mode may be corrupted. err=%d\n",
 			 __func__, SLAVE_POWERMODE(sl));
 	}
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
 	return 0;
 }
 
@@ -472,6 +539,93 @@ error:
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
+		ret = -EAGAIN;	// Didn't acquire the mutex
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
+		ret = -EAGAIN;	// Didn't acquire the mutex
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
@@ -634,7 +788,7 @@ static ssize_t w1_slave_store(struct device *device,
 			if (val == 0)
 				ret = w1_therm_families[i].eeprom(device);
 			else
-				ret = w1_therm_families[i].precision(device,
+				ret = w1_therm_families[i].set_resolution(sl,
 									val);
 			break;
 		}
@@ -664,6 +818,66 @@ static ssize_t ext_power_show(struct device *device,
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
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
index e4f4c9e..b7f0cac 100644
--- a/drivers/w1/slaves/w1_therm.h
+++ b/drivers/w1/slaves/w1_therm.h
@@ -30,6 +30,7 @@
 
 /* ms delay to retry bus mutex */
 #define W1_THERM_RETRY_DELAY		20
+
 /*----------------------------------Structs---------------------------------*/
 
 /**
@@ -40,12 +41,14 @@
  * see helper : device_family()
  */
 struct w1_therm_family_converter {
-	u8			broken;
-	u16			reserved;
+	u8		broken;
+	u16		reserved;
 	struct w1_family	*f;
-	int			(*convert)(u8 rom[9]);
-	int			(*precision)(struct device *device, int val);
-	int			(*eeprom)(struct device *device);
+	int		(*convert)(u8 rom[9]);
+	int		(*eeprom)(struct device *device);
+	int		(*set_resolution)(struct w1_slave *sl, int val);
+	int		(*get_resolution)(struct w1_slave *sl);
+	int		(*write_data)(struct w1_slave *sl, const u8 *data);
 };
 
 /**
@@ -56,11 +59,14 @@ struct w1_therm_family_converter {
  *		1 device powered externally,
  *		0 device parasite powered,
  *		-x error or undefined
+ * @param resolution resolution in bit of the device, <O kernel error code
  */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
 	int external_powered;
+	int resolution;
+	struct w1_therm_family_converter *specific_functions;
 };
 
 /**
@@ -81,27 +87,50 @@ struct therm_info {
 /* write configuration to eeprom */
 static inline int w1_therm_eeprom(struct device *device);
 
-/* Set precision for conversion */
-static inline int w1_DS18B20_precision(struct device *device, int val);
-static inline int w1_DS18S20_precision(struct device *device, int val);
-
 /* The return value is millidegrees Centigrade. */
 static inline int w1_DS18B20_convert_temp(u8 rom[9]);
 static inline int w1_DS18S20_convert_temp(u8 rom[9]);
 
+static inline int w1_DS18B20_write_data(struct w1_slave *sl, const u8 *data);
+static inline int w1_DS18S20_write_data(struct w1_slave *sl, const u8 *data);
+
+static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val);
+static inline int w1_DS18B20_get_resolution(struct w1_slave *sl);
+
 /*-------------------------------Macros--------------------------------------*/
+
+/* return a pointer on the slave w1_therm_family_converter struct:
+ * always test family data existence before
+ */
+#define SLAVE_SPECIFIC_FUNC(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->specific_functions)
+
 /* return the power mode of the sl slave : 1-ext, 0-parasite, <0 unknown
  * always test family data existence before
  */
 #define SLAVE_POWERMODE(sl) \
 	(((struct w1_therm_family_data *)(sl->family_data))->external_powered)
 
+/* return the resolution in bit of the sl slave : <0 unknown
+ *	always test family data existence before
+ */
+#define SLAVE_RESOLUTION(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->resolution)
+
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
 
 /*-------------------------- Helpers Functions------------------------------*/
 
+/**  device_family()
+ *   @brief Helper function that provide a pointer
+ *		on the w1_therm_family_converter struct
+ *   @param sl represents the device
+ *   @return pointer to the slaves's family converter, NULL if not known
+ */
+static struct w1_therm_family_converter *device_family(struct w1_slave *sl);
+
 /** bus_mutex_lock() get the mutex & retry
  *  @param lock w1 bus mutex to get
  *  @return value true is mutex is acquired and lock, false otherwise
@@ -130,6 +159,22 @@ static int reset_select_slave(struct w1_slave *sl);
  */
 static ssize_t read_therm(struct device *device,
 			struct w1_slave *sl, struct therm_info *info);
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
 /** read_powermode()
  * @brief ask the device to get its power mode {external, parasite}
  * @param sl slave to be interrogated
@@ -166,11 +211,26 @@ static ssize_t w1_seq_show(struct device *device,
  */
 static ssize_t ext_power_show(struct device *device,
 	struct device_attribute *attr, char *buf);
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
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
 static DEVICE_ATTR_RO(ext_power);
+static DEVICE_ATTR_RW(resolution);
 
 /*--------------------------Interface Functions-----------------------------*/
 
@@ -187,4 +247,17 @@ static int w1_therm_add_slave(struct w1_slave *sl);
  */
 static void w1_therm_remove_slave(struct w1_slave *sl);
 
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
 #endif /* __W1_THERM_H */
\ No newline at end of file
-- 
2.26.2

