Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F7C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523732469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaQJaMW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgARR0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:26:36 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43341 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgARR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:26:36 -0500
Received: by mail-yb1-f196.google.com with SMTP id k15so7714403ybd.10;
        Sat, 18 Jan 2020 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OMTLrqbJGjpPtOvQXK7GqxkakiNc6MEfg8N93L8aG00=;
        b=BaQJaMW1uBE4OAFtAAge2ZJ6uKhdkgYufRRHe7TGogjQh5XF8QXX6KuEPsP/VrBWKL
         Ttgb5HRTlwydgzDvI8otTpUdH2GloIaD8QLVzteOz5M1oAHctQRHK1AQnmH5J+B8xC9c
         kuRnM0wSJP+XpmGvD0x4Vo8HSmJ69+3q2X5IS1Mp7kE9wlDRJQ9563gbqTXy494AdFrP
         eYSEECbhUSgB30F/YIGRLAwbqJfgcy80l2qKTdc6RCLgshW474P6g/Pg4hyDKTcD/IqR
         9CVW9NF+2NA703CbHe7K+lNLboV9JBts/nLZ8WDkVxRH90mKvwkyZE7+hY7nNdRoKw2+
         DRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OMTLrqbJGjpPtOvQXK7GqxkakiNc6MEfg8N93L8aG00=;
        b=fC9HrpPUEKSFQiXfquXUVNUX70q3RkoTX9CCQPsdrCDmu0J1ugS02HK33htMGLEIln
         uhypQoOQEpVE3FAT9t8LrWJ0YIoj7B9kS2BLxLKyXEvyebb64UwY7ko6XxK4OwrQXt3E
         g6Ja7dXevuWnodqKEPQhz+AUVM9SZxJ3V47rwG52y2GKr53ne0B2VMO6jbs259PnjtT5
         trXDV0W45B9jMz9u0mo59sink3ZDX5zl7wkHi2iVB5mfUGtBqSmFWzpY3JCPm8/Zr5ax
         +xlnTzX7gEiI0h/BudH3j7z2NNl8C/56fq8wUcxIlZ156NSUib2wDeLv+hz4q+WPGb7Z
         05Dw==
X-Gm-Message-State: APjAAAUoTeWgFfqN557LYG26vYDXkUyjTLeFKnBjH4kI9Y90g7vzfXD1
        sU1cmz3Kc/Be6lVbovaKwKn1T1fu
X-Google-Smtp-Source: APXvYqzsFkk+AtDt6mI1KY2mtlSqn1V298XJ7m2FQSJiduH9Z1XsH93b6YYFhf2SsIHaWr/lmekkjw==
X-Received: by 2002:a5b:cc1:: with SMTP id e1mr12165184ybr.153.1579368394657;
        Sat, 18 Jan 2020 09:26:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 71sm12857041ywd.59.2020.01.18.09.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 09:26:34 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/5] hmon: (k10temp) Convert to use devm_hwmon_device_register_with_info
Date:   Sat, 18 Jan 2020 09:26:12 -0800
Message-Id: <20200118172615.26329-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
References: <20200118172615.26329-1-linux@roeck-us.net>
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

Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Tested-by: tags

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

