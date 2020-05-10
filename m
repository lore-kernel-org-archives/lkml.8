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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3092C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982A42082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEkOtHaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgEJOSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729111AbgEJOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:18:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A7C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:18:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so15836496wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xV7HSmUN/VxnB9gPLeQBnXOqZW9evu7A8RniDp4jfE0=;
        b=XEkOtHaBB4zRrdaEk8w2UPwyswrlesCa9dvdZkf4gTsELHv2WaXqGWSP52vQP1nreO
         nIjO87u9PVjF8WeT3Eq6ezsUUGiKsNyeVwY/VIm5oRgeXCOACmUPc/js7hrkoAo9hPrY
         ddMtJlXyGQ03XoHSI3sXn/vhaQLAsHSaJ+JHlkZ5Ua4pXAbbhNq6yiBUqxXmxZb8EqMH
         sODAWOLdG1SY7Q0/U6KiVBme5oXP7bIJGXfu9dyxk3qzuknntiMLhxSESi2B4jERLH05
         OxL5WfWaeJI0YfRWYUV3OVFtakL57sukS9FW6q6+DJXQcHQSNKbNVWVvzNEBh8EaTyW/
         V/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xV7HSmUN/VxnB9gPLeQBnXOqZW9evu7A8RniDp4jfE0=;
        b=W2Ni5PKR1hdsOC1xsv0RDTcRCTWDWxvHtYEKJdQ4AWDpvvmsIKWQVH54B2P3EvI5Um
         3bMKw2KUmcDUCqdVp9XhxQ11GRsd+xirSuQQy4oNqf9gPUYg8O984RYf9Yv0xaRIqbdq
         Ir8H2vaNfT1+d3eo/v5TLF4UHQClUzq1LRvk39zR/s9HO0TuHsjCZrvCfIJY1VvHM4gM
         UiXdFGyrbWt6evroN+EBdx8mqUjHQEnzUsj0A18/8MdPCwx0Z4nllJaW2BrT57Cre+3Y
         I8E6iTi1bUdUV2q2WghOhgxZC1KnejtsHYY8E451XZxaKI9iDGzVsylk5q/b9WICOfen
         GlHg==
X-Gm-Message-State: AGi0PuYz+9ShS0mzMqacIvlf2AZMGxS8jxW6CuqcGgcxv6jdXcUOKlxE
        9QBsFp2tyf9cIO/+26zwwRc=
X-Google-Smtp-Source: APiQypJASeKAt1S+FD2M6eFN6QI3rKncH20GikyUy/hsBStpyq1Lw3/LxgaaWolHHuisYsKapQab4A==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr10059965wmk.167.1589120311114;
        Sun, 10 May 2020 07:18:31 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id q2sm12937830wrm.42.2020.05.10.07.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:18:30 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 9/9] w1_therm: adding bulk read support to trigger multiple conversion on bus
Date:   Sun, 10 May 2020 16:18:23 +0200
Message-Id: <20200510141823.174117-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bulk read support:
Sending a 'trigger' command in the dedicated sysfs entry of bus master
device send a conversion command for all the slaves on the bus. The sysfs
entry is added as soon as at least one device supporting this feature
is detected on the bus.

The behavior of the sysfs reading temperature on the device is as follow:
 * If no bulk read pending, trigger a conversion on the device, wait for
 the conversion to be done, read the temperature in device RAM
 * If a bulk read has been trigger, access directly the device RAM
This behavior is the same on the 2 sysfs entries ('temperature' and
'w1_slave').

Reading the therm_bulk_read sysfs give the status of bulk operations:
 * '-1': conversion in progress on at least 1 sensor
 * '1': conversion complete but at least one sensor has not been read yet
 * '0': no bulk operation. Reading temperature on ecah device will trigger
a conversion

As not all devices support bulk read feature, it has been added in device
family structure.

The attribute is set at master level as soon as a supporting device is
discover. It is removed when the last supported device leave the bus.
The count of supported device is kept with the static counter
bulk_read_device_counter.

A strong pull up is apply on the line if at least one device required it.
The duration of the pull up is the max time required by a device on the
line, which depends on the resolution settings of each device. The strong
pull up could be adjust with the a module parameter.

Updating documentation in Documentation/ABI/testing/sysfs-driver-w1_therm
and Documentation/w1/slaves/w1_therm.rst accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include
Changes in v6:
- Formatting code comments according to kernel-doc requirements

 .../ABI/testing/sysfs-driver-w1_therm         |  36 ++-
 Documentation/w1/slaves/w1_therm.rst          |  50 +++-
 drivers/w1/slaves/w1_therm.c                  | 247 +++++++++++++++++-
 3 files changed, 318 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index f289520..076659d 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -62,9 +62,16 @@ Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
 Description:
 		(RO) return the temperature in 1/1000 degC.
-		Note that the conversion duration depend on the resolution (if
-		device support this feature). It takes 94ms in 9bits
-		resolution, 750ms for 12bits.
+			* If a bulk read has been triggered, it will directly
+			return the temperature computed when the bulk read
+			occurred, if available. If not yet available, nothing
+			is returned (a debug kernel message is sent), you
+			should retry later on.
+			* If no bulk read has been triggered, it will trigger
+			a conversion and send the result. Note that the
+			conversion duration depend on the resolution (if
+			device support this feature). It takes 94ms in 9bits
+			resolution, 750ms for 12bits.
 Users:		any user space application which wants to communicate with
 		w1_term device
 
@@ -85,4 +92,25 @@ Description:
 		refer to Documentation/w1/slaves/w1_therm.rst for detailed
 		information.
 Users:		any user space application which wants to communicate with
-		w1_term device
\ No newline at end of file
+		w1_term device
+
+
+What:		/sys/bus/w1/devices/w1_bus_masterXX/therm_bulk_read
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) trigger a bulk read conversion. read the status
+		*read*:
+			* '-1': conversion in progress on at least 1 sensor
+			* '1' :	conversion complete but at least one sensor
+				value has not been read yet
+			* '0' :	no bulk operation. Reading temperature will
+				trigger a conversion on each device
+		*write*: 'trigger': trigger a bulk read on all supporting
+			devices on the bus
+		Note that if a bulk read is sent but one sensor is not read
+		immediately, the next access to temperature on this device
+		will return the temperature measured at the time of issue
+		of the bulk read command (not the current temperature).
+Users:		any user space application which wants to communicate with
+		w1_term device
diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
index 82e8ffe..7c42f00 100644
--- a/Documentation/w1/slaves/w1_therm.rst
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -26,20 +26,31 @@ W1_THERM_DS1825		0x3B
 W1_THERM_DS28EA00	0x42
 ====================	====
 
-Support is provided through the sysfs w1_slave file.  Each open and
+Support is provided through the sysfs w1_slave file. Each open and
 read sequence will initiate a temperature conversion then provide two
-lines of ASCII output.  The first line contains the nine hex bytes
+lines of ASCII output. The first line contains the nine hex bytes
 read along with a calculated crc value and YES or NO if it matched.
-If the crc matched the returned values are retained.  The second line
+If the crc matched the returned values are retained. The second line
 displays the retained values along with a temperature in millidegrees
 Centigrade after t=.
 
-Parasite powered devices are limited to one slave performing a
-temperature conversion at a time.  If none of the devices are parasite
-powered it would be possible to convert all the devices at the same
-time and then go back to read individual sensors.  That isn't
-currently supported.  The driver also doesn't support reduced
-precision (which would also reduce the conversion time) when reading values.
+Alternatively, temperature can be read using temperature sysfs, it
+return only temperature in millidegrees Centigrade.
+
+A bulk read of all devices on the bus could be done writing 'trigger'
+in the therm_bulk_read sysfs entry at w1_bus_master level. This will
+sent the convert command on all devices on the bus, and if parasite
+powered devices are detected on the bus (and strong pullup is enable
+in the module), it will drive the line high during the longer conversion
+time required by parasited powered device on the line. Reading
+therm_bulk_read will return 0 if no bulk conversion pending,
+-1 if at least one sensor still in conversion, 1 if conversion is complete
+but at least one sensor value has not been read yet. Result temperature is
+then accessed by reading the temperature sysfs entry of each device, which
+may return empty if conversion is still in progress. Note that if a bulk
+read is sent but one sensor is not read immediately, the next access to
+temperature on this device will return the temperature measured at the
+time of issue of the bulk read command (not the current temperature).
 
 Writing a value between 9 and 12 to the sysfs w1_slave file will change the
 precision of the sensor for the next readings. This value is in (volatile)
@@ -49,6 +60,27 @@ To store the current precision configuration into EEPROM, the value 0
 has to be written to the sysfs w1_slave file. Since the EEPROM has a limited
 amount of writes (>50k), this command should be used wisely.
 
+Alternatively, resolution can be set or read (value from 9 to 12) using the
+dedicated resolution sysfs entry on each device. This sysfs entry is not
+present for devices not supporting this feature. Driver will adjust the
+correct conversion time for each device regarding to its resolution setting.
+In particular, strong pullup will be applied if required during the conversion
+duration.
+
+The write-only sysfs entry eeprom is an alternative for EEPROM operations:
+  * 'save': will save device RAM to EEPROM
+  * 'restore': will restore EEPROM data in device RAM.
+
+ext_power syfs entry allow tho check the power status of each device.
+  * '0': device parasite powered
+  * '1': device externally powered
+
+sysfs alarms allow read or write TH and TL (Temperature High an Low) alarms.
+Values shall be space separated and in the device range (typical -55 degC
+to 125 degC). Values are integer as they are store in a 8bit register in
+the device. Lowest value is automatically put to TL.Once set, alarms could
+be search at master level.
+
 The module parameter strong_pullup can be set to 0 to disable the
 strong pullup, 1 to enable autodetection or 2 to force strong pullup.
 In case of autodetection, the driver will use the "READ POWER SUPPLY"
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 1301b16..c87e99a 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -42,6 +42,9 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
+/* Counter for devices supporting bulk reading */
+static u16 bulk_read_device_counter; // =0 as per C standard
+
 /* This command should be in public header w1.h but is not */
 #define W1_RECALL_EEPROM	0xB8
 
@@ -56,6 +59,7 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
 #define EEPROM_CMD_WRITE    "save"	/* cmd for write eeprom sysfs */
 #define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
+#define BULK_TRIGGER_CMD    "trigger"	/* cmd to trigger a bulk read */
 
 #define MIN_TEMP	-55	/* min temperature that can be mesured */
 #define MAX_TEMP	125	/* max temperature that can be mesured */
@@ -80,6 +84,14 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 #define SLAVE_RESOLUTION(sl) \
 	(((struct w1_therm_family_data *)(sl->family_data))->resolution)
 
+/*  return whether or not a converT command has been issued to the slave
+ * * 0: no bulk read is pending
+ * * -1: conversion is in progress
+ * * 1: conversion done, result to be read
+ */
+#define SLAVE_CONVERT_TRIGGERED(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->convert_triggered)
+
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
@@ -96,6 +108,7 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * @set_resolution: pointer to the device set_resolution function
  * @get_resolution: pointer to the device get_resolution function
  * @write_data: pointer to the device writing function (2 or 3 bytes)
+ * @bulk_read: true if device family support bulk read, false otherwise
  */
 struct w1_therm_family_converter {
 	u8		broken;
@@ -106,6 +119,7 @@ struct w1_therm_family_converter {
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
 	int		(*write_data)(struct w1_slave *sl, const u8 *data);
+	bool		bulk_read;
 };
 
 /**
@@ -116,6 +130,7 @@ struct w1_therm_family_converter {
  *				0 device parasite powered,
  *				-x error or undefined
  * @resolution: current device resolution
+ * @convert_triggered: conversion state of the device
  * @specific_functions: pointer to struct of device specific function
  */
 struct w1_therm_family_data {
@@ -123,6 +138,7 @@ struct w1_therm_family_data {
 	atomic_t refcnt;
 	int external_powered;
 	int resolution;
+	int convert_triggered;
 	struct w1_therm_family_converter *specific_functions;
 };
 
@@ -214,6 +230,18 @@ static int recall_eeprom(struct w1_slave *sl);
  */
 static int read_powermode(struct w1_slave *sl);
 
+/**
+ * trigger_bulk_read() - function to trigger a bulk read on the bus
+ * @dev_master: the device master of the bus
+ *
+ * Send a SKIP ROM follow by a CONVERT T commmand on the bus.
+ * It also set the status flag in each slave &struct w1_therm_family_data
+ * to signal that a conversion is in progress.
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int trigger_bulk_read(struct w1_master *dev_master);
+
 /* Sysfs interface declaration */
 
 static ssize_t w1_slave_show(struct device *device,
@@ -246,6 +274,12 @@ static ssize_t alarms_store(struct device *device,
 static ssize_t alarms_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+static ssize_t therm_bulk_read_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+static ssize_t therm_bulk_read_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
@@ -256,6 +290,8 @@ static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
 static DEVICE_ATTR_RW(alarms);
 
+static DEVICE_ATTR_RW(therm_bulk_read); /* attribut at master level */
+
 /* Interface Functions declaration */
 
 /**
@@ -553,6 +589,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= NULL,	// no config register
 		.get_resolution		= NULL,	// no config register
 		.write_data			= w1_DS18S20_write_data,
+		.bulk_read			= true
 	},
 	{
 		.f				= &w1_therm_family_DS1822,
@@ -561,6 +598,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= true
 	},
 	{
 		.f				= &w1_therm_family_DS18B20,
@@ -569,6 +607,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= true
 	},
 	{
 		.f				= &w1_therm_family_DS28EA00,
@@ -577,6 +616,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= false
 	},
 	{
 		.f				= &w1_therm_family_DS1825,
@@ -585,6 +625,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= true
 	}
 };
 
@@ -638,6 +679,23 @@ static inline bool bus_mutex_lock(struct mutex *lock)
 	return true;
 }
 
+/**
+ * support_bulk_read() - check if slave support bulk read
+ * @sl: device to check the ability
+ *
+ * Return: true if bulk read is supported, false if not or error
+ */
+static inline bool bulk_read_support(struct w1_slave *sl)
+{
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->bulk_read;
+
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
+
+	return false;  /* No device family */
+}
+
 /**
  * conversion_time() - get the Tconv for the slave
  * @sl: device to get the conversion time
@@ -722,6 +780,23 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 	/* save this pointer to the device structure */
 	SLAVE_SPECIFIC_FUNC(sl) = sl_family_conv;
 
+	if (bulk_read_support(sl)) {
+		/* add the sys entry to trigger bulk_read
+		 * at master level only the 1st time
+		 */
+		if (!bulk_read_device_counter) {
+			int err = device_create_file(&sl->master->dev,
+				&dev_attr_therm_bulk_read);
+
+			if (err)
+				dev_warn(&sl->dev,
+				"%s: Device has been added, but bulk read is unavailable. err=%d\n",
+				__func__, err);
+		}
+		/* Increment the counter */
+		bulk_read_device_counter++;
+	}
+
 	/* Getting the power mode of the device {external, parasite}*/
 	SLAVE_POWERMODE(sl) = read_powermode(sl);
 
@@ -744,6 +819,9 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 		}
 	}
 
+	/* Finally initialize convert_triggered flag */
+	SLAVE_CONVERT_TRIGGERED(sl) = 0;
+
 	return 0;
 }
 
@@ -751,6 +829,14 @@ static void w1_therm_remove_slave(struct w1_slave *sl)
 {
 	int refcnt = atomic_sub_return(1, THERM_REFCNT(sl->family_data));
 
+	if (bulk_read_support(sl)) {
+		bulk_read_device_counter--;
+		/* Delete the entry if no more device support the feature */
+		if (!bulk_read_device_counter)
+			device_remove_file(&sl->master->dev,
+				&dev_attr_therm_bulk_read);
+	}
+
 	while (refcnt) {
 		msleep(1000);
 		refcnt = atomic_read(THERM_REFCNT(sl->family_data));
@@ -1064,6 +1150,94 @@ error:
 	return ret;
 }
 
+static int trigger_bulk_read(struct w1_master *dev_master)
+{
+	struct w1_slave *sl = NULL; /* used to iterate through slaves */
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_conv = 0;
+	int ret = -ENODEV;
+	bool strong_pullup = false;
+
+	/* Check whether there are parasite powered device on the bus,
+	 * and compute duration of conversion for these devices
+	 * so we can apply a strong pullup if required
+	 */
+	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
+		if (!sl->family_data)
+			goto error;
+		if (bulk_read_support(sl)) {
+			int t_cur = conversion_time(sl);
+
+			t_conv = t_cur > t_conv ? t_cur : t_conv;
+			strong_pullup = strong_pullup ||
+					(w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
+		}
+	}
+
+	/* t_conv is the max conversion time required on the bus
+	 * If its 0, no device support the bulk read feature
+	 */
+	if (!t_conv)
+		goto error;
+
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto error;
+	}
+
+	while ((max_trying--) && (ret < 0)) { /* ret should be either 0 */
+
+		if (!w1_reset_bus(dev_master)) {	/* Just reset the bus */
+			unsigned long sleep_rem;
+
+			w1_write_8(dev_master, W1_SKIP_ROM);
+
+			if (strong_pullup)	/* Apply pullup if required */
+				w1_next_pullup(dev_master, t_conv);
+
+			w1_write_8(dev_master, W1_CONVERT_TEMP);
+
+			/* set a flag to instruct that converT pending */
+			list_for_each_entry(sl,
+				&dev_master->slist, w1_slave_entry) {
+				if (bulk_read_support(sl))
+					SLAVE_CONVERT_TRIGGERED(sl) = -1;
+			}
+
+			if (strong_pullup) { /*some device need pullup */
+				sleep_rem = msleep_interruptible(t_conv);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto mt_unlock;
+				}
+				mutex_unlock(&dev_master->bus_mutex);
+			} else {
+				mutex_unlock(&dev_master->bus_mutex);
+				sleep_rem = msleep_interruptible(t_conv);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto set_flag;
+				}
+			}
+			ret = 0;
+			goto set_flag;
+		}
+	}
+
+mt_unlock:
+	mutex_unlock(&dev_master->bus_mutex);
+set_flag:
+	/* set a flag to register convsersion is done */
+	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
+		if (bulk_read_support(sl))
+			SLAVE_CONVERT_TRIGGERED(sl) = 1;
+	}
+error:
+	return ret;
+}
+
 /* Sysfs Interface definition */
 
 static ssize_t w1_slave_show(struct device *device,
@@ -1075,7 +1249,20 @@ static ssize_t w1_slave_show(struct device *device,
 	int ret, i;
 	ssize_t c = PAGE_SIZE;
 
-	ret = convert_t(sl, &info);
+	if (bulk_read_support(sl)) {
+		if (SLAVE_CONVERT_TRIGGERED(sl) < 0) {
+			dev_dbg(device,
+				"%s: Conversion in progress, retry later\n",
+				__func__);
+			return 0;
+		} else if (SLAVE_CONVERT_TRIGGERED(sl) > 0) {
+			/* A bulk read has been issued, read the device RAM */
+			ret = read_scratchpad(sl, &info);
+			SLAVE_CONVERT_TRIGGERED(sl) = 0;
+		} else
+			ret = convert_t(sl, &info);
+	} else
+		ret = convert_t(sl, &info);
 
 	if (ret < 0) {
 		dev_dbg(device,
@@ -1156,7 +1343,20 @@ static ssize_t temperature_show(struct device *device,
 		return 0;  /* No device family */
 	}
 
-	ret = convert_t(sl, &info);
+	if (bulk_read_support(sl)) {
+		if (SLAVE_CONVERT_TRIGGERED(sl) < 0) {
+			dev_dbg(device,
+				"%s: Conversion in progress, retry later\n",
+				__func__);
+			return 0;
+		} else if (SLAVE_CONVERT_TRIGGERED(sl) > 0) {
+			/* A bulk read has been issued, read the device RAM */
+			ret = read_scratchpad(sl, &info);
+			SLAVE_CONVERT_TRIGGERED(sl) = 0;
+		} else
+			ret = convert_t(sl, &info);
+	} else
+		ret = convert_t(sl, &info);
 
 	if (ret < 0) {
 		dev_dbg(device,
@@ -1390,6 +1590,49 @@ free_m:
 	return size;
 }
 
+static ssize_t therm_bulk_read_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct w1_master *dev_master = dev_to_w1_master(device);
+	int ret = -EINVAL; // Invalid argument
+
+	if (size == sizeof(BULK_TRIGGER_CMD))
+		if (!strncmp(buf, BULK_TRIGGER_CMD,
+				sizeof(BULK_TRIGGER_CMD)-1))
+			ret = trigger_bulk_read(dev_master);
+
+	if (ret)
+		dev_info(device,
+			"%s: unable to trigger a bulk read on the bus. err=%d\n",
+			__func__, ret);
+
+	return size;
+}
+
+static ssize_t therm_bulk_read_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_master *dev_master = dev_to_w1_master(device);
+	struct w1_slave *sl = NULL;
+	int ret = 0;
+
+	list_for_each_entry(sl, &dev_master->slist, w1_slave_entry) {
+		if (sl->family_data) {
+			if (bulk_read_support(sl)) {
+				if (SLAVE_CONVERT_TRIGGERED(sl) == -1) {
+					ret = -1;
+					goto show_result;
+				}
+				if (SLAVE_CONVERT_TRIGGERED(sl) == 1)
+					/* continue to check other slaves */
+					ret = 1;
+			}
+		}
+	}
+show_result:
+	return sprintf(buf, "%d\n", ret);
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
-- 
2.26.2

