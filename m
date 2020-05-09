Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40014C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078632083B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqGTj2e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEIX6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEIX6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:58:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41828C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:58:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so6307290wrb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSIOPqtLnvEKdanssth/BaJAONxQcQYyfSmADMo1HAI=;
        b=bqGTj2e4NGIci5jIimNABwfokiHM2N+EuLfii3nRoKEK03AtgB5FqhFsLhkZf2SWKs
         5298WLqqi4yWOQnghDCzh6n8sRne2AydRx6ssURnGUiozhHj/5qBpOWJKwMocw3g6RyC
         KqSDuPP54kXQL9jp9biT8JELr6ZB+t6Zy7U6T9F92oZL5aYnzYOtUAOlpLpOj3oZy1WB
         rhiZJ7OOKYHtn/Zv3l+si1UcggQD3nukzHeAzgoUUia85rQCua6wWIkRaXyQAeB5C2te
         BwO8N448bsGAnqPm/SAaPZhHTCQVg6uMzR58b8mYCx8C2ag/SYUYSqwLHaK1iucLvBZa
         E8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSIOPqtLnvEKdanssth/BaJAONxQcQYyfSmADMo1HAI=;
        b=I6xhfaoYYNT22K82xkkdTbD2u3JmBc0USb2kn089i81mA3ShZvo96RqeWLFxaNb4T5
         Y+bLeje433GHSYaq1vgP4tAfggwxR8bU5IRwJJJhvHppfl9dHpD2YAlXrjYrx/5lnWAs
         N2SAZJ/5w+Kej7Lzujlu4imBurzqQHsEPJjphgRTyubY6R/oDJYjIJ+mCJhMp67d37N9
         sYzeOAVSSEfRs5x2Vlvn8fBjLk+o+9dTSoFQKdLRQYlYzqjoImqgrD80IZDTo+Sv+zFZ
         LOZzaLFivhlg5nwAt1aCvYo0qmvPSYD6JnLMNF5QkjBFf3/Gc7HIPONqQP3bzvNcQOb9
         GJKw==
X-Gm-Message-State: AGi0PuZbGoyk4JsKq0aWYkx9umqQ66IIW/5QErSgY0Ikc7AruElqWCNs
        3azBQIB5GxxpfFE+6DFLKQo=
X-Google-Smtp-Source: APiQypJoDohUcTs8oSofaBCaZOoWApTcedTB1E996OFEXUO5Y9nzj3Vo83hd0BKo/QDy62U9Kzi+tQ==
X-Received: by 2002:adf:8023:: with SMTP id 32mr11260794wrk.247.1589068693830;
        Sat, 09 May 2020 16:58:13 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id o66sm8946011wma.2.2020.05.09.16.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:58:13 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 1/9] w1_therm: adding code comments and code reordering
Date:   Sun, 10 May 2020 01:57:42 +0200
Message-Id: <20200509235742.422652-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding code comments to split code in dedicated parts. After the global
declarations (defines, macros and function declarations), code is organized
as follow :
 - Device and family dependent structures and functions
 - Interfaces functions
 - Helpers functions
 - Hardware functions
 - Sysfs interface functions

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Main motivation on the first patch of this serie is to clean up the code,
document it and reorder it to prepare the next patches, which are clearer
after this.

One main point is to keep all device/family dependent code gather at the
beginning to ease adding new devices if required.

Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include

 drivers/w1/slaves/w1_therm.c | 403 ++++++++++++++++++++---------------
 1 file changed, 237 insertions(+), 166 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 18f08d7..f7147b2 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -41,55 +41,99 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
+/*-------------------------------Macros-------------------------------------*/
+
+/* return the address of the refcnt in the family data */
+#define THERM_REFCNT(family_data) \
+	(&((struct w1_therm_family_data *)family_data)->refcnt)
+
+/*----------------------------------Structs---------------------------------*/
+
+/**
+ * struct w1_therm_family_converter
+ * \brief Used to bind standard function call
+ * to device specific function
+ * it could be routed to NULL if device don't support feature
+ */
+struct w1_therm_family_converter {
+	u8		broken;
+	u16		reserved;
+	struct w1_family	*f;
+	int		(*convert)(u8 rom[9]);
+	int		(*precision)(struct device *device, int val);
+	int		(*eeprom)(struct device *device);
+};
+
+/**
+ * struct w1_therm_family_data
+ * \param rom data
+ * \param refcnt ref count
+ * \param external_powered
+ *		1 device powered externally,
+ *		0 device parasite powered,
+ *		-x error or undefined
+ * \param resolution resolution in bit of the device, <O kernel error code
+ */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
 };
 
+/**
+ * struct therm_info
+ * \brief Only used to store temperature reading
+ * \param rom RAM device data
+ * \param crc computed crc from rom
+ * \param verdict 1 crc checked, 0 crc not matching
+ */
 struct therm_info {
 	u8 rom[9];
 	u8 crc;
 	u8 verdict;
 };
 
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
+/*-----------------------Interface sysfs declaration------------------------*/
 
+/** \brief A callback function to output the temperature Old way
+ *  read temperature and return the result in the sys file
+ *  This has been kept for compatibility
+ */
 static ssize_t w1_slave_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+/** \brief A callback function to set the resolution Old way
+ *  This has been kept for compatibility
+ *  \param 0, it write config in the EEPROM
+ *  \param 9..12, it set the resolution in the RAM
+ */
 static ssize_t w1_slave_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+/*-----------------------------Attributes declarations----------------------*/
+
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
 
+/*--------------------Interface Functions declaration-----------------------*/
+
+/** w1_therm_add_slave() - Called each time a search discover a new device
+ * \brief used to initialized slave (family datas)
+ * \param sl slave just discovered
+ * \return 0 - If success, negative kernel code otherwise
+ */
+static int w1_therm_add_slave(struct w1_slave *sl);
+
+/** w1_therm_remove_slave() - Called each time a slave is removed
+ * \brief used to free memory
+ * \param sl slave to be removed
+ */
+static void w1_therm_remove_slave(struct w1_slave *sl);
+
+/*------------------------------Family attributes---------------------------*/
+
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	NULL,
@@ -101,6 +145,8 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	NULL,
 };
 
+/*------------------------------Attribute groups----------------------------*/
+
 ATTRIBUTE_GROUPS(w1_therm);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
@@ -154,6 +200,8 @@ static const struct hwmon_chip_info w1_chip_info = {
 #define W1_CHIPINFO	NULL
 #endif
 
+/*------------------------------Family operations---------------------------*/
+
 static struct w1_family_ops w1_therm_fops = {
 	.add_slave	= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
@@ -168,6 +216,8 @@ static struct w1_family_ops w1_ds28ea00_fops = {
 	.chip_info	= W1_CHIPINFO,
 };
 
+/*--------------------Family binding on operations struct-------------------*/
+
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
 	.fops = &w1_therm_fops,
@@ -193,138 +243,18 @@ static struct w1_family w1_therm_family_DS1825 = {
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
+/*----------------------------Device dependent func-------------------------*/
 
 /* write configuration to eeprom */
 static inline int w1_therm_eeprom(struct device *device);
 
-/* Set precision for conversion */
-static inline int w1_DS18B20_precision(struct device *device, int val);
-static inline int w1_DS18S20_precision(struct device *device, int val);
-
-/* The return value is millidegrees Centigrade. */
-static inline int w1_DS18B20_convert_temp(u8 rom[9]);
-static inline int w1_DS18S20_convert_temp(u8 rom[9]);
-
-static struct w1_therm_family_converter w1_therm_families[] = {
-	{
-		.f		= &w1_therm_family_DS18S20,
-		.convert	= w1_DS18S20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
-	},
-	{
-		.f		= &w1_therm_family_DS1822,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
-	},
-	{
-		.f		= &w1_therm_family_DS18B20,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18B20_precision,
-		.eeprom		= w1_therm_eeprom
-	},
-	{
-		.f		= &w1_therm_family_DS28EA00,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
-	},
-	{
-		.f		= &w1_therm_family_DS1825,
-		.convert	= w1_DS18B20_convert_temp,
-		.precision	= w1_DS18S20_precision,
-		.eeprom		= w1_therm_eeprom
-	}
-};
-
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
-
 /* DS18S20 does not feature configuration register */
 static inline int w1_DS18S20_precision(struct device *device, int val)
 {
 	return 0;
 }
 
+/* Set precision for conversion */
 static inline int w1_DS18B20_precision(struct device *device, int val)
 {
 	struct w1_slave *sl = dev_to_w1_slave(device);
@@ -407,6 +337,7 @@ error:
 	return ret;
 }
 
+/* The return value is millidegrees Centigrade. */
 static inline int w1_DS18B20_convert_temp(u8 rom[9])
 {
 	s16 t = le16_to_cpup((__le16 *)rom);
@@ -414,6 +345,7 @@ static inline int w1_DS18B20_convert_temp(u8 rom[9])
 	return t*1000/16;
 }
 
+/* The return value is millidegrees Centigrade. */
 static inline int w1_DS18S20_convert_temp(u8 rom[9])
 {
 	int t, h;
@@ -434,6 +366,43 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 	return t;
 }
 
+/*----------------------Device capability description-----------------------*/
+
+static struct w1_therm_family_converter w1_therm_families[] = {
+	{
+		.f		= &w1_therm_family_DS18S20,
+		.convert	= w1_DS18S20_convert_temp,
+		.precision	= w1_DS18S20_precision,
+		.eeprom		= w1_therm_eeprom
+	},
+	{
+		.f		= &w1_therm_family_DS1822,
+		.convert	= w1_DS18B20_convert_temp,
+		.precision	= w1_DS18S20_precision,
+		.eeprom		= w1_therm_eeprom
+	},
+	{
+		.f		= &w1_therm_family_DS18B20,
+		.convert	= w1_DS18B20_convert_temp,
+		.precision	= w1_DS18B20_precision,
+		.eeprom		= w1_therm_eeprom
+	},
+	{
+		.f		= &w1_therm_family_DS28EA00,
+		.convert	= w1_DS18B20_convert_temp,
+		.precision	= w1_DS18S20_precision,
+		.eeprom		= w1_therm_eeprom
+	},
+	{
+		.f		= &w1_therm_family_DS1825,
+		.convert	= w1_DS18B20_convert_temp,
+		.precision	= w1_DS18S20_precision,
+		.eeprom		= w1_therm_eeprom
+	}
+};
+
+/*-------------------------- Helpers Functions------------------------------*/
+
 static inline int w1_convert_temp(u8 rom[9], u8 fid)
 {
 	int i;
@@ -445,31 +414,32 @@ static inline int w1_convert_temp(u8 rom[9], u8 fid)
 	return 0;
 }
 
-static ssize_t w1_slave_store(struct device *device,
-			      struct device_attribute *attr, const char *buf,
-			      size_t size)
+/*-------------------------Interface Functions------------------------------*/
+
+static int w1_therm_add_slave(struct w1_slave *sl)
 {
-	int val, ret;
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	int i;
+	sl->family_data = kzalloc(sizeof(struct w1_therm_family_data),
+		GFP_KERNEL);
+	if (!sl->family_data)
+		return -ENOMEM;
+	atomic_set(THERM_REFCNT(sl->family_data), 1);
+	return 0;
+}
 
-	ret = kstrtoint(buf, 0, &val);
-	if (ret)
-		return ret;
+static void w1_therm_remove_slave(struct w1_slave *sl)
+{
+	int refcnt = atomic_sub_return(1, THERM_REFCNT(sl->family_data));
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i) {
-		if (w1_therm_families[i].f->fid == sl->family->fid) {
-			/* zero value indicates to write current configuration to eeprom */
-			if (val == 0)
-				ret = w1_therm_families[i].eeprom(device);
-			else
-				ret = w1_therm_families[i].precision(device, val);
-			break;
-		}
+	while (refcnt) {
+		msleep(1000);
+		refcnt = atomic_read(THERM_REFCNT(sl->family_data));
 	}
-	return ret ? : size;
+	kfree(sl->family_data);
+	sl->family_data = NULL;
 }
 
+/*---------------------------Hardware Functions-----------------------------*/
+
 static ssize_t read_therm(struct device *device,
 			  struct w1_slave *sl, struct therm_info *info)
 {
@@ -564,6 +534,81 @@ error:
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
+/*-----------------------------Interface sysfs------------------------------*/
+
 static ssize_t w1_slave_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
@@ -597,6 +642,32 @@ static ssize_t w1_slave_show(struct device *device,
 	return ret;
 }
 
+static ssize_t w1_slave_store(struct device *device,
+			      struct device_attribute *attr, const char *buf,
+			      size_t size)
+{
+	int val, ret;
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int i;
+
+	ret = kstrtoint(buf, 0, &val);
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
+									val);
+			break;
+		}
+	}
+	return ret ? : size;
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
-- 
2.26.2

