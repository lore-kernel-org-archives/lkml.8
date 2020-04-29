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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300CDC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0884A206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYeOLgVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgD2NeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgD2NeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:34:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D11C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:34:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so2535249wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWjoLz4m5yHmRo9LMIvAUfjqnNKsovRwzYwrOJ1JeU8=;
        b=EYeOLgVnJwlqmYEaJEt29olhAC9Ta+bTseXdF7UltD/wqSgb4e/lsYSBgQP3xa85Q8
         XRkCLXxQgp6bxqmfT2uKL2yNU225U7DrLSB+Npqk3M4WNy2qYoUJuOjoBDp73/+BJhjl
         aIwqRockPe94WYbc2J8Z2zxJfDli3pLoq8NpC+E7Pvaqbtkdmymh3MP3btuArtAWdJo+
         nb2Qa18dkX9Gvusd0i9iLuVVQIPbvDMO1a78VpWl10Uh3CfZ3/yNAbi3Ts8POkn5yoyc
         TDUI5zNm5OpUPqTpai2m6EydJSStXGFYGuJsTcA/2d47s+4r5SKZ/akOIGldAAH0IrVg
         fiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWjoLz4m5yHmRo9LMIvAUfjqnNKsovRwzYwrOJ1JeU8=;
        b=b/fQ2uIixGuGvLyYB0FGQtC1s28eTkYveuskb88dHJUSyI1MgTsfFFRGEv+yBd1dPu
         +aHFwe29A3rfFc6mOBo7fHsg/UCpXWnaxbC+t1aLay4+mEgtlSliE7DhGqXyR4/p1VCr
         x7Q/EsyrV5GuBgboQDkFVC34g/TFDl4no4VKKKErJH7jsgZ57ayuH9qUPEFBdtOxLG12
         LlcCECrDp5THehxGCzqnAKjyXos/LkfDkAzakF8RRcrcuo+VZ/06BoAgYNrWanutKGco
         7B3SB28i6qYmmNIsyeaOAowk3lp9L4eqTwOPBaXW20Ju2lCVKqtODMDilfPkTDfakf1u
         VZDw==
X-Gm-Message-State: AGi0PuYH7mSpvwksEi2TsWINZUD+N9L62XvAe6x76jaU3IxpTFCFhEcK
        tJs3/vf2awflEH+s4nPAEjOYNeUG
X-Google-Smtp-Source: APiQypJeRtrkjIvqYxKHHJl0aQP8BxfOkGAW3E9JW3ZYW/WTAEMb6dolh709xQxg45Dt8eIpwz++Wg==
X-Received: by 2002:adf:e450:: with SMTP id t16mr42285744wrm.301.1588167258163;
        Wed, 29 Apr 2020 06:34:18 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id z1sm7919098wmf.15.2020.04.29.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:34:17 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v3 4/5] w1_therm: alarms support by adding sysfs entry. Updating doc
Date:   Wed, 29 Apr 2020 15:34:09 +0200
Message-Id: <20200429133409.141273-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for enhacement of w1_therm module. Adding device alarms settings
by a dedicated sysfs entry alarms (RW) : read or write TH and TL in the
device RAM. Checking devices in alarm state could be performed using
the master search command.

Updating doc in Documentation/ABI/testing/sysfs-driver-w1_therm
accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
 .../ABI/testing/sysfs-driver-w1_therm         |  15 ++
 drivers/w1/slaves/w1_therm.c                  | 129 ++++++++++++++++++
 drivers/w1/slaves/w1_therm.h                  |  12 ++
 3 files changed, 156 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 279e13d..39488a4 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,18 @@
+What:		/sys/bus/w1/devices/.../alarms
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) read or write TH and TL (Temperature High an Low) alarms.
+		Values shall be space separated and in the device range
+		(typical -55 degC to 125 degC). Values are integer as they
+		are store in a 8bit register in the device.
+		Lowest value is automatically put to TL.
+		Once set, alarms could be search at master level, refer to
+		Documentation/w1/w1_generic.rst for detailed information
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../eeprom
 Date:		Apr 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 3ddf2b1..db75048 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -68,6 +68,12 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  *				(device do that automatically on power-up)
  *
  *
+ * alarms (RW) : read TH and TL (Temperature High an Low) alarms
+ *	Values shall be space separated and in the device range
+ *	(typically -55° to 125°)
+ *	Values are integer are they are store in a 8bit field in the device
+ *	Lowest value is automatically put to TL
+ *
  */
 
 /*
@@ -81,6 +87,7 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -89,6 +96,7 @@ static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -99,6 +107,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
+	&dev_attr_alarms.attr,
 	NULL,
 };
 
@@ -207,6 +216,7 @@ static struct w1_family w1_therm_family_DS1825 = {
 };
 
 /*----------------------Device capability description-----------------------*/
+
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
 		.f			= &w1_therm_family_DS18S20,
@@ -1009,6 +1019,125 @@ static ssize_t eeprom_store(struct device *device,
 	return size;
 }
 
+static ssize_t alarms_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int ret = -ENODEV;
+	s8 th = 0, tl = 0;
+	struct therm_info scratchpad;
+
+	ret = read_scratchpad(sl, &scratchpad);
+
+	if (!ret)	{
+		th = scratchpad.rom[2]; // TH is byte 2
+		tl = scratchpad.rom[3]; // TL is byte 3
+	} else {
+		dev_info(device,
+			"%s: error reading alarms register %d\n",
+			__func__, ret);
+	}
+
+	return sprintf(buf, "%hd %hd\n", tl, th);
+}
+
+static ssize_t alarms_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	struct therm_info info;
+	u8 new_config_register[3];	/* array of data to be written */
+	int temp, ret = -EINVAL;
+	char *token = NULL;
+	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	char *p_args = kmalloc(size, GFP_KERNEL);
+
+	/* Safe string copys as buf is const */
+	if (!p_args) {
+		dev_warn(device,
+			"%s: error unable to allocate memory %d\n",
+			__func__, -ENOMEM);
+		return size;
+	}
+	strcpy(p_args, buf);
+
+	/* Split string using space char */
+	token = strsep(&p_args, " ");
+
+	if (!token)	{
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, -EINVAL);
+		goto free_m;
+	}
+
+	/* Convert 1st entry to int */
+	ret = kstrtoint (token, 10, &temp);
+	if (ret) {
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, ret);
+		goto free_m;
+	}
+
+	tl = int_to_short(temp);
+
+	/* Split string using space char */
+	token = strsep(&p_args, " ");
+	if (!token)	{
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, -EINVAL);
+		goto free_m;
+	}
+	/* Convert 2nd entry to int */
+	ret = kstrtoint (token, 10, &temp);
+	if (ret) {
+		dev_info(device,
+			"%s: error parsing args %d\n", __func__, ret);
+		goto free_m;
+	}
+
+	/* Prepare to cast to short by eliminating out of range values */
+	th = int_to_short(temp);
+
+	/* Reorder if required th and tl */
+	if (tl > th) {
+		tt = tl; tl = th; th = tt;
+	}
+
+	/* Read the scratchpad to change only the required bits
+	 * (th : byte 2 - tl: byte 3)
+	 */
+	ret = read_scratchpad(sl, &info);
+	if (!ret) {
+		new_config_register[0] = th;	// Byte 2
+		new_config_register[1] = tl;	// Byte 3
+		new_config_register[2] = info.rom[4];// Byte 4
+	} else {
+		dev_info(device,
+			"%s: error reading from the slave device %d\n",
+			__func__, ret);
+		goto free_m;
+	}
+
+	/* Write data in the device RAM */
+	if (!SLAVE_SPECIFIC_FUNC(sl)) {
+		dev_info(device,
+			"%s: Device not supported by the driver %d\n",
+			__func__, -ENODEV);
+		goto free_m;
+	}
+
+	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
+	if (ret)
+		dev_info(device,
+			"%s: error writing to the slave device %d\n",
+			__func__, ret);
+
+free_m:
+	/* free allocated memory */
+	kfree(p_args);
+
+	return size;
+}
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
index 487156f..4f2dcf0 100644
--- a/drivers/w1/slaves/w1_therm.h
+++ b/drivers/w1/slaves/w1_therm.h
@@ -287,6 +287,17 @@ static ssize_t resolution_store(struct device *device,
 static ssize_t eeprom_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
+/** @brief A callback function to set the alarms level
+ *  @param device represents the master device
+ */
+static ssize_t alarms_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
+/** @brief A callback function to get the alarms level
+ *  @return Low and High alarm, separate by one space
+ */
+static ssize_t alarms_show(struct device *device,
+	struct device_attribute *attr, char *buf);
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
@@ -295,6 +306,7 @@ static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
+static DEVICE_ATTR_RW(alarms);
 
 /*--------------------------Interface Functions-----------------------------*/
 
-- 
2.25.4

