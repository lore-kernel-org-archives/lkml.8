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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B5C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7642F20731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMUvDIql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgEJOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgEJOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:15:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E443C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:15:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 50so7028944wrc.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdFac8UHesI4CqSqIm5jURhaImPTUq8S0P+BAgk8uJs=;
        b=XMUvDIqlPKiChez3NslW65mx9UpU5CqUI4UEeZuq9dNPltxqEzqP0iCZX2La96OI5+
         bbtG7rkv5Df2DzI73LkpisgKtW/Iqfgpji+zzOsalYuK1UVSZTXaiRv1y7q0pn9d5A/w
         zXHBPlJAINFB2uDvgRtGvtsIpUqiVEy6GG8EQVYP4QL3avSabT2/bzB4GE3y8jEjkwZP
         KZ07zdoZYzTC7Bx165y3Kb6stGOh/fE+Bgc8AQpIlBb3cPxqEgQuvDXzaqcoo8cu2RLP
         D8bpUOy/u2oxT8ZgfggovhvNfMq6QWovQRUiIybPkInVMf63Q3ezEq0Y52DikJF4QHGZ
         QOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdFac8UHesI4CqSqIm5jURhaImPTUq8S0P+BAgk8uJs=;
        b=j37jENv7ShDDSf+wO9toB25JeqPSknNcVnb3PVEgKny9V6PsR8rR7rRM1oBTTiyecg
         +gjL/YmSwlR/OBke1YoyennhCVIm4U0tjJt2boNIz2aAIBmXBfSEjbyBJrp1ifpuURUK
         P1JxDkEHGJq5lQSNQpluPDPMtGXMmrB4kNXAK2us9D1ut3ePanrO7SfDeYwCk+SPJTOY
         Gxg78B2XYMVu8K2U2+xzKrlfzHamcdAR15M5/kUpk5KMlmzLM2aqs7b8qhgP9HtMT1S+
         TingUevDNELz8MPYLHs8VVDUZZmX4mAebyLUUTUD4gpA1eRM8NZaji9Q9SIFxJ/NYsi6
         FIpg==
X-Gm-Message-State: AGi0PuZNusUQ27DxAkIjiWbuPDl8D/C9fUwoIAdQ3ADHkKk7jbIelXsn
        43j1NUgylPhpfBgW55md6/c=
X-Google-Smtp-Source: APiQypJiV52/0aOM5XdIhseJcIf8TVInwWAf0PaBY3wlW5nkpfLtNKkjsQnIOa0++VbxLpEG96zdnw==
X-Received: by 2002:adf:f981:: with SMTP id f1mr13401654wrr.244.1589120130139;
        Sun, 10 May 2020 07:15:30 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id d1sm12194909wrx.65.2020.05.10.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:15:29 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 1/9] w1_therm: adding code comments and code reordering
Date:   Sun, 10 May 2020 16:15:06 +0200
Message-Id: <20200510141506.172021-1-akira215corp@gmail.com>
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
Changes in v6:
- Formatting code comments according to kernel-doc requirements

 drivers/w1/slaves/w1_therm.c | 398 ++++++++++++++++++++---------------
 1 file changed, 232 insertions(+), 166 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 18f08d7..890cf09 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -41,42 +41,55 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
+/* Helpers Macros */
+
+/* return the address of the refcnt in the family data */
+#define THERM_REFCNT(family_data) \
+	(&((struct w1_therm_family_data *)family_data)->refcnt)
+
+/* Structs definition */
+
+/**
+ * struct w1_therm_family_converter - bind device specific functions
+ * @broken: flag for non registred families
+ * @reserved: not used here
+ * @f: pointer to the device binding structure
+ * @convert: pointer to the device conversion function
+ * @precision: pointer to the device precicion function
+ * @eeprom: pointer to eeprom function
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
+ * struct w1_therm_family_data - device data
+ * @rom: ROM id of the device
+ * @refcnt: ref count
+ */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
 };
 
+/**
+ * struct therm_info - store temperature reading
+ * @rom: readen device data
+ * @crc: computed crc from rom
+ * @verdict: 1 crc checked, 0 crc not matching
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
+/* Sysfs interface declaration */
 
 static ssize_t w1_slave_show(struct device *device,
 	struct device_attribute *attr, char *buf);
@@ -87,9 +100,35 @@ static ssize_t w1_slave_store(struct device *device,
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+/* Attributes declarations */
+
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
 
+/* Interface Functions declaration */
+
+/**
+ * w1_therm_add_slave() - Called when a new slave is discovered
+ * @sl: slave just discovered by the master.
+ *
+ * Called by the master when the slave is discovered on the bus.Used to
+ * initialized slave state before the beginning of any communication.
+ *
+ * Return: 0 - If success, negative kernel code otherwise
+ */
+static int w1_therm_add_slave(struct w1_slave *sl);
+
+/**
+ * w1_therm_remove_slave() - Called when a slave is removed
+ * @sl: slave to be removed.
+ *
+ * Called by the master when the slave is considered not to be on the bus
+ * anymore. Used to free memory.
+ */
+static void w1_therm_remove_slave(struct w1_slave *sl);
+
+/* Family attributes */
+
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	NULL,
@@ -101,6 +140,8 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	NULL,
 };
 
+/* Attribute groups */
+
 ATTRIBUTE_GROUPS(w1_therm);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
@@ -154,6 +195,8 @@ static const struct hwmon_chip_info w1_chip_info = {
 #define W1_CHIPINFO	NULL
 #endif
 
+/* Family operations */
+
 static struct w1_family_ops w1_therm_fops = {
 	.add_slave	= w1_therm_add_slave,
 	.remove_slave	= w1_therm_remove_slave,
@@ -168,6 +211,8 @@ static struct w1_family_ops w1_ds28ea00_fops = {
 	.chip_info	= W1_CHIPINFO,
 };
 
+/* Family binding operations struct */
+
 static struct w1_family w1_therm_family_DS18S20 = {
 	.fid = W1_THERM_DS18S20,
 	.fops = &w1_therm_fops,
@@ -193,138 +238,18 @@ static struct w1_family w1_therm_family_DS1825 = {
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
+/* Device dependent func */
 
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
@@ -407,6 +332,7 @@ error:
 	return ret;
 }
 
+/* The return value is millidegrees Centigrade. */
 static inline int w1_DS18B20_convert_temp(u8 rom[9])
 {
 	s16 t = le16_to_cpup((__le16 *)rom);
@@ -414,6 +340,7 @@ static inline int w1_DS18B20_convert_temp(u8 rom[9])
 	return t*1000/16;
 }
 
+/* The return value is millidegrees Centigrade. */
 static inline int w1_DS18S20_convert_temp(u8 rom[9])
 {
 	int t, h;
@@ -434,6 +361,43 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 	return t;
 }
 
+/* Device capability description */
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
+/* Helpers Functions */
+
 static inline int w1_convert_temp(u8 rom[9], u8 fid)
 {
 	int i;
@@ -445,31 +409,32 @@ static inline int w1_convert_temp(u8 rom[9], u8 fid)
 	return 0;
 }
 
-static ssize_t w1_slave_store(struct device *device,
-			      struct device_attribute *attr, const char *buf,
-			      size_t size)
+/* Interface Functions */
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
 
+/* Hardware Functions */
+
 static ssize_t read_therm(struct device *device,
 			  struct w1_slave *sl, struct therm_info *info)
 {
@@ -564,6 +529,81 @@ error:
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
+/* Sysfs Interface definition */
+
 static ssize_t w1_slave_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
@@ -597,6 +637,32 @@ static ssize_t w1_slave_show(struct device *device,
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

