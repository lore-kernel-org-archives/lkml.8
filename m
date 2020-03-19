Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD627C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBB92080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYzPz4Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgCSPty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:49:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44598 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgCSPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:49:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id a49so2811886otc.11;
        Thu, 19 Mar 2020 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbV1LNvdJI3JWUfTqtEKMpZEB+n0wzN638FLKY3ziHg=;
        b=YYzPz4BchUb1pullkGS2alnczizcEyoSN9ZkAd8VQuv4RDYhQX/x0ztSyNjSsLEvt9
         xVsXzPrraJevtAvBlxtqDqMXvOGQBEZATGveLAKESBqRfDd67Eg1TSCApaE3lMoE5J34
         pHYld9OXpr0YpJz0l+4/mY+0dfBuESiOiroYFuZq2ErbKy4kaXovuPLMXVkmceYZr/m6
         TvjEBAijFbkhX6YH3BFmfJETr57klm+Q2Twc9zk62MopcXSw7uWLK4g0yUi0sN8nO8iT
         ZQbSQkVlVa5aLe9LPrerliyz9LwBM0plOGeGfl9/z8B6F1rjbybJj6LfrjqIT7Y8yYLN
         BUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbV1LNvdJI3JWUfTqtEKMpZEB+n0wzN638FLKY3ziHg=;
        b=HG2lkocSnn08t3qMoBZ1oUGps6On/fAEhhp1gJ31JFJRfs+r79eXfxYtBQlzpVnDEj
         BtKQ9kPnAIeaaJrifxv1dg4TFMo9gfaZuxponWkliyk+vIbsaIRRgheXv4ORBPGi7IVo
         QfI2n9r4rrnGTURi9wMZnpie3eSULmuvSIpVDzazdPxGjvW89wz3qYd+6WVPfYrg37XD
         nZKp49GOkesWwPEDvPPyqTDq5doNfrMJMkBWE/lwrB1iT1jgO20qZo3CxYCLwtwLfWiY
         QyXm+PXqenQbQ2ApAaHviCXt8C3Mkoit3Dyq6n3CILtliD66BE+W3+2ffQXTZf/883xh
         CAlw==
X-Gm-Message-State: ANhLgQ3K/LX2pb23t4CefDVsAr+huqwtYv9Ye+0MKXMMHIr1LvI0GIP1
        xsVTCXd+UxQLqpnVvcMUR/U=
X-Google-Smtp-Source: ADFU+vsdvdIHO08F1VCvXCq77/Y9ZIzy3xDnO85TPPlTesXYOFG6uFN+rKLMxFvj4z152GfMpE2g2g==
X-Received: by 2002:a9d:728e:: with SMTP id t14mr2984170otj.63.1584632992697;
        Thu, 19 Mar 2020 08:49:52 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id j15sm890700ota.33.2020.03.19.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:49:52 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:49:50 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com
Subject: [PATCH v2 1/2] hwmon: (pmbus) add support for 2nd Gen Renesas
 digital multiphase
Message-ID: <10f2ef1746e5d079ac3b3c6054ffd2bbfc314572.1584568073.git.grantpeltier93@gmail.com>
References: <cover.1584568073.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584568073.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the isl68137 driver to provide support for 2nd generation Renesas
digital multiphase voltage regulators.

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
---
 drivers/hwmon/pmbus/Kconfig    |   6 +-
 drivers/hwmon/pmbus/isl68137.c | 112 ++++++++++++++++++++++++++++-----
 2 files changed, 100 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a9ea06204767..1e3e5a61ed9c 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -92,10 +92,10 @@ config SENSORS_IRPS5401
 	  be called irps5401.
 
 config SENSORS_ISL68137
-	tristate "Intersil ISL68137"
+	tristate "Renesas Digital Multiphase Voltage Regulators"
 	help
-	  If you say yes here you get hardware monitoring support for Intersil
-	  ISL68137.
+	  If you say yes here you get hardware monitoring support for Renesas
+	  digital multiphase voltage regulators.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called isl68137.
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 515596c92fe1..83774e5b1bc6 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Hardware monitoring driver for Intersil ISL68137
+ * Hardware monitoring driver for Renesas Digital Multiphase Voltage Regulators
  *
  * Copyright (c) 2017 Google Inc
+ * Copyright (c) 2020 Renesas Electronics America
  *
  */
 
@@ -14,9 +15,19 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
+
 #include "pmbus.h"
 
 #define ISL68137_VOUT_AVS	0x30
+#define RAA_DMPVR2_READ_VMON	0xc8
+
+enum versions {
+	isl68137,
+	raa_dmpvr2_1rail,
+	raa_dmpvr2_2rail,
+	raa_dmpvr2_3rail,
+	raa_dmpvr2_hv,
+};
 
 static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
 					     int page,
@@ -98,13 +109,31 @@ static const struct attribute_group enable_group = {
 	.attrs = enable_attrs,
 };
 
-static const struct attribute_group *attribute_groups[] = {
+static const struct attribute_group *isl68137_attribute_groups[] = {
 	&enable_group,
 	NULL,
 };
 
-static struct pmbus_driver_info isl68137_info = {
-	.pages = 2,
+static int raa_dmpvr2_read_word_data(struct i2c_client *client, int page, 
+                                     int reg)
+{
+	int ret;
+
+	switch (reg)
+	{
+	case PMBUS_VIRT_READ_VMON:
+		ret = pmbus_read_word_data(client, page, RAA_DMPVR2_READ_VMON);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static struct pmbus_driver_info raa_dmpvr_info = {
+	.pages = 3,
 	.format[PSC_VOLTAGE_IN] = direct,
 	.format[PSC_VOLTAGE_OUT] = direct,
 	.format[PSC_CURRENT_IN] = direct,
@@ -113,7 +142,7 @@ static struct pmbus_driver_info isl68137_info = {
 	.format[PSC_TEMPERATURE] = direct,
 	.m[PSC_VOLTAGE_IN] = 1,
 	.b[PSC_VOLTAGE_IN] = 0,
-	.R[PSC_VOLTAGE_IN] = 3,
+	.R[PSC_VOLTAGE_IN] = 2,
 	.m[PSC_VOLTAGE_OUT] = 1,
 	.b[PSC_VOLTAGE_OUT] = 0,
 	.R[PSC_VOLTAGE_OUT] = 3,
@@ -133,24 +162,76 @@ static struct pmbus_driver_info isl68137_info = {
 	    | PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
 	    | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
 	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
-	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
-	.groups = attribute_groups,
+	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT
+		| PMBUS_HAVE_VMON,
+	.func[1] = PMBUS_HAVE_IIN | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT
+	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
+	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_IOUT 
+	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
+	.func[2] = PMBUS_HAVE_IIN | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT
+	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
+	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_IOUT 
+	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
 };
 
 static int isl68137_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-	return pmbus_do_probe(client, id, &isl68137_info);
+	struct pmbus_driver_info *info;
+
+	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	memcpy(info, &raa_dmpvr_info, sizeof(*info));
+
+	switch (id->driver_data)
+	{
+	case isl68137:
+		info->pages = 2;
+		info->R[PSC_VOLTAGE_IN] = 3;
+		info->func[0] &= ~PMBUS_HAVE_VMON;
+		info->func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT;
+		info->groups = isl68137_attribute_groups;
+		break;
+	case raa_dmpvr2_1rail:
+		info->pages = 1;
+		info->read_word_data = raa_dmpvr2_read_word_data;
+		break;
+	case raa_dmpvr2_2rail:
+		info->pages = 2;
+		info->read_word_data = raa_dmpvr2_read_word_data;
+		break;
+	case raa_dmpvr2_3rail:
+		info->read_word_data = raa_dmpvr2_read_word_data;
+		break;
+	case raa_dmpvr2_hv:
+		info->pages = 1;
+		info->R[PSC_VOLTAGE_IN] = 1;
+		info->m[PSC_VOLTAGE_OUT] = 2;
+		info->R[PSC_VOLTAGE_OUT] = 2;
+		info->m[PSC_CURRENT_IN] = 2;
+		info->m[PSC_POWER] = 2;
+		info->R[PSC_POWER] = -1;
+		info->read_word_data = raa_dmpvr2_read_word_data;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return pmbus_do_probe(client, id, info);
 }
 
-static const struct i2c_device_id isl68137_id[] = {
-	{"isl68137", 0},
+static const struct i2c_device_id raa_dmpvr_id[] = {
+	{"isl68137", isl68137},
+	{"raa_dmpvr2_1rail", raa_dmpvr2_1rail},
+	{"raa_dmpvr2_2rail", raa_dmpvr2_2rail},
+	{"raa_dmpvr2_3rail", raa_dmpvr2_3rail},
+	{"raa_dmpvr2_hv", raa_dmpvr2_hv},
 	{}
 };
 
-MODULE_DEVICE_TABLE(i2c, isl68137_id);
+MODULE_DEVICE_TABLE(i2c, raa_dmpvr_id);
 
 /* This is the driver that will be inserted */
 static struct i2c_driver isl68137_driver = {
@@ -159,11 +240,12 @@ static struct i2c_driver isl68137_driver = {
 		   },
 	.probe = isl68137_probe,
 	.remove = pmbus_do_remove,
-	.id_table = isl68137_id,
+	.id_table = raa_dmpvr_id,
 };
 
 module_i2c_driver(isl68137_driver);
 
 MODULE_AUTHOR("Maxim Sloyko <maxims@google.com>");
-MODULE_DESCRIPTION("PMBus driver for Intersil ISL68137");
+MODULE_DESCRIPTION("PMBus driver for Renesas digital multiphase voltage "
+                   "regulators");
 MODULE_LICENSE("GPL");
-- 
2.20.1

