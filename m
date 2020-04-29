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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF46C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB555206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcBGVUs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgD2Ndm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgD2Ndl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:33:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630CC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:33:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so2059377wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXB6zZ9DXZmJ3LKcKqhSZExWhUqDUML/Z1g/xhrNVoM=;
        b=GcBGVUs9CdVAs25xAilFzp6GOdlYBFsQuqIQyZOU8+IaEVVJ6NJ5uFkpgwhtUzQ6pq
         j5d8PRU6LnZhJNZbEKvEVYfW0PUCNDCivlW19N4H2NdXMAsVWb6ariHvGRqp5xo1pJ3I
         y4CeuaBnRzRcKVTxlOMX4436BHeFX8LUyYX60v3vg3U63uTWQqiBbyRCnWJl2CurcrFh
         HPw9Mqc4VkuRFJiq3WnM4lZLk8CYL45qeP5K8KH7VT7t4msJPzz7DkcvLEdsDE31ue0m
         NXpjIJpW1N/XsI2CtkZuq3mNpkN2LAyp9IAj88AE+HKYrN5bnKRb4p1c0UHHqMeNy9i8
         pt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXB6zZ9DXZmJ3LKcKqhSZExWhUqDUML/Z1g/xhrNVoM=;
        b=XdsOi05Olqhj50JoJEVRQWztdg3QdJiAGO4WG10JUdzihRa2Hmqd0+Pk6tdvHGIzob
         xvqYbCoflGkTQAOf5USY/NtsXf8QHKmDi1dwOXh5oNjsGQSOxZaWUdCXOyBa2UmCNG/4
         WVGMETc9F2JFsnCzVuB8gSCBec8fOuI0baIE2D9y/Q2PpHM+cbI6+GMyG6D/PcmLAjPS
         30HjsUz/68QSAN0B/jDdygtB6VKmK2MNKbtBNl+hmulZWqkniQEWIgZmuumSYOj2ECsQ
         fKWyuKtrCdZ4WEwQVvxRrdUhSZrzPAKLxBZmcJ/tKtE0vCFQdLZH1lMOwrzpqZifCejY
         2KoQ==
X-Gm-Message-State: AGi0PubiPaSMY2lLGENzJaeoxggoe02qMbzmP07nkFu/gAhmHniURnIm
        amBzkDIgzaWWoNmv41+Z/6Y=
X-Google-Smtp-Source: APiQypJm7CcVXzhr5GOhjb1YoDiedhAYt8vQ/fqFSsxeT2vlJp5dXkqS+HrqSbOtAorzwucxhas/Dw==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr3180030wmg.1.1588167217758;
        Wed, 29 Apr 2020 06:33:37 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id k184sm7990089wmf.9.2020.04.29.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:33:37 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v3 3/5] w1_therm: Optimizing read timing by checking device resolution. Updating documentation
Date:   Wed, 29 Apr 2020 15:33:20 +0200
Message-Id: <20200429133320.140458-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for enhacement of w1_therm module. Added features :
 - Optimized conversion time regarding to device resolution
 - Dedicated sysfs entry for, resolution set/get, eeprom save/restore,
	and additionnal temperature entry to ease user data collect.
 - Code optimization to mitigate bus traffic

The status of each device (power status and resolution if supported)
is stored in a dedicated structure in the driver, so that device are not
interrogated during temperature conversion process. The status is
evaluated as soon as a device is connected on the bus, and re evaluated
when user either set values either by get them, using the corresponding
sysfs entry.

A dedicated EEPROM sysfs entry allow the user to save or restore device
registers from/to device EEPROM.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly
with w1_therm_add_slavenew sysfs entries

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 .../ABI/testing/sysfs-driver-w1_therm         |  43 +
 drivers/w1/slaves/w1_therm.c                  | 785 +++++++++++++-----
 drivers/w1/slaves/w1_therm.h                  | 168 +++-
 3 files changed, 760 insertions(+), 236 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 9aaf625..279e13d 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,17 @@
+What:		/sys/bus/w1/devices/.../eeprom
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(WO) writing that file will either trigger a save of the
+		device data to its embedded EEPROM, either restore data
+		embedded in device EEPROM. Be aware that devices support
+		limited EEPROM writing cycles (typical 50k)
+			* `save`: save device RAM to EEPROM
+			* `restore`: restore EEPROM data in device RAM
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../ext_power
 Date:		Apr 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
@@ -10,6 +24,35 @@ Users:		any user space application which wants to communicate with
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
index a530853..3ddf2b1 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -37,23 +37,77 @@
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
+ *
+ */
+
+/*
+ * struct attribute for each device type
+ * This will enable entry in sysfs, it should match device capability
+ */
+
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
+	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
+	NULL,
+};
+
+static struct attribute *w1_ds18s20_attrs[] = {
+	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
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
@@ -112,6 +166,13 @@ static struct w1_family_ops w1_therm_fops = {
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
@@ -122,7 +183,7 @@ static struct w1_family_ops w1_ds28ea00_fops = {
 /*--------------------family binding on operations struct-------------------*/
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
-	.fops = &w1_therm_fops,
+	.fops = &w1_ds18s20_fops,
 };
 
 static struct w1_family w1_therm_family_DS18B20 = {
@@ -148,127 +209,144 @@ static struct w1_family w1_therm_family_DS1825 = {
 /*----------------------Device capability description-----------------------*/
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
-		.f		= &w1_therm_family_DS18S20,
-		.convert	= w1_DS18S20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS18S20,
+		.convert		= w1_DS18S20_convert_temp,
+		.get_conversion_time	= w1_DS18S20_convert_time,
+		.set_resolution	= NULL,	// no config register
+		.get_resolution	= NULL,	// no config register
+		.write_data		= w1_DS18S20_write_data,
 	},
 	{
-		.f		= &w1_therm_family_DS1822,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS1822,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
 	},
 	{
-		.f		= &w1_therm_family_DS18B20,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18B20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS18B20,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
 	},
 	{
-		.f		= &w1_therm_family_DS28EA00,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS28EA00,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
 	},
 	{
-		.f		= &w1_therm_family_DS1825,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
+		.f			= &w1_therm_family_DS1825,
+		.convert		= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
+		.write_data		= w1_DS18B20_write_data,
 	}
 };
 
 /*------------------------ Device dependent func---------------------------*/
 
-/* DS18S20 does not feature configuration register */
-static inline int w1_DS18S20_precision(struct device *device, int val)
+static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
 {
-	return 0;
-}
-
-static inline int w1_DS18B20_precision(struct device *device, int val)
-{
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
+	int ret;
 
-	memset(rom, 0, sizeof(rom));
+	if (!sl->family_data)
+		return -ENODEV;	/* device unknown */
 
-	/* translate precision to bitmask (see datasheet page 9) */
-	switch (val) {
+	/* return time in ms for conversion operation */
+	switch (SLAVE_RESOLUTION(sl)) {
 	case 9:
-		precision_bits = 0x00;
+		ret = 95;
 		break;
 	case 10:
-		precision_bits = 0x20;
+		ret = 190;
 		break;
 	case 11:
-		precision_bits = 0x40;
+		ret = 375;
 		break;
 	case 12:
 	default:
-		precision_bits = 0x60;
-		break;
+		ret = 750;
 	}
+	return ret;
+}
 
-	while (max_trying--) {
-		crc = 0;
+static inline int w1_DS18S20_convert_time(struct w1_slave *sl)
+{
+	(void)(sl);
+	return 750; /* always 750ms for DS18S20 */
+}
 
-		if (!reset_select_slave(sl)) {
-			int count = 0;
+static inline int w1_DS18B20_write_data(struct w1_slave *sl,
+				const u8 *data)
+{
+	return write_scratchpad(sl, data, 3);
+}
 
-			/* read values to only alter precision bits */
-			w1_write_8(dev, W1_READ_SCRATCHPAD);
-			count = w1_read_block(dev, rom, 9);
-			if (count != 9)
-				dev_warn(device, "w1_read_block() returned %u instead of 9.\n",	count);
+static inline int w1_DS18S20_write_data(struct w1_slave *sl,
+				const u8 *data)
+{
+	/* No config register */
+	return write_scratchpad(sl, data, 2);
+}
 
-			crc = w1_calc_crc8(rom, 8);
-			if (rom[8] == crc) {
-				rom[4] = (rom[4] & ~mask) | (precision_bits & mask);
+static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
+{
+	int ret = -ENODEV;
+	u8 new_config_register[3];	/* array of data to be written */
+	struct therm_info info;
 
-				if (!reset_select_slave(sl)) {
-					w1_write_8(dev, W1_WRITE_SCRATCHPAD);
-					w1_write_8(dev, rom[2]);
-					w1_write_8(dev, rom[3]);
-					w1_write_8(dev, rom[4]);
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
 
-					break;
-				}
-			}
-		}
-	}
+	/* Write data in the device RAM */
+	ret = w1_DS18B20_write_data(sl, new_config_register);
 
-	mutex_unlock(&dev->bus_mutex);
-dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
-error:
 	return ret;
 }
 
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
 static inline int w1_DS18B20_convert_temp(u8 rom[9])
 {
 	s16 t = le16_to_cpup((__le16 *)rom);
@@ -280,8 +358,10 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 {
 	int t, h;
 
-	if (!rom[7])
+	if (!rom[7]) {
+		pr_debug("%s: Invalid argument for conversion\n", __func__);
 		return 0;
+	}
 
 	if (rom[1] == 0)
 		t = ((s32)rom[0] >> 1)*1000;
@@ -298,6 +378,20 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 
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
@@ -316,15 +410,55 @@ static inline bool bus_mutex_lock(struct mutex *lock)
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
+static inline s8 int_to_short(int i)
+{
+	/* Prepare to cast to short by eliminating out of range values */
+	i = i > MAX_TEMP ? MAX_TEMP : i;
+	i = i < MIN_TEMP ? MIN_TEMP : i;
+	return (s8) i;
+}
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
 	/* Getting the power mode of the device {external, parasite}*/
 	SLAVE_POWERMODE(sl) = read_powermode(sl);
 
@@ -334,6 +468,19 @@ static int w1_therm_add_slave(struct w1_slave *sl)
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
 
@@ -347,6 +494,7 @@ static void w1_therm_remove_slave(struct w1_slave *sl)
 	}
 	kfree(sl->family_data);
 	sl->family_data = NULL;
+
 }
 
 /*------------------------Hardware Functions--------------------------*/
@@ -366,180 +514,254 @@ static int reset_select_slave(struct w1_slave *sl)
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
+					goto dec_refcnt;
 				}
 			}
+			ret = read_scratchpad(sl, info);
+			goto dec_refcnt;
+		}
 
-			if (!reset_select_slave(sl)) {
+	}
 
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				count = w1_read_block(dev, info->rom, 9);
-				if (count != 9) {
-					dev_warn(device, "w1_read_block() "
-						"returned %u instead of 9.\n",
-						count);
-				}
+mt_unlock:
+	mutex_unlock(&dev_master->bus_mutex);
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
+
+
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
 
-				info->crc = w1_calc_crc8(info->rom, 8);
+			w1_write_8(dev_master, W1_READ_SCRATCHPAD);
 
-				if (info->rom[8] == info->crc)
-					info->verdict = 1;
+			nb_bytes_read = w1_read_block(dev_master, info->rom, 9);
+			if (nb_bytes_read != 9) {
+				dev_warn(&sl->dev,
+					"w1_read_block(): returned %u instead of 9.\n",
+					nb_bytes_read);
+				ret = -EIO;
 			}
+
+			info->crc = w1_calc_crc8(info->rom, 8);
+
+			if (info->rom[8] == info->crc) {
+				info->verdict = 1;
+				ret = 0;
+			} else
+				ret = -EIO; /* CRC not checked */
 		}
 
-		if (info->verdict)
-			break;
 	}
+	mutex_unlock(&dev_master->bus_mutex);
 
-mt_unlock:
-	mutex_unlock(&dev->bus_mutex);
 dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
+	atomic_dec(THERM_REFCNT(sl->family_data));
 error:
 	return ret;
 }
 
-static inline int w1_therm_eeprom(struct device *device)
+static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes)
 {
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
 
-	if (!sl->family_data) {
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
 
-	memset(rom, 0, sizeof(rom));
-
-	while (max_trying--) {
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
 		if (!reset_select_slave(sl)) {
-			unsigned int tm = 10;
-			unsigned long sleep_rem;
+			w1_write_8(dev_master, W1_WRITE_SCRATCHPAD);
+			w1_write_block(dev_master, data, nb_bytes);
+			ret = 0;
+		}
+	}
+	mutex_unlock(&dev_master->bus_mutex);
 
-			/* check if in parasite mode */
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
 
-			if (reset_select_slave(sl))
-				continue;
+static int copy_scratchpad(struct w1_slave *sl)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_write, ret = -ENODEV;
+	bool strong_pullup;
 
-			/* 10ms strong pullup/delay after the copy command */
-			if (w1_strong_pullup == 2 ||
-			    (!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
+	if (!sl->family_data)
+		goto error;
 
-			w1_write_8(dev, W1_COPY_SCRATCHPAD);
+	t_write = W1_THERM_EEPROM_WRITE_DELAY;
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
 
-			if (external_power) {
-				mutex_unlock(&dev->bus_mutex);
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-				sleep_rem = msleep_interruptible(tm);
-				if (sleep_rem != 0) {
-					ret = -EINTR;
-					goto dec_refcnt;
-				}
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
 
-				ret = mutex_lock_interruptible(&dev->bus_mutex);
-				if (ret != 0)
-					goto dec_refcnt;
-			} else if (!w1_strong_pullup) {
-				sleep_rem = msleep_interruptible(tm);
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			unsigned long sleep_rem;
+
+			/* 10ms strong pullup (or delay) after the convert */
+			if (strong_pullup)
+				w1_next_pullup(dev_master, t_write);
+
+			w1_write_8(dev_master, W1_COPY_SCRATCHPAD);
+
+			if (strong_pullup) {
+				sleep_rem = msleep_interruptible(t_write);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
 					goto mt_unlock;
 				}
 			}
-
-			break;
+			ret = 0;
 		}
+
 	}
 
 mt_unlock:
-	mutex_unlock(&dev->bus_mutex);
+	mutex_unlock(&dev_master->bus_mutex);
 dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
+
+static int recall_eeprom(struct w1_slave *sl)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
+
+	if (!sl->family_data)
+		goto error;
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
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+
+			w1_write_8(dev_master, W1_RECALL_EEPROM);
+
+			ret = 1; /* Slave will pull line to 0 */
+			while (ret)
+				ret = 1 - w1_touch_bit(dev_master, 1);
+		}
+
+	}
+
+	mutex_unlock(&dev_master->bus_mutex);
+
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
 error:
 	return ret;
 }
@@ -591,27 +813,33 @@ static ssize_t w1_slave_show(struct device *device,
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
@@ -621,24 +849,62 @@ static ssize_t w1_slave_store(struct device *device,
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
-				ret = w1_therm_families[i].eeprom(device);
-			else
-				ret = w1_therm_families[i].precision(device,
-									val);
-			break;
-		}
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
+	ret = convert_t(sl, &info);
+
+	if (ret < 0) {
+		dev_dbg(device,
+			"%s: Temperature data may be corrupted. err=%d\n",
+			__func__, ret);
+		return 0;
 	}
-	return ret ? : size;
+
+	return sprintf(buf, "%d\n", temperature_from_RAM(sl, info.rom));
 }
 
 static ssize_t ext_power_show(struct device *device,
@@ -663,18 +929,97 @@ static ssize_t ext_power_show(struct device *device,
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
 
@@ -683,7 +1028,7 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
 			return ret;
 		}
 
-		*val = w1_convert_temp(info.rom, fid);
+		*val = temperature_from_RAM(sl, info.rom);
 		ret = 0;
 		break;
 	default:
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
index 2f975a4..487156f 100644
--- a/drivers/w1/slaves/w1_therm.h
+++ b/drivers/w1/slaves/w1_therm.h
@@ -26,11 +26,25 @@
 #include <linux/w1.h>
 
 /*----------------------------------Defines---------------------------------*/
+/* This command should be in public header w1.h but is not */
+#define W1_RECALL_EEPROM	0xB8
+
 /* Nb of try for an operation */
 #define W1_THERM_MAX_TRY		5
 
 /* ms delay to retry bus mutex */
 #define W1_THERM_RETRY_DELAY		20
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
 /*----------------------------------Structs---------------------------------*/
 
 /**
@@ -41,12 +55,14 @@
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
+	int		(*get_conversion_time)(struct w1_slave *sl);
+	int		(*set_resolution)(struct w1_slave *sl, int val);
+	int		(*get_resolution)(struct w1_slave *sl);
+	int		(*write_data)(struct w1_slave *sl, const u8 *data);
 };
 
 /**
@@ -57,11 +73,14 @@ struct w1_therm_family_converter {
  *		1 device powered externally,
  *		0 device parasite powered,
  *		-x error or undefined
+  * @param resolution resolution in bit of the device, <O kernel error code
  */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
 	int external_powered;
+	int resolution;
+	struct w1_therm_family_converter *specific_functions;
 };
 
 /**
@@ -79,36 +98,78 @@ struct therm_info {
 
 /*-----------------------Device specific functions-------------------------*/
 
-/* write configuration to eeprom */
-static inline int w1_therm_eeprom(struct device *device);
-
-/* Set precision for conversion */
-static inline int w1_DS18B20_precision(struct device *device, int val);
-static inline int w1_DS18S20_precision(struct device *device, int val);
-
-/* The return value is millidegrees Centigrade. */
 static inline int w1_DS18B20_convert_temp(u8 rom[9]);
 static inline int w1_DS18S20_convert_temp(u8 rom[9]);
 
+static inline int w1_DS18B20_convert_time(struct w1_slave *sl);
+static inline int w1_DS18S20_convert_time(struct w1_slave *sl);
+
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
+/** int_to_short() safe casting of int to short
+ * min/max values are defined by macro
+ * @param i integer to be converted to short
+ * @return a short in the range of min/max value
+ */
+static inline s8 int_to_short(int i);
+
 /*---------------------------Hardware Functions-----------------------------*/
 
 /**
@@ -124,13 +185,41 @@ static inline bool bus_mutex_lock(struct mutex *lock);
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
 /** read_powermode()
  * @brief ask the device to get its power mode {external, parasite}
  * @param sl slave to be interrogated
@@ -158,6 +247,16 @@ static ssize_t w1_slave_store(struct device *device,
 
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
@@ -167,11 +266,35 @@ static ssize_t w1_seq_show(struct device *device,
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
+
+/** @brief A callback function to let the user read/write device EEPROM
+ *  @param check EEPROM_CMD_WRITE & EEPROM_CMD_READ macros
+ */
+static ssize_t eeprom_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
+static DEVICE_ATTR_RW(resolution);
+static DEVICE_ATTR_WO(eeprom);
 
 /*--------------------------Interface Functions-----------------------------*/
 
@@ -188,4 +311,17 @@ static int w1_therm_add_slave(struct w1_slave *sl);
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
 #endif  /* __W1_THERM_H */
\ No newline at end of file
-- 
2.25.4

