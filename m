Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA922C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7302071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q04+UCJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAVQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43079 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so44864pfo.10;
        Wed, 22 Jan 2020 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TWeVdE7IiqXKwtqthavTGOK3VlPsF519h/qxKiwBH8=;
        b=Q04+UCJbkn0aGqOvHG1qMBRBugH6EfoNRf1lcdVgRFcyunWgkVZqApALS5WiISLcp3
         YFFOFV06XecAkSmcWRP5+ZGHSr0uXEFL0wFg2L3vDcsegBatJ8aiRQMMZV1nbHp9FNqk
         IBzEVvROnj4mynAIATz9POmp9uLH6CDcsS7ONvgsQPgpDCEZj6rpqi+uyKJm7kAOhs7a
         OotQ6qFmjhRrLVh3ogGnrufdH9h3RUaNQr3E9+Zy2FzuUXobGtR86ubb2drf2OANx0Zk
         blnhbiwvawL7l7Z8QPvpHvDlFT0oEPyqrCJVe4apVCASsxAoV3mjnI7c6D4yKXhrZPFI
         /U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2TWeVdE7IiqXKwtqthavTGOK3VlPsF519h/qxKiwBH8=;
        b=XSpqT+89P29ErfOdt33dhVIhLuqG4hetaKnHOBqeQQUw8nfjKk5JOW1t0R7o/h0ULM
         Ya1JKbsbX/X0Y1Wnk2mj9KeWsjj/xPmmqgVU57dxhy+9TC/H5ow+Dj4TMSfRTeJ9Xy9O
         AejMtRy9hzi8bMu8W+pbs+fgrf8whEKbqOMMXiIxs6Y3tvphZ/9DjW2WociQNvHpzgUp
         sEhkkq7BgyILKgsAIphmtl8XZHqFqeXpKj/Zcn7m6AykdYA0o/M4LFEsvYkviq2mNkTx
         f3fmuSytMXHwqmpawJ5e7wuVI+QEV5TKOGYQY6owa6Gec1BXzDiVxRm3eXV5Jjt4lksR
         Eq6w==
X-Gm-Message-State: APjAAAV9xPgHeE6qKf1H6wbViZwoDo59mSR1hIxpSpqB2K+51Kl84hkc
        x0lIo+Bj48HcTDate27IJdSpfn1H
X-Google-Smtp-Source: APXvYqyS8qPXyc4c4HW0sJyyoBsL9RbuNfFp3CUx+mrZ06vK503mVt7kjj7xiIjExGOWcA1DeNj/cg==
X-Received: by 2002:a65:55cd:: with SMTP id k13mr11437301pgs.197.1579709289563;
        Wed, 22 Jan 2020 08:08:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d129sm49426895pfd.115.2020.01.22.08.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 08:08:08 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 2/6] hmon: (k10temp) Convert to use devm_hwmon_device_register_with_info
Date:   Wed, 22 Jan 2020 08:07:56 -0800
Message-Id: <20200122160800.12560-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
References: <20200122160800.12560-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use devm_hwmon_device_register_with_info to simplify
the code and to reduce its size.

Old size (x86_64):
   text	   data	    bss	    dec	    hex	filename
   8247	   4488	     64	  12799	   31ff	drivers/hwmon/k10temp.o
New size:
   text	   data	    bss	    dec	    hex	filename
   6778	   2792	     64	   9634	   25a2	drivers/hwmon/k10temp.o

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
Tested-by: Michael Larabel <michael@phoronix.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Ken Moffat <zarniwhoop73@googlemail.com>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 213 +++++++++++++++++++++-------------------
 1 file changed, 112 insertions(+), 101 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 8807d7da68db..c45f6498a59b 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * k10temp.c - AMD Family 10h/11h/12h/14h/15h/16h processor hardware monitoring
+ * k10temp.c - AMD Family 10h/11h/12h/14h/15h/16h/17h
+ *		processor hardware monitoring
  *
  * Copyright (c) 2009 Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2020 Guenter Roeck <linux@roeck-us.net>
  */
 
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -127,10 +128,10 @@ static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
 		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
-static unsigned int get_raw_temp(struct k10temp_data *data)
+static long get_raw_temp(struct k10temp_data *data)
 {
-	unsigned int temp;
 	u32 regval;
+	long temp;
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> CUR_TEMP_SHIFT) * 125;
@@ -139,118 +140,108 @@ static unsigned int get_raw_temp(struct k10temp_data *data)
 	return temp;
 }
 
-static ssize_t temp1_input_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct k10temp_data *data = dev_get_drvdata(dev);
-	unsigned int temp = get_raw_temp(data);
-
-	if (temp > data->temp_offset)
-		temp -= data->temp_offset;
-	else
-		temp = 0;
-
-	return sprintf(buf, "%u\n", temp);
-}
-
-static ssize_t temp2_input_show(struct device *dev,
-				struct device_attribute *devattr, char *buf)
-{
-	struct k10temp_data *data = dev_get_drvdata(dev);
-	unsigned int temp = get_raw_temp(data);
-
-	return sprintf(buf, "%u\n", temp);
-}
-
-static ssize_t temp_label_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-
-	return sprintf(buf, "%s\n", attr->index ? "Tctl" : "Tdie");
-}
+const char *k10temp_temp_label[] = {
+	"Tdie",
+	"Tctl",
+};
 
-static ssize_t temp1_max_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static int k10temp_read_labels(struct device *dev,
+			       enum hwmon_sensor_types type,
+			       u32 attr, int channel, const char **str)
 {
-	return sprintf(buf, "%d\n", 70 * 1000);
+	*str = k10temp_temp_label[channel];
+	return 0;
 }
 
-static ssize_t temp_crit_show(struct device *dev,
-			      struct device_attribute *devattr, char *buf)
+static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct k10temp_data *data = dev_get_drvdata(dev);
-	int show_hyst = attr->index;
 	u32 regval;
-	int value;
 
-	data->read_htcreg(data->pdev, &regval);
-	value = ((regval >> 16) & 0x7f) * 500 + 52000;
-	if (show_hyst)
-		value -= ((regval >> 24) & 0xf) * 500;
-	return sprintf(buf, "%d\n", value);
+	switch (attr) {
+	case hwmon_temp_input:
+		switch (channel) {
+		case 0:		/* Tdie */
+			*val = get_raw_temp(data) - data->temp_offset;
+			if (*val < 0)
+				*val = 0;
+			break;
+		case 1:		/* Tctl */
+			*val = get_raw_temp(data);
+			if (*val < 0)
+				*val = 0;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_temp_max:
+		*val = 70 * 1000;
+		break;
+	case hwmon_temp_crit:
+		data->read_htcreg(data->pdev, &regval);
+		*val = ((regval >> 16) & 0x7f) * 500 + 52000;
+		break;
+	case hwmon_temp_crit_hyst:
+		data->read_htcreg(data->pdev, &regval);
+		*val = (((regval >> 16) & 0x7f)
+			- ((regval >> 24) & 0xf)) * 500 + 52000;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
-static DEVICE_ATTR_RO(temp1_input);
-static DEVICE_ATTR_RO(temp1_max);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit, temp_crit, 0);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, temp_crit, 1);
-
-static SENSOR_DEVICE_ATTR_RO(temp1_label, temp_label, 0);
-static DEVICE_ATTR_RO(temp2_input);
-static SENSOR_DEVICE_ATTR_RO(temp2_label, temp_label, 1);
-
-static umode_t k10temp_is_visible(struct kobject *kobj,
-				  struct attribute *attr, int index)
+static umode_t k10temp_is_visible(const void *_data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct k10temp_data *data = dev_get_drvdata(dev);
+	const struct k10temp_data *data = _data;
 	struct pci_dev *pdev = data->pdev;
 	u32 reg;
 
-	switch (index) {
-	case 0 ... 1:	/* temp1_input, temp1_max */
-	default:
-		break;
-	case 2 ... 3:	/* temp1_crit, temp1_crit_hyst */
-		if (!data->read_htcreg)
-			return 0;
-
-		pci_read_config_dword(pdev, REG_NORTHBRIDGE_CAPABILITIES,
-				      &reg);
-		if (!(reg & NB_CAP_HTC))
-			return 0;
-
-		data->read_htcreg(data->pdev, &reg);
-		if (!(reg & HTC_ENABLE))
-			return 0;
-		break;
-	case 4 ... 6:	/* temp1_label, temp2_input, temp2_label */
-		if (!data->show_tdie)
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			if (channel && !data->show_tdie)
+				return 0;
+			break;
+		case hwmon_temp_max:
+			if (channel)
+				return 0;
+			break;
+		case hwmon_temp_crit:
+		case hwmon_temp_crit_hyst:
+			if (channel || !data->read_htcreg)
+				return 0;
+
+			pci_read_config_dword(pdev,
+					      REG_NORTHBRIDGE_CAPABILITIES,
+					      &reg);
+			if (!(reg & NB_CAP_HTC))
+				return 0;
+
+			data->read_htcreg(data->pdev, &reg);
+			if (!(reg & HTC_ENABLE))
+				return 0;
+			break;
+		case hwmon_temp_label:
+			if (!data->show_tdie)
+				return 0;
+			break;
+		default:
 			return 0;
+		}
 		break;
+	default:
+		return 0;
 	}
-	return attr->mode;
+	return 0444;
 }
 
-static struct attribute *k10temp_attrs[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_max.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_label.dev_attr.attr,
-	&dev_attr_temp2_input.attr,
-	&sensor_dev_attr_temp2_label.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group k10temp_group = {
-	.attrs = k10temp_attrs,
-	.is_visible = k10temp_is_visible,
-};
-__ATTRIBUTE_GROUPS(k10temp);
-
 static bool has_erratum_319(struct pci_dev *pdev)
 {
 	u32 pkg_type, reg_dram_cfg;
@@ -285,8 +276,27 @@ static bool has_erratum_319(struct pci_dev *pdev)
 	       (boot_cpu_data.x86_model == 4 && boot_cpu_data.x86_stepping <= 2);
 }
 
-static int k10temp_probe(struct pci_dev *pdev,
-				   const struct pci_device_id *id)
+static const struct hwmon_channel_info *k10temp_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops k10temp_hwmon_ops = {
+	.is_visible = k10temp_is_visible,
+	.read = k10temp_read,
+	.read_string = k10temp_read_labels,
+};
+
+static const struct hwmon_chip_info k10temp_chip_info = {
+	.ops = &k10temp_hwmon_ops,
+	.info = k10temp_info,
+};
+
+static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int unreliable = has_erratum_319(pdev);
 	struct device *dev = &pdev->dev;
@@ -334,8 +344,9 @@ static int k10temp_probe(struct pci_dev *pdev,
 		}
 	}
 
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "k10temp", data,
-							   k10temp_groups);
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "k10temp", data,
+							 &k10temp_chip_info,
+							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-- 
2.17.1

