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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F57C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF18208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5miUE7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgD2XBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2XBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:01:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCAC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:01:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so3875679wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8RMyEjp8BlSMOInWmCezRxpzgbdODgMG7aJmRj9ytT8=;
        b=k5miUE7M8ULAByI8QTe4IFBs9UjQ0jxqyqDud6EnokWBj45fzTjgWTqceXMD2NuRQM
         AW5B1xndanaKZAj2zeK5c6Jbj5LaAcfY5VhJ8idDgNVS4HzCKr2Ea7RBVqU8Yhr5fB9A
         kZP5AfgQKOZHxwx/Myzt30TBU0/XjZwTANC+0fc9YhH3UHjOgHg8PTwpq7aPzKB1JIyh
         XZ6YRGqvU9P53SFv5rWdvDhfcXJCvfk2DZ+t2Pi87FJUaTOuMkJEYY6qXSOpNnqkib3z
         P7pZxA6RvjbzDNGd+uEEimXPItAd9Pwa2TS+VPOX9rEY2AUGRXh8u6CO1wRMlLnMba7C
         XOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8RMyEjp8BlSMOInWmCezRxpzgbdODgMG7aJmRj9ytT8=;
        b=FOb3dwXKAef0Yguux5N3++wNPYztoXgIXthg1mUiftslfAoaZVfZVhd2DGXQc2QFTt
         9cIAPNSqil+ejsJxMOnekhvY46MHIRdtUY7iD+dc9iIO6og88mv3I0YHioo7IXHq229G
         5riHKkCpvkUZwTHIZTXnIgGCfK0VVUpXq4uHPd3mQUjSFoVVRtZT7NTRwEk0UFVrbLSA
         Um07RN29vIVADnS5qq6/c0u6e7pnaKelONcUxKgb/tV7DirApE3J/NhJyETzK6/HYpQA
         wUlRW02c6c/0sWTGjgBdtJTuRAIFYETTTjvOPMQz4Vajm4APTmVKfIYjkWNXqqOJLgAT
         bd8Q==
X-Gm-Message-State: AGi0PubKl9Udutx4cc9+uhKSfKZZUwx3i+gAO3Q8AMV8nl6vurJJidP3
        NLh/2nZn0xG2KYh4GHxGR74=
X-Google-Smtp-Source: APiQypJb6lWSvITSOvU0KRd2Red0WzRzjsY41lpGts0ykwHtO0rWkCMGbYuOSTPr143jthJPwsdYAg==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr156176wml.7.1588201296766;
        Wed, 29 Apr 2020 16:01:36 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id n25sm9771897wmk.9.2020.04.29.16.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:01:36 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v4 6/9] w1_therm: adding eeprom sysfs entry
Date:   Thu, 30 Apr 2020 01:01:23 +0200
Message-Id: <20200429230123.200289-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding eeprom sysfs entry (WO) to trigger either device EEPROM save
(by writing 'save' in the sysfs) either device EEPROM restore (by writing
'restore' in the sysfs). All the RAM of the device will be save/restore,
whatever its size : resolution config register and alarms level will be
save/restore.

The driver implement 2 basics functions to access device RAM:
 * copy_scratchpad
 * recall_scratchpad
They act according to device specifications.

As EEPROM operations are not device dependent (all w1_therm can perform
EEPROM read/write operation following the same protocol), it is removed
from device families structures.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 .../ABI/testing/sysfs-driver-w1_therm         |  14 ++
 drivers/w1/slaves/w1_therm.c                  | 151 +++++++++++-------
 drivers/w1/slaves/w1_therm.h                  |  36 ++++-
 3 files changed, 142 insertions(+), 59 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index e52dd6a..9dcbbed 100644
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
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 382d679..caa4615 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -57,6 +57,13 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * resolution (RW):
  *	. -xx	: xx is kernel error
  *	. 9..12	: resolution set in bit (or resolution to set in bit)
+ *
+ * eeprom (WO): be aware that eeprom writing cycles count is limited
+ *	. 'save'	:	save device RAM to EEPROM
+ *	. 'restore'	:	restore EEPROM data in device RAM
+ *				(device do that automatically on power-up)
+ *
+ *
  */
 
 /*
@@ -68,12 +75,14 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
 static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 static struct attribute *w1_ds28ea00_attrs[] = {
@@ -81,6 +90,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_seq.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
@@ -89,7 +99,6 @@ ATTRIBUTE_GROUPS(w1_therm);
 ATTRIBUTE_GROUPS(w1_ds18s20);
 ATTRIBUTE_GROUPS(w1_ds28ea00);
 
-
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *dev, u32 attr, int channel,
 			long *val);
@@ -196,7 +205,6 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution	= NULL,	// no config register
 		.get_resolution	= NULL,	// no config register
 		.write_data		= w1_DS18S20_write_data,
-		.eeprom			= w1_therm_eeprom
 	},
 	{
 		.f			= &w1_therm_family_DS1822,
@@ -204,7 +212,6 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
-		.eeprom			= w1_therm_eeprom
 	},
 	{
 		.f			= &w1_therm_family_DS18B20,
@@ -212,7 +219,6 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
-		.eeprom			= w1_therm_eeprom
 	},
 	{
 		.f			= &w1_therm_family_DS28EA00,
@@ -220,7 +226,6 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
-		.eeprom			= w1_therm_eeprom
 	},
 	{
 		.f			= &w1_therm_family_DS1825,
@@ -228,7 +233,6 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data		= w1_DS18B20_write_data,
-		.eeprom			= w1_therm_eeprom
 	}
 };
 
@@ -626,75 +630,94 @@ error:
 	return ret;
 }
 
-static inline int w1_therm_eeprom(struct device *device)
+static int copy_scratchpad(struct w1_slave *sl)
 {
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_write, ret = -ENODEV;
+	bool strong_pullup;
 
-	if (!sl->family_data) {
-		ret = -ENODEV;
+	if (!sl->family_data)
 		goto error;
-	}
 
-	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+	t_write = W1_THERM_EEPROM_WRITE_DELAY;
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
-		goto dec_refcnt;
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-	memset(rom, 0, sizeof(rom));
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
 
-	while (max_trying--) {
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
 		if (!reset_select_slave(sl)) {
-			unsigned int tm = 10;
 			unsigned long sleep_rem;
 
-			/* check if in parasite mode */
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
-
-			if (reset_select_slave(sl))
-				continue;
+			/* 10ms strong pullup (or delay) after the convert */
+			if (strong_pullup)
+				w1_next_pullup(dev_master, t_write);
 
-			/* 10ms strong pullup/delay after the copy command */
-			if (w1_strong_pullup == 2 ||
-			    (!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
-
-			w1_write_8(dev, W1_COPY_SCRATCHPAD);
-
-			if (external_power) {
-				mutex_unlock(&dev->bus_mutex);
+			w1_write_8(dev_master, W1_COPY_SCRATCHPAD);
 
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
@@ -786,7 +809,7 @@ static ssize_t w1_slave_store(struct device *device,
 		if (w1_therm_families[i].f->fid == sl->family->fid) {
 	/* zero value indicates to write current configuration to eeprom */
 			if (val == 0)
-				ret = w1_therm_families[i].eeprom(device);
+				ret = copy_scratchpad(sl);
 			else
 				ret = w1_therm_families[i].set_resolution(sl,
 									val);
@@ -878,6 +901,26 @@ static ssize_t resolution_store(struct device *device,
 	return size;
 }
 
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
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
index b7f0cac..7202627 100644
--- a/drivers/w1/slaves/w1_therm.h
+++ b/drivers/w1/slaves/w1_therm.h
@@ -25,12 +25,21 @@
 #include <linux/mutex.h>
 #include <linux/w1.h>
 
+/* This command should be in public header w1.h but is not */
+#define W1_RECALL_EEPROM	0xB8
+
 /* Nb of try for an operation */
 #define W1_THERM_MAX_TRY		5
 
 /* ms delay to retry bus mutex */
 #define W1_THERM_RETRY_DELAY		20
 
+/* delay in ms to write in EEPROM */
+#define W1_THERM_EEPROM_WRITE_DELAY	10
+
+#define EEPROM_CMD_WRITE    "save"	/* cmd for write eeprom sysfs */
+#define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
+
 /*----------------------------------Structs---------------------------------*/
 
 /**
@@ -45,7 +54,6 @@ struct w1_therm_family_converter {
 	u16		reserved;
 	struct w1_family	*f;
 	int		(*convert)(u8 rom[9]);
-	int		(*eeprom)(struct device *device);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
 	int		(*write_data)(struct w1_slave *sl, const u8 *data);
@@ -84,10 +92,6 @@ struct therm_info {
 
 /*-----------------------Device specific functions-------------------------*/
 
-/* write configuration to eeprom */
-static inline int w1_therm_eeprom(struct device *device);
-
-/* The return value is millidegrees Centigrade. */
 static inline int w1_DS18B20_convert_temp(u8 rom[9]);
 static inline int w1_DS18S20_convert_temp(u8 rom[9]);
 
@@ -175,6 +179,19 @@ static int read_scratchpad(struct w1_slave *sl, struct therm_info *info);
  */
 static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
 
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
@@ -183,6 +200,7 @@ static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
  *			<0 kernel error code
  */
 static int read_powermode(struct w1_slave *sl);
+
 /*----------------------------Interface sysfs-------------------------------*/
 
 /** @brief A callback function to output the temperature Old way
@@ -225,12 +243,20 @@ static ssize_t resolution_show(struct device *device,
  */
 static ssize_t resolution_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
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
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
+static DEVICE_ATTR_WO(eeprom);
 
 /*--------------------------Interface Functions-----------------------------*/
 
-- 
2.26.2

