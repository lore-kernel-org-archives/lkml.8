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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD71C47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DDB208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5GC/Vqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgEJADG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEJADG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:03:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E7C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 17:03:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so14664395wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IF1Y5c6pOa1E37Km0G5JAiVYTaD0Rm4Lp5dWhmM5gD0=;
        b=K5GC/Vqp5K+FvipseQmW80zYRcAo26JvC86GXIshlUmiw6MHFsMqA/kVDpeQTpe23+
         pNOFCzJrMe0/J7dl5WqV4Y7devZaSFzcCtuI2aqO76DylJxKDPWfD+bQm5VW8sqkBqNJ
         eHM1rQKPJeo3yimfFhl0zIq2zegEKj48UXX6JRjUqvt9sX7YJPXu3WcO0jtkkpydFmGe
         4GdiAxacwxS30nonU1H9OMbgPvGWT/bUgfShlMBvi5V7SdYcvf5YTmxuxzNiPaUfrxc4
         q7VNWMD62pwZtzXq2KCtwEGTRrmx0smE6GBlKlLuQGiCcblFKF1BoHDUzjvt3XagUsQx
         /uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IF1Y5c6pOa1E37Km0G5JAiVYTaD0Rm4Lp5dWhmM5gD0=;
        b=NyDW8+zseQenGcQ9Zlb1C7g0rYaRqTURKnGjDd8msPKvToEyPa0Z6pYrJgkA4OGgdK
         bXxFG8wkoxf0ZSiUEv2TR0rE3/mjQm6nFwbSdo06Uw24qe28Vd+opFzPRRKPxEfAM+R4
         LKEMe8YSHryzm/l25gsUiMib0I6II2o+a7z7/XcMPFP2a6ltz3b3M2FuvdMxGnufj/KW
         fDFMQUOTKbgFZBYN3p69+rNTQ5esh+zWl1TOCnUJFrRZoDL4gdVJi+F4qqJeYJduVfVu
         a4rauhHfukq+i4noXtrEVI9C688vrSWDaLdx2Ng+71veCVQXPjRDQ1H9gF1nDMwr9EXX
         uKnQ==
X-Gm-Message-State: AGi0PuZC5Ckse+5mB4cFx/XYMFsE05jvY7DDNejZ26q44WNP57Ye/5n2
        /T5CTLuaBGfmJZk1gldz0+o=
X-Google-Smtp-Source: APiQypKKr4+Qo4z/hCMnjLWljkPtjckAM6M0A45YWd60ae0ATkUwWtI8XTxpJeGWYqWlDoBbL/jrSQ==
X-Received: by 2002:a7b:cf15:: with SMTP id l21mr4573000wmg.172.1589068984429;
        Sat, 09 May 2020 17:03:04 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id x1sm1784055wrt.86.2020.05.09.17.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:03:03 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 9/9] w1_therm: adding bulk read support to trigger multiple conversion on bus
Date:   Sun, 10 May 2020 02:02:56 +0200
Message-Id: <20200510000256.425760-1-akira215corp@gmail.com>
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
index cd65d0b..68462ee 100644
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
+ *  0: no bulk read is pending
+ * -1: conversion is in progress
+ *  1: conversion done, result to be read
+ */
+#define SLAVE_CONVERT_TRIGGERED(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->convert_triggered)
+
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
@@ -101,6 +113,7 @@ struct w1_therm_family_converter {
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
 	int		(*write_data)(struct w1_slave *sl, const u8 *data);
+	bool		bulk_read;
 };
 
 /**
@@ -118,6 +131,7 @@ struct w1_therm_family_data {
 	atomic_t refcnt;
 	int external_powered;
 	int resolution;
+	int convert_triggered;
 	struct w1_therm_family_converter *specific_functions;
 };
 
@@ -193,6 +207,14 @@ static int recall_eeprom(struct w1_slave *sl);
  */
 static int read_powermode(struct w1_slave *sl);
 
+/** trigger_bulk_read()
+ * \brief send a SKIP ROM follow by a CONVERT T commmand
+ * on the bus. It also set a flag in each slave struct to signal
+ * \param dev_master the device master of the bus
+ * \return 0 if success, -kernel error code otherwise
+ */
+static int trigger_bulk_read(struct w1_master *dev_master);
+
 /*-----------------------Interface sysfs declaration------------------------*/
 
 /** \brief A callback function to output the temperature Old way
@@ -264,6 +286,20 @@ static ssize_t alarms_store(struct device *device,
 static ssize_t alarms_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+/** \brief A callback function to trigger bulk read on the bus
+ *  \param check BULK_TRIGGER_CMD macro
+ */
+static ssize_t therm_bulk_read_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+/** \brief A callback function to check if bulk read is on progress
+ *  \return	-1 conversion in progress
+ *			1 conversion complete but not read on all sensors
+ *			0 no bulk operation pending
+ */
+static ssize_t therm_bulk_read_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
@@ -274,6 +310,8 @@ static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
 static DEVICE_ATTR_RW(alarms);
 
+static DEVICE_ATTR_RW(therm_bulk_read); /* attribut at master level */
+
 /*--------------------Interface Functions declaration-----------------------*/
 
 /** w1_therm_add_slave() - Called each time a search discover a new device
@@ -564,6 +602,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= NULL,	// no config register
 		.get_resolution		= NULL,	// no config register
 		.write_data			= w1_DS18S20_write_data,
+		.bulk_read			= true
 	},
 	{
 		.f				= &w1_therm_family_DS1822,
@@ -572,6 +611,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= true
 	},
 	{
 		.f				= &w1_therm_family_DS18B20,
@@ -580,6 +620,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= true
 	},
 	{
 		.f				= &w1_therm_family_DS28EA00,
@@ -588,6 +629,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= false
 	},
 	{
 		.f				= &w1_therm_family_DS1825,
@@ -596,6 +638,7 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
+		.bulk_read			= true
 	}
 };
 
@@ -644,6 +687,21 @@ static inline bool bus_mutex_lock(struct mutex *lock)
 	return true;
 }
 
+/** support_bulk_read() check if slave support bulk read
+ *  \param sl device to get the conversion time
+ *  \return true : bulk read support, false : no support or error
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
 /** conversion_time() get the Tconv for the slave
  *  \param sl device to get the conversion time
  *  \return conversion time in ms, negative values kernel error code
@@ -711,6 +769,23 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 	}
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
 
@@ -733,6 +808,9 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 		}
 	}
 
+	/* Finally initialize convert_triggered flag */
+	SLAVE_CONVERT_TRIGGERED(sl) = 0;
+
 	return 0;
 }
 
@@ -740,6 +818,14 @@ static void w1_therm_remove_slave(struct w1_slave *sl)
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
@@ -1053,6 +1139,94 @@ error:
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
 /*-----------------------------Interface sysfs------------------------------*/
 
 static ssize_t w1_slave_show(struct device *device,
@@ -1064,7 +1238,20 @@ static ssize_t w1_slave_show(struct device *device,
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
@@ -1145,7 +1332,20 @@ static ssize_t temperature_show(struct device *device,
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
@@ -1379,6 +1579,49 @@ free_m:
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

