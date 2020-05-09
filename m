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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85275C47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5047D208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzMJdZ45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEJAAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEJAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:00:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A911C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 17:00:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m24so4350209wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YfVulpw3NReIg8YmI6KL+bmTAqQcndkpHsrgGC/Ns8=;
        b=PzMJdZ45zXNZskBzictGmsRclUrcDDkLboqvSg7gFoMuX+eXdoNekda930hALGh9Rr
         yypQ5cXTdsAAathBPFCzUFltdrPQBjwSBFb69oDrPq+LxZtXvhZ4CbuL46KXfmanylDr
         qJWLUSXANnePolzbM4ZhnBCPBJbfp3XLjwJrF71HuKxfxLIcSphuEXyylmgedVctTlvh
         epEZdy+vwcfNq6JAZ1/he6uyuakcFIh6/yAent31UycVNdat4vTd0ggK2HCb+8K5rt7b
         C1a/u16iAptFRIL6k8Hp2WIJxNyKU3sS1WmpTl9gUajpxYJ97wxPLYnaRctMtTOn6otW
         YvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YfVulpw3NReIg8YmI6KL+bmTAqQcndkpHsrgGC/Ns8=;
        b=US+f7L5w+FeZpYkot7neOpJU48F/Y6ug1N+Hm/+ggNkEOyCG4l6PY3Wq7530l8Agpp
         yD02N9EKYivfEcoxqJTZAIKJ0FWofz5lcs14MfPayhEIE9SpO49FjnkWsPKYyg8B7x0W
         Ffj3Xt1epwy1jIkzDEwz5KH7MREisYRqmiaDZJlaIWfCoSoVhr1NNBBJ69sht0R1ZcNh
         MXNm2ZYSrTjqqQf5LXiSGCgPvt+JuUU40a1ITc6beunXVw9n8rCQOrRbwxBeNxaOFgV/
         hxxFs4WuPr6VW3+cvgbM6RSBOrud7EGM334BjPyU6gEtw3T5B/VMXY2QIabiErRhG1SE
         H1Yw==
X-Gm-Message-State: AGi0Pua4/E3nQSWDoDGLivzB0jCGO/ZiPZGmNTwbyfHJSYQ8YiZaMcS7
        bzSlNYuvHa/7WFbi8X5INjM=
X-Google-Smtp-Source: APiQypIGgf9zxZCVXIYiXh7H7syGbs24IC1Du+9d5vg6OKgWewRl9BgRIt21Ri13FeMJ6Lsk2jkQXg==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr22306101wmj.125.1589068802779;
        Sat, 09 May 2020 17:00:02 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id k17sm19666645wmi.10.2020.05.09.17.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:00:02 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 5/9] w1_therm: adding resolution sysfs entry
Date:   Sun, 10 May 2020 01:59:54 +0200
Message-Id: <20200509235954.423946-1-akira215corp@gmail.com>
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

 .../ABI/testing/sysfs-driver-w1_therm         |  17 +
 drivers/w1/slaves/w1_therm.c                  | 436 ++++++++++++++----
 2 files changed, 356 insertions(+), 97 deletions(-)

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
index ab15cca..159bfc1 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -50,12 +50,24 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
 /*-------------------------------Macros-------------------------------------*/
 
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
@@ -73,7 +85,8 @@ struct w1_therm_family_converter {
 	u16		reserved;
 	struct w1_family	*f;
 	int		(*convert)(u8 rom[9]);
-	int		(*precision)(struct device *device, int val);
+	int		(*set_resolution)(struct w1_slave *sl, int val);
+	int		(*get_resolution)(struct w1_slave *sl);
 	int		(*eeprom)(struct device *device);
 };
 
@@ -91,6 +104,8 @@ struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
 	int external_powered;
+	int resolution;
+	struct w1_therm_family_converter *specific_functions;
 };
 
 /**
@@ -121,6 +136,21 @@ struct therm_info {
  */
 static int reset_select_slave(struct w1_slave *sl);
 
+/** read_scratchpad()
+ * \param sl pointer to the slave to read
+ * \param info pointer to a structure to store the read results
+ * \return 0 if success, -kernel error code otherwise
+ */
+static int read_scratchpad(struct w1_slave *sl, struct therm_info *info);
+
+/** write_scratchpad()
+ * \param sl pointer to the slave to read
+ * \param data pointer to an array of 3 bytes, as 3 bytes MUST be written
+ * \param nb_bytes Nb bytes to be written (2 for DS18S20, 3 for other devices)
+ * \return 0 if success, -kernel error code otherwise
+ */
+static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
+
 /** read_powermode()
  * \brief ask the device to get its power mode {external, parasite}
  * \param sl slave to be interrogated
@@ -160,11 +190,26 @@ static ssize_t w1_seq_show(struct device *device,
 static ssize_t ext_power_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+/** \brief A callback function to output the resolution of the device
+ *	Once done, it is stored in the sl->family_data to avoid doing the test
+ *	during data read
+ *  \return current resolution of the device in bit
+ */
+static ssize_t resolution_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
+/** \brief A callback function to store the user resolution in the device RAM
+ *  \param resolution in bit to be set
+ */
+static ssize_t resolution_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
 static DEVICE_ATTR_RO(ext_power);
+static DEVICE_ATTR_RW(resolution);
 
 /*--------------------Interface Functions declaration-----------------------*/
 
@@ -184,6 +229,13 @@ static void w1_therm_remove_slave(struct w1_slave *sl);
 /*------------------------------Family attributes---------------------------*/
 
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
@@ -193,12 +245,14 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_resolution.attr,
 	NULL,
 };
 
 /*------------------------------Attribute groups----------------------------*/
 
 ATTRIBUTE_GROUPS(w1_therm);
+ATTRIBUTE_GROUPS(w1_ds18s20);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
 #if IS_REACHABLE(CONFIG_HWMON)
@@ -260,6 +314,13 @@ static struct w1_family_ops w1_therm_fops = {
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
@@ -271,7 +332,7 @@ static struct w1_family_ops w1_ds28ea00_fops = {
 
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
-	.fops = &w1_therm_fops,
+	.fops = &w1_ds18s20_fops,
 };
 
 static struct w1_family w1_therm_family_DS18B20 = {
@@ -299,92 +360,66 @@ static struct w1_family w1_therm_family_DS1825 = {
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
 
@@ -423,37 +458,62 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f		= &w1_therm_family_DS18S20,
 		.convert	= w1_DS18S20_convert_temp,
-		.precision	= w1_DS18S20_precision,
+		.set_resolution	= NULL,	// no config register
+		.get_resolution	= NULL,	// no config register
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
 
 /*-------------------------- Helpers Functions------------------------------*/
 
+/**  device_family()
+ *   \brief Helper function that provide a pointer
+ *		on the w1_therm_family_converter struct
+ *   \param sl represents the device
+ *   \return pointer to the slaves's family converter, NULL if not known
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
 /** bus_mutex_lock() get the mutex & retry W1_THERM_MAX_TRY times
  *  \param lock w1 bus mutex to get
  *  \return value true is mutex is acquired and lock, false otherwise
@@ -492,6 +552,9 @@ static inline int w1_convert_temp(u8 rom[9], u8 fid)
 
 static int w1_therm_add_slave(struct w1_slave *sl)
 {
+	struct w1_therm_family_converter *sl_family_conv;
+
+	/* Allocate memory*/
 	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
 		GFP_KERNEL);
 	if (!sl->family_data)
@@ -499,6 +562,14 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 
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
 
@@ -509,6 +580,18 @@ static int w1_therm_add_slave(struct w1_slave *sl)
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
 
@@ -635,6 +718,93 @@ error:
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
@@ -784,26 +954,38 @@ static ssize_t w1_slave_store(struct device *device,
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
+		ret = SLAVE_SPECIFIC_FUNC(sl)->eeprom(device);
+	else {
+		if (SLAVE_SPECIFIC_FUNC(sl)->set_resolution)
+			ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
 	}
-	return ret ? : size;
+
+	if (ret) {
+		dev_info(device,
+			"%s: writing error %d\n", __func__, ret);
+		/* return size to avoid call back again*/
+	} else
+		SLAVE_RESOLUTION(sl) = val;
+
+	return size; /* always return size to avoid infinite calling */
 }
 
 static ssize_t ext_power_show(struct device *device,
@@ -828,6 +1010,66 @@ static ssize_t ext_power_show(struct device *device,
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
-- 
2.26.2

