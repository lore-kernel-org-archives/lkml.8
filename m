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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BFC47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFE8208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3BY0gJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgEJAAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEJAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:00:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B9C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 17:00:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so14719123wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lXD3SvRSAHdQ0ypbE6+v4zBtT2TA1TRforrP2RfHrQ=;
        b=F3BY0gJL6p2AIekWrWwEP1uS0J1qhVD+6m1JpUDdTFmupnNHBJDec8M7nSyeR9zSAi
         7FjtN+Yupv8fo8wPrdQD/MdmrjhuRLS8GMLjuhgWVKVfyvyOrSfvBdsiL32hFvnlhhXb
         mUQ+CBf/52AckfPCfhHoO3WOPe6xaHdaPxjLaQj/53p++fRnPakDadgFMXAWDv1U22Rn
         NdvoY1fvt+cB4k/4s0Tc/6QhU16GVSTa9HWtAinbUPaaHhKM8Yvccl9vsljdX3215FuS
         MhkbRv1RVeQyZKbh9WywKqRLNKs4dJRE/xKVGeLHsNBQwnYymTOBrf+m+Q1WUEJaMkuX
         GKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lXD3SvRSAHdQ0ypbE6+v4zBtT2TA1TRforrP2RfHrQ=;
        b=lQa7Ygff1+RCbnVPaESB+mnZX5Lhty/cLAFsBXoSwyJ3BFHXZcU8TXhzjhWA/WOuZx
         VeVZKyYoCpT77CK6j48v0ie3v3EQc7a0RYcXa401JqGw7Y+Zo2Iyygu2bpf0QOZ9Wj60
         5lw4RAKcXjZ7w0Ke4P992jOwDBmq74BYGhQlDJda2jmC4NdFbWTJdUTgp0Mo1nX3gbi7
         39Q/5H8flqqt22SFYFLUziSKgH1ftTdOrMTLooUuTMbgkHBlYyxWvb4KIGXgCdPFn/B/
         0MnXjIUE4AN6gGWQuVqWRk9D+ixb+2KfZHCWD17Jjx3XI+MJNNDOdfVK3JcRljmt5GET
         wZaw==
X-Gm-Message-State: AGi0PubLT79JQB27BQOyUsgQUZcEjEU5sT88kef7+mnqUsdOS4JGtIIH
        7gyDMd6I89Js/rwEh7HbsWk=
X-Google-Smtp-Source: APiQypLZ3MBYwI77C/Buujoe5wXy+1sXlOw413nQgbTj8CSZ2CpViIMdUDGQdLuPEUAQ3ngOhdm/iQ==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr25139134wmc.83.1589068822817;
        Sat, 09 May 2020 17:00:22 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id o66sm8952362wma.2.2020.05.09.17.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:00:22 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 6/9] w1_therm: adding eeprom sysfs entry
Date:   Sun, 10 May 2020 02:00:14 +0200
Message-Id: <20200510000014.424163-1-akira215corp@gmail.com>
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

 .../ABI/testing/sysfs-driver-w1_therm         |  14 ++
 drivers/w1/slaves/w1_therm.c                  | 176 ++++++++++++------
 2 files changed, 133 insertions(+), 57 deletions(-)

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
index 159bfc1..d3f83f8 100644
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
 /*-------------------------------Macros-------------------------------------*/
 
 /* return a pointer on the slave w1_therm_family_converter struct:
@@ -87,7 +96,6 @@ struct w1_therm_family_converter {
 	int		(*convert)(u8 rom[9]);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
-	int		(*eeprom)(struct device *device);
 };
 
 /**
@@ -151,6 +159,19 @@ static int read_scratchpad(struct w1_slave *sl, struct therm_info *info);
  */
 static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
 
+/** copy_scratchpad() - Copy the content of scratchpad in device EEPROM
+ *  \param sl slave involved
+ *  \return 0 if success, -kernel error code otherwise
+ */
+static int copy_scratchpad(struct w1_slave *sl);
+
+/** recall_eeprom()
+ * \brief retrieve EEPROM data to device RAM
+ * \param sl slave involved
+ * \return 0 if success, -kernel error code otherwise
+ */
+static int recall_eeprom(struct w1_slave *sl);
+
 /** read_powermode()
  * \brief ask the device to get its power mode {external, parasite}
  * \param sl slave to be interrogated
@@ -204,12 +225,19 @@ static ssize_t resolution_show(struct device *device,
 static ssize_t resolution_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
+/** \brief A callback function to let the user read/write device EEPROM
+ *  \param check EEPROM_CMD_WRITE & EEPROM_CMD_READ macros
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
 
 /*--------------------Interface Functions declaration-----------------------*/
 
@@ -232,12 +260,14 @@ static struct attribute *w1_therm_attrs[] = {
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
 
@@ -246,6 +276,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_seq.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
@@ -357,9 +388,6 @@ static struct w1_family w1_therm_family_DS1825 = {
 
 /*----------------------------Device dependent func-------------------------*/
 
-/* write configuration to eeprom */
-static inline int w1_therm_eeprom(struct device *device);
-
 static inline int w1_DS18B20_write_data(struct w1_slave *sl,
 				const u8 *data)
 {
@@ -460,35 +488,30 @@ static struct w1_therm_family_converter w1_therm_families[] = {
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
 
@@ -805,75 +828,94 @@ error:
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
+			/* 10ms strong pullup (or delay) after the convert */
+			if (strong_pullup)
+				w1_next_pullup(dev_master, t_write);
 
-			if (reset_select_slave(sl))
-				continue;
+			w1_write_8(dev_master, W1_COPY_SCRATCHPAD);
 
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
@@ -972,7 +1014,7 @@ static ssize_t w1_slave_store(struct device *device,
 	}
 
 	if (val == 0)	/* val=0 : trigger a EEPROM save */
-		ret = SLAVE_SPECIFIC_FUNC(sl)->eeprom(device);
+		ret = copy_scratchpad(sl);
 	else {
 		if (SLAVE_SPECIFIC_FUNC(sl)->set_resolution)
 			ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
@@ -1070,6 +1112,26 @@ static ssize_t resolution_store(struct device *device,
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

