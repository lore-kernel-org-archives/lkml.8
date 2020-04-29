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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA90EC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9171A208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oC8ditv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgD2NcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgD2NcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:32:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDADC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:32:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so2044261wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fJnYdS4VG0q/JLhQJrpuQtUR2IKM19c1tFbCpF+iK8=;
        b=oC8ditv7GxkzZ8PTAkM/gjOTmziHKoRhb2KZDjmQ2zQd2Y60Kss2tsrA3N/76YmykP
         geQQ0BC/9AUaAdsc9/M7Q2ogRGb4YDl2JwAOO8hMQxZGWo7HZJi3KOVpTQMO9xhuoBDq
         8KXL1gNyGPUClTLHUmiIpkBCtnwgmMCn8SiprEGk38FlTKp0d/9xqrtyYia/Aidq1bIZ
         VWM0ykLRhpuWPYyoWmZ5WqGyuZSfn0sPr4njT7meeQt+hBHvmhZO3RmhZqR38al4SZSO
         ar8rdTveNPNH8OMNt78mc5nj/SaZlsEbyxGUrDKAc7tEIsea3d3hodqJ3arcHJsXozyR
         m5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fJnYdS4VG0q/JLhQJrpuQtUR2IKM19c1tFbCpF+iK8=;
        b=TAKCuwN5Gw6iClglMDRJAARFEKXTqjaKXogj22Fo8+i8ZU65Vh5Pj6wtSsiRPv2a4f
         h38CEk1OV+ZCE1TqNt0beYmRg1/mqvPq0gwCxq0lZYpJuYou351pf9XhE3ZDOjJTRiCq
         vwKOpV5k12kzw7ah2PhsVWmYXS76zXnEa+tu9vOr4dtwjg5NRKsqhvgh6cd4g7m4ad/k
         1C3F4HAYhgs9p7oFS97FnURTb1s222ipVIHI6kv8fBI2GDWAYom2s4zHiThff4burvCB
         7yEp4Zqc97PGOr+/C2oNtNpmWOCjVofuSNEg1j5I72WKcXtU7iFMk9MNhGnggLgo9J2O
         qOTg==
X-Gm-Message-State: AGi0PubSrLaQpS2MZtsdJgiAiCEWIHbddjI8uE4DOFpZzh7jGHZwYhm9
        Qvz1whfnDUKRkhyxeaQeuuw=
X-Google-Smtp-Source: APiQypLJ+JJFK0SuAjhzvvjRMI2YFyrSWHRlP2QLpDZzgqB0GdhzgVGXqkcenGX55Ih8N0OGTII5hA==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr3295329wme.58.1588167139181;
        Wed, 29 Apr 2020 06:32:19 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id s17sm7640296wmc.48.2020.04.29.06.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:32:18 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v3 2/5] w1_therm: adding sysfs entry to check device power
Date:   Wed, 29 Apr 2020 15:32:04 +0200
Message-Id: <20200429133204.140081-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for enhacement of w1_therm module.
Adding ext_power sysfs entry (RO). Return the power status of the device:
 - 0: device parasite powered
 - 1: device externally powered
 - xx: xx is kernel error

Creating Documentation/ABI/testing/sysfs-driver-w1_therm for the old 
driver sysfs and this new entry.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 .../ABI/testing/sysfs-driver-w1_therm         | 29 ++++++
 drivers/w1/slaves/w1_therm.c                  | 93 ++++++++++++++++++-
 drivers/w1/slaves/w1_therm.h                  | 44 ++++++++-
 3 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_therm

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
new file mode 100644
index 0000000..9aaf625
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -0,0 +1,29 @@
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
+What:		/sys/bus/w1/devices/.../w1_slave
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) return the temperature in 1/1000 degC.
+		*read*: return 2 lines with the hexa output data sent on the
+		bus, return the CRC check and temperature in 1/1000 degC
+		*write* :
+			* `0` : save the 2 or 3 bytes to the device EEPROM
+			(i.e. TH, TL and config register)
+			* `9..12` : set the device resolution in RAM
+			(if supported)
+			* Anything else: do nothing
+		refer to Documentation/w1/slaves/w1_therm.rst for detailed
+		information.
+Users:		any user space application which wants to communicate with
+		w1_term device
\ No newline at end of file
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 6245950..a530853 100644
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
 
@@ -294,6 +296,26 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 	return t;
 }
 
+/*------------------------ Helpers Functions----------------------------*/
+
+static inline bool bus_mutex_lock(struct mutex *lock)
+{
+	int max_trying = W1_THERM_MAX_TRY;
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
@@ -302,6 +324,16 @@ static int w1_therm_add_slave(struct w1_slave *sl)
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
 
@@ -512,6 +544,43 @@ error:
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
@@ -565,13 +634,35 @@ static ssize_t w1_slave_store(struct device *device,
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
index b73af0b..2f975a4 100644
--- a/drivers/w1/slaves/w1_therm.h
+++ b/drivers/w1/slaves/w1_therm.h
@@ -25,6 +25,12 @@
 #include <linux/mutex.h>
 #include <linux/w1.h>
 
+/*----------------------------------Defines---------------------------------*/
+/* Nb of try for an operation */
+#define W1_THERM_MAX_TRY		5
+
+/* ms delay to retry bus mutex */
+#define W1_THERM_RETRY_DELAY		20
 /*----------------------------------Structs---------------------------------*/
 
 /**
@@ -47,10 +53,15 @@ struct w1_therm_family_converter {
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
@@ -80,11 +91,24 @@ static inline int w1_DS18B20_convert_temp(u8 rom[9]);
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
@@ -107,7 +131,14 @@ static int reset_select_slave(struct w1_slave *sl);
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
@@ -127,11 +158,20 @@ static ssize_t w1_slave_store(struct device *device,
 
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
2.25.4

