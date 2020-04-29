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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72212C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBC4206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+KCxue4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgD2XAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2XAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:00:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F42C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:00:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so4565102wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3KxK6bjL0OB0EIR5mFE74z6J4G8EdFfW/RdE8urrAo=;
        b=o+KCxue4qPRv0DLqMJPyij4SUkLDcduJifrSXGjXaldP0uBF4gDnGQjNPobS7EZaBb
         E1Oe56BjnwD6N6i25fiOOt2ZD5YBonqEY+l8ak8wM4nXw8Ex2bIuDMXyxiZxwcYz3WDG
         v2ZUb+xEIKge8U/Gr7cWb+4/DOWriIalgpHATswAyBjmFqNfQWYAwiF2Ix2xQVmJ0owx
         VeKZpcLqkcHdVxpN21Pwkf0irAz83GxnLh9QlVzQrwk+CPjdjaoRIdCN19xG6Tz3myfP
         OYwjcq52GkZ+bK1Gc4cigN056Yf2SvSxVc461l7AnjW90nn/QOWSNhtYCHVB1rEma6B5
         TC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3KxK6bjL0OB0EIR5mFE74z6J4G8EdFfW/RdE8urrAo=;
        b=bDL9i0d3U7AXcuLrA5tNj3LbL01vytWnkmyaphBTH9ttGM155jdzVs/dkeWq3hWERJ
         O+0Nd69xrA5PYeeAo/2VtNSt5nV3NUIHvRBVKCl8DBteRoW2HHXglm++T+5xNFLoFe0u
         V098fb1sQBG+v8qs/yZ/C0y/C6foT16unm/vzOhJfPmE0iwYKIVkqVna+WY5txtu17x0
         sx3yrlS+xfIwb7fgGRp6ekM6xBMCl9TZybDnZp9hpQv6uxcfN6DqynM+fJDUH4G4vkXJ
         uHWnhFvUOIGq7iBMxjy+TxOlzGiJSWQGruksqrT9yvLXj9jj8jProklB2n7G4tcDz9cb
         Q+ZA==
X-Gm-Message-State: AGi0PubWfIpnx2a126hl6a2AlvImbE0PAFaq3IPkXJU+4nYjFip9XoEN
        MGm05gJKKZAYun92krxwyjs=
X-Google-Smtp-Source: APiQypL7DvXQNDDLR7JAtUXiTv8NAAd5/vaa9HhlNLy3Lk9M8Eb6Acyt7I7hHf6MxgXH+8f4Sud6nQ==
X-Received: by 2002:adf:fe44:: with SMTP id m4mr311285wrs.188.1588201243168;
        Wed, 29 Apr 2020 16:00:43 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id s6sm9834867wmh.17.2020.04.29.16.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:00:42 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v4 4/9] w1_therm: adding ext_power sysfs entry
Date:   Thu, 30 Apr 2020 01:00:31 +0200
Message-Id: <20200429230031.199752-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding ext_power sysfs entry (RO). Return the power status of the device:
 - 0: device parasite powered
 - 1: device externally powered
 - xx: xx is kernel error

The power status of each device is check when the device is
discover by the bus master, in w1_therm_add_slave(struct w1_slave *).
The status is stored in the device structure w1_therm_family_data so
that the driver always knows the power state of each device, which could
be used later to determine the required strong pull up to apply on the
line.

The power status is re evaluate each time the sysfs ext_power read by
a user.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 .../ABI/testing/sysfs-driver-w1_therm         | 12 +++
 drivers/w1/slaves/w1_therm.c                  | 94 ++++++++++++++++++-
 drivers/w1/slaves/w1_therm.h                  | 43 ++++++++-
 3 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 4108f4c..9aaf625 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,15 @@
+What:		/sys/bus/w1/devices/.../ext_power
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RO) return the power status by asking the device
+			* `0`: device parasite powered
+			* `1`: device externally powered
+			* `-xx`: xx is kernel error when reading power status
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../w1_slave
 Date:		Apr 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 6245950..f10a210 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -39,12 +39,14 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_ext_power.attr,
 	NULL,
 };
 
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
+	&dev_attr_ext_power.attr,
 	NULL,
 };
 
@@ -294,6 +296,27 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 	return t;
 }
 
+/*------------------------ Helpers Functions----------------------------*/
+
+static inline bool bus_mutex_lock(struct mutex *lock)
+{
+	int max_trying = W1_THERM_MAX_TRY;
+
+	/* try to acquire the mutex, if not, sleep retry_delay before retry) */
+	while (mutex_lock_interruptible(lock) != 0 && max_trying > 0) {
+		unsigned long sleep_rem;
+
+		sleep_rem = msleep_interruptible(W1_THERM_RETRY_DELAY);
+		if (!sleep_rem)
+			max_trying--;
+	}
+
+	if (!max_trying)
+		return false;	/* Didn't acquire the bus mutex */
+
+	return true;
+}
+
 /*-------------------------Interface Functions------------------------------*/
 static int w1_therm_add_slave(struct w1_slave *sl)
 {
@@ -302,6 +325,16 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 	if (!sl->family_data)
 		return -ENOMEM;
 	atomic_set(THERM_REFCNT(sl->family_data), 1);
+
+	/* Getting the power mode of the device {external, parasite}*/
+	SLAVE_POWERMODE(sl) = read_powermode(sl);
+
+	if (SLAVE_POWERMODE(sl) < 0) {
+		/* no error returned as device has been added */
+		dev_warn(&sl->dev,
+			"%s: Device has been added, but power_mode may be corrupted. err=%d\n",
+			 __func__, SLAVE_POWERMODE(sl));
+	}
 	return 0;
 }
 
@@ -512,6 +545,43 @@ error:
 	return ret;
 }
 
+static int read_powermode(struct w1_slave *sl)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int  ret = -ENODEV;
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
+	while ((max_trying--) && (ret < 0)) {
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			w1_write_8(dev_master, W1_READ_PSUPPLY);
+			/* Read only one bit,
+			 * 1 is externally powered,
+			 * 0 is parasite powered
+			 */
+			ret = w1_touch_bit(dev_master, 1);
+			/* ret should be either 1 either 0 */
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
 /*------------------------Interface sysfs--------------------------*/
 
 static ssize_t w1_slave_show(struct device *device,
@@ -565,13 +635,35 @@ static ssize_t w1_slave_store(struct device *device,
 				ret = w1_therm_families[i].eeprom(device);
 			else
 				ret = w1_therm_families[i].precision(device,
-								val);
+									val);
 			break;
 		}
 	}
 	return ret ? : size;
 }
 
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	if (!sl->family_data) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+
+	/* Getting the power mode of the device {external, parasite}*/
+	SLAVE_POWERMODE(sl) = read_powermode(sl);
+
+	if (SLAVE_POWERMODE(sl) < 0) {
+		dev_dbg(device,
+			"%s: Power_mode may be corrupted. err=%d\n",
+			__func__, SLAVE_POWERMODE(sl));
+	}
+	return sprintf(buf, "%d\n", SLAVE_POWERMODE(sl));
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
index ba11c96..e4f4c9e 100644
--- a/drivers/w1/slaves/w1_therm.h
+++ b/drivers/w1/slaves/w1_therm.h
@@ -25,6 +25,11 @@
 #include <linux/mutex.h>
 #include <linux/w1.h>
 
+/* Nb of try for an operation */
+#define W1_THERM_MAX_TRY		5
+
+/* ms delay to retry bus mutex */
+#define W1_THERM_RETRY_DELAY		20
 /*----------------------------------Structs---------------------------------*/
 
 /**
@@ -47,10 +52,15 @@ struct w1_therm_family_converter {
  * struct w1_therm_family_data
  * @param rom data
  * @param refcnt ref count
+ * @param external_powered
+ *		1 device powered externally,
+ *		0 device parasite powered,
+ *		-x error or undefined
  */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
+	int external_powered;
 };
 
 /**
@@ -80,11 +90,24 @@ static inline int w1_DS18B20_convert_temp(u8 rom[9]);
 static inline int w1_DS18S20_convert_temp(u8 rom[9]);
 
 /*-------------------------------Macros--------------------------------------*/
+/* return the power mode of the sl slave : 1-ext, 0-parasite, <0 unknown
+ * always test family data existence before
+ */
+#define SLAVE_POWERMODE(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->external_powered)
 
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
 
+/*-------------------------- Helpers Functions------------------------------*/
+
+/** bus_mutex_lock() get the mutex & retry
+ *  @param lock w1 bus mutex to get
+ *  @return value true is mutex is acquired and lock, false otherwise
+ */
+static inline bool bus_mutex_lock(struct mutex *lock);
+
 /*---------------------------Hardware Functions-----------------------------*/
 
 /**
@@ -107,7 +130,14 @@ static int reset_select_slave(struct w1_slave *sl);
  */
 static ssize_t read_therm(struct device *device,
 			struct w1_slave *sl, struct therm_info *info);
-
+/** read_powermode()
+ * @brief ask the device to get its power mode {external, parasite}
+ * @param sl slave to be interrogated
+ * @return	0 parasite powered device
+ *			1 externally powered device
+ *			<0 kernel error code
+ */
+static int read_powermode(struct w1_slave *sl);
 /*----------------------------Interface sysfs-------------------------------*/
 
 /** @brief A callback function to output the temperature Old way
@@ -127,11 +157,20 @@ static ssize_t w1_slave_store(struct device *device,
 
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
-
+/** @brief A callback function to output the power mode of the device
+ *	Once done, it is stored in the sl->family_data to avoid doing the test
+ *	during data read
+ *  @return	0 : device parasite powered
+ *			1 : device externally powered
+ *			-xx : xx is kernel error code
+ */
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf);
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(ext_power);
 
 /*--------------------------Interface Functions-----------------------------*/
 
-- 
2.26.2

