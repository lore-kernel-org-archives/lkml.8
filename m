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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822BDC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547EC20731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWko6Yyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgEJORm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729161AbgEJORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:17:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45410C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:17:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w7so7552205wre.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0dGs+8hB76V1mwUb8Et4C9xnQIec7fQyOlzu555dfE=;
        b=SWko6YyxagqBCc/r4KgvnYYcp7VTUD6LA4m+CfW09LMV+OwRpQ+pTHy4+yBXFP8qsb
         Azbeaw0rYYBwkl8JbDzfDXaSCEC42x05BtE5kIaEbodaYCMaMKnxxA9ltammADX1hcqr
         DnQi+FO/m5qpn427jTFXWO2sMt/XAi2tQffMR3jP4+y4iMaR5QHH+RFT59uQJJobvxXW
         7IFquqSajMQ1mtdqJRULIeqtgnbYtnSW6ZFinmtV/Zb8sHmZsP+eDs3RaZiEOCsYgG97
         ahB+XHDq++vq3vWax7l0tsfG2mChg6TSfhe8lLkSIqIzG6a5bfSABsULHT92QvFj1ViY
         Q8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0dGs+8hB76V1mwUb8Et4C9xnQIec7fQyOlzu555dfE=;
        b=aZ7z0mq4d8Q95X5FHMKOs025yy1bQMXIJHZPLaEqDn4JwGyZ9adBbAwWzH0w6bS6tN
         Fn5ciHDg77qbJplchcs4V4EzlGXUJkVlqlBn3U/YiZbYpQU0auvZqo+ShdmqTpEwEfCQ
         E2eKIfoi58+1KsL2Z68uW4u1uAADMIy21mgZ2MyJLzNXM2QaeKjjkGnyEwTB+fUZnhlU
         //uo83w4m9i6jIJ3kU7GayE6D4/yidfECjWYW0fBmXfBUteh5hAs6nGuvQ+txCyHLzgY
         xc3/BCeyAn/RIGlm24hjqsbg8rIG11jucGl0WU+lG7FhYJwTTCNWHwWegJPECLFuhBiU
         7EPg==
X-Gm-Message-State: AGi0PuaSrz1urTWUEQ6h7UKtqqC9+QdrMhglioTfIgCIjO45/juT3uRW
        tgWIn4u1qTC5Z/3TB2MJ1P4=
X-Google-Smtp-Source: APiQypL+NxPcbmAJ7QV542Tu3CGK06ihTdglRxCUk537CyHp1nRYf4WV2tk0duQUAX5CCq0YNyMIvw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr13632756wrn.253.1589120259940;
        Sun, 10 May 2020 07:17:39 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id f127sm2563387wmf.17.2020.05.10.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:17:39 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 6/9] w1_therm: adding eeprom sysfs entry
Date:   Sun, 10 May 2020 16:17:25 +0200
Message-Id: <20200510141725.173483-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding eeprom sysfs entry (WO) to trigger either device EEPROM save
(by writing 'save' in the sysfs), either device EEPROM restore (by writing
'restore' in the sysfs). All the RAM of the device will be save/restore,
whatever its size (actually 2 or 3 bytes): resolution config register and
alarms level will be save/restore.

The driver implement 2 hardware functions to access device RAM:
 * copy_scratchpad
 * recall_scratchpad
They act according to device specifications.

As EEPROM operations are not device dependent (all w1_therm can perform
EEPROM read/write operation following the same protocol), it is removed
from device families structures.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include
Changes in v6:
- Formatting code comments according to kernel-doc requirements

 .../ABI/testing/sysfs-driver-w1_therm         |  14 ++
 drivers/w1/slaves/w1_therm.c                  | 177 ++++++++++++------
 2 files changed, 133 insertions(+), 58 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 7ed95e9..8b7ee89 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,17 @@
+What:		/sys/bus/w1/devices/.../eeprom
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(WO) writing that file will either trigger a save of the
+		device data to its embedded EEPROM, either restore data
+		embedded in device EEPROM. Be aware that devices support
+		limited EEPROM writing cycles (typical 50k)
+			* 'save': save device RAM to EEPROM
+			* 'restore': restore EEPROM data in device RAM
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../ext_power
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index b1734ae..c90a91f 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -42,12 +42,21 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
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
 /* Helpers Macros */
 
 /* return a pointer on the slave w1_therm_family_converter struct:
@@ -82,7 +91,6 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * @convert: pointer to the device conversion function
  * @set_resolution: pointer to the device set_resolution function
  * @get_resolution: pointer to the device get_resolution function
- * @eeprom: pointer to eeprom function
  */
 struct w1_therm_family_converter {
 	u8		broken;
@@ -91,7 +99,6 @@ struct w1_therm_family_converter {
 	int		(*convert)(u8 rom[9]);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
-	int		(*eeprom)(struct device *device);
 };
 
 /**
@@ -161,6 +168,22 @@ static int read_scratchpad(struct w1_slave *sl, struct therm_info *info);
  */
 static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
 
+/**
+ * copy_scratchpad() - Copy the content of scratchpad in device EEPROM
+ * @sl: slave involved
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int copy_scratchpad(struct w1_slave *sl);
+
+/**
+ * recall_eeprom() - Restore EEPROM data to device RAM
+ * @sl: slave involved
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int recall_eeprom(struct w1_slave *sl);
+
 /**
  * read_powermode() - Query the power mode of the slave
  * @sl: slave to retrieve the power mode
@@ -195,12 +218,16 @@ static ssize_t resolution_show(struct device *device,
 static ssize_t resolution_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
+static ssize_t eeprom_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
+static DEVICE_ATTR_WO(eeprom);
 
 /* Interface Functions declaration */
 
@@ -230,12 +257,14 @@ static struct attribute *w1_therm_attrs[] = {
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
 
@@ -244,6 +273,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_seq.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
@@ -355,9 +385,6 @@ static struct w1_family w1_therm_family_DS1825 = {
 
 /* Device dependent func */
 
-/* write configuration to eeprom */
-static inline int w1_therm_eeprom(struct device *device);
-
 static inline int w1_DS18B20_write_data(struct w1_slave *sl,
 				const u8 *data)
 {
@@ -458,35 +485,30 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.convert	= w1_DS18S20_convert_temp,
 		.set_resolution	= NULL,	// no config register
 		.get_resolution	= NULL,	// no config register
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS1822,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS18B20,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS28EA00,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS1825,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	}
 };
 
@@ -809,75 +831,94 @@ error:
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
@@ -976,7 +1017,7 @@ static ssize_t w1_slave_store(struct device *device,
 	}
 
 	if (val == 0)	/* val=0 : trigger a EEPROM save */
-		ret = SLAVE_SPECIFIC_FUNC(sl)->eeprom(device);
+		ret = copy_scratchpad(sl);
 	else {
 		if (SLAVE_SPECIFIC_FUNC(sl)->set_resolution)
 			ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
@@ -1074,6 +1115,26 @@ static ssize_t resolution_store(struct device *device,
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
-- 
2.26.2

