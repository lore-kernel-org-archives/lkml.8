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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57508C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B11020731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIez2GCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgEJORB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgEJORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:17:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBA4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:17:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 50so7032057wrc.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+qaSERJUqQnNtsdOcphGgVQwPCafDcdJWuovFeeJJI=;
        b=IIez2GCS4akhiNwWzD/9V8yNtPpcWNhRyRvHh3Xov/d3gjPWmNsFFRLEAU+sRT2TQI
         vLiVQ20hpwMq2nCh29EkEbF8BZOeLhP97OGsAZ9i/aYedv7jAXcLvslPFjAwsq3fVo/8
         Py4uRFuczo5b2Pa99qcTDga1NulgU3GkYMxSTXGCnkbX7yMLuSjFqi6ExsGiAshUREg5
         plyKsY4hS07d5vjV5wSpDLxUOSg9+cldypb72huM5eVVfC0OJF5CIfPldSgkTHOF0op3
         0ox2L+cltpfbDiV0tMikLNsJC6RqM41tT1tca/M6gnsPp8bo0W/JOT9S+RtVH0dVDyCl
         3c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+qaSERJUqQnNtsdOcphGgVQwPCafDcdJWuovFeeJJI=;
        b=dnlFZlvItSM60QwEL5yyCMBadPhinwgyuUG7iOPfjfxFpQ1rObOQcBjF8ClkCYwix8
         YxYuIJwwiI/6s0dG5nAscgS4hTjCyNuOVRKkpHkHWVFQhihaH6k5ym7Fn+H2DIRRQnrl
         bMBp+ojD4Vs1ZOm6RukBh3nxA7rlOXkUVVPioXuXOPCX/g28CppsxU1it8KV6e68mwuG
         iE8WLFB6RuGR2kPqngUk4vNFCkhh86EHi5IbwNYjVFzV/Jsn4zp5Uudd+iC4EO1c75Mz
         /JUjCf6r+bKNSbHUpOEqGuErSmooTS/vxLn0wsy+go1kwcOKzrkGWeAzA9KLGGwKAunk
         VTxQ==
X-Gm-Message-State: AGi0Pua5D5pmPDWGQtikx1RTuR6nj6p0qri1qBpIVHKLZmuKsBKQFcgy
        9/tcM5VpArfKIhH+0C2qDxI=
X-Google-Smtp-Source: APiQypJPxe9cHWISFp+7RxNmEvFhMG4dvIbDYsWDSWneqJiZSJS4398Sm1bkn6oAU8MbKS5OJDJEJg==
X-Received: by 2002:adf:e944:: with SMTP id m4mr13470480wrn.366.1589120219169;
        Sun, 10 May 2020 07:16:59 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id k4sm19208346wmf.41.2020.05.10.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:16:58 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 4/9] w1_therm: adding ext_power sysfs entry
Date:   Sun, 10 May 2020 16:16:50 +0200
Message-Id: <20200510141650.173062-1-akira215corp@gmail.com>
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
discover by the bus master, in 'w1_therm_add_slave(struct w1_slave *)'.
The status is stored in the device structure w1_therm_family_data so
that the driver always knows the power state of each device, which could
be used later to determine the required strong pull up to apply on the
line.

The power status is re evaluate each time the sysfs ext_power read by
a user.

The hardware function 'read_powermode(struct w1_slave *sl)' act just as
per device specifications, sending W1_READ_PSUPPLY command on the bus,
and issue a read time slot, reading only one bit.

A helper function 'bool bus_mutex_lock(struct mutex *lock)' is introduced.
It try to aquire the bus mutex several times (W1_THERM_MAX_TRY), waiting
W1_THERM_RETRY_DELAY between two attempt.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include
Changes in v6:
- Formatting code comments according to kernel-doc requirements

 .../ABI/testing/sysfs-driver-w1_therm         |  12 ++
 drivers/w1/slaves/w1_therm.c                  | 135 ++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 4a85663..99d73ee 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,15 @@
+What:		/sys/bus/w1/devices/.../ext_power
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RO) return the power status by asking the device
+			* '0': device parasite powered
+			* '1': device externally powered
+			* '-xx': xx is kernel error when reading power status
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../w1_slave
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 5de1a67..08579dc 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -42,8 +42,20 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
+/* Nb of try for an operation */
+#define W1_THERM_MAX_TRY		5
+
+/* ms delay to retry bus mutex */
+#define W1_THERM_RETRY_DELAY		20
+
 /* Helpers Macros */
 
+/* return the power mode of the sl slave : 1-ext, 0-parasite, <0 unknown
+ * always test family data existence before
+ */
+#define SLAVE_POWERMODE(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->external_powered)
+
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
@@ -72,10 +84,14 @@ struct w1_therm_family_converter {
  * struct w1_therm_family_data - device data
  * @rom: ROM id of the device
  * @refcnt: ref count
+ * @external_powered:	1 device powered externally,
+ *				0 device parasite powered,
+ *				-x error or undefined
  */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
+	int external_powered;
 };
 
 /**
@@ -108,6 +124,20 @@ struct therm_info {
  */
 static int reset_select_slave(struct w1_slave *sl);
 
+/**
+ * read_powermode() - Query the power mode of the slave
+ * @sl: slave to retrieve the power mode
+ *
+ * Ask the device to get its power mode (external or parasite)
+ * and store the power status in the &struct w1_therm_family_data.
+ *
+ * Return:
+ * * 0 parasite powered device
+ * * 1 externally powered device
+ * * <0 kernel error code
+ */
+static int read_powermode(struct w1_slave *sl);
+
 /* Sysfs interface declaration */
 
 static ssize_t w1_slave_show(struct device *device,
@@ -119,10 +149,14 @@ static ssize_t w1_slave_store(struct device *device,
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(ext_power);
 
 /* Interface Functions declaration */
 
@@ -150,12 +184,14 @@ static void w1_therm_remove_slave(struct w1_slave *sl);
 
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
 
@@ -417,6 +453,34 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 
 /* Helpers Functions */
 
+/**
+ * bus_mutex_lock() - Acquire the mutex
+ * @lock: w1 bus mutex to acquire
+ *
+ * It try to acquire the mutex W1_THERM_MAX_TRY times and wait
+ * W1_THERM_RETRY_DELAY between 2 attempts.
+ *
+ * Return: true is mutex is acquired and lock, false otherwise
+ */
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
 static inline int w1_convert_temp(u8 rom[9], u8 fid)
 {
 	int i;
@@ -436,7 +500,19 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 		GFP_KERNEL);
 	if (!sl->family_data)
 		return -ENOMEM;
+
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
+
 	return 0;
 }
 
@@ -636,6 +712,43 @@ error:
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
 /* Sysfs Interface definition */
 
 static ssize_t w1_slave_show(struct device *device,
@@ -697,6 +810,28 @@ static ssize_t w1_slave_store(struct device *device,
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
-- 
2.26.2

