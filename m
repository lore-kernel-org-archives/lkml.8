Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CAC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F25C2469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDPSw6zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgARR0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:26:42 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43481 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgARR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:26:40 -0500
Received: by mail-yw1-f65.google.com with SMTP id v126so15892770ywc.10;
        Sat, 18 Jan 2020 09:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oZkWvIdFpURTKA4ObtexHd8O3YPj8eeMou2Wwzsd5DQ=;
        b=sDPSw6zU5v8afRvXuebS81HrxqmPo3Bhxw8gVRzHH7PtcCHJxLkfS3RvBWMW5jeH6V
         49fQjLnEncgV9MyZkGa0801sH7IiEZlD/4rd2lFVLqMDJ2HTxhMQBqby17m6LwYTw3qQ
         Zcc+zLL5l7gQCANAK3WRzE61ZbGIATc8i102JWbV3CFgcsjjE4SqQMI4Vy086giWyBqQ
         rvU1hL1szQ0Zh+qZ2bwBEcIp3FIvGDodtCY9283ptvUrOGK4GpcBSxLxnP3IHz5EfXJ8
         /yG8WLMEQLaf5hpXZv/8tOVhq86cQhtecmFbZT3gpmmKgruqIycHamdX5MG1wN+tris2
         d0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=oZkWvIdFpURTKA4ObtexHd8O3YPj8eeMou2Wwzsd5DQ=;
        b=FPNw61kz+YWJlMjR58R3IASqmvNs/czsNpaA2szi8fRPdVZGV8MojZPFb5gHYDbt4n
         BWMJovzxq9y4lZ2dNSD7nnSayC9vIKzWKPQoDpQpGsSxo+eCfoe1PGtu8DUtQag2gFDD
         uSMjPfNPpOsG7a54lgF8pNnsXg8Pu6pOm36rzWf56x60kI2eTMaRIyov7ymDB35Tujez
         ogMFgAKnhBGGzNVw4giJuvCrKUdyid2Li8337Ep+5yxLKDBHmOk+Wjo8Ips2l/6a6gMU
         n/pw0yiZi2X4HItkpmGfvBWtN/lGND5vG7baEh9fV1wJtC9Oyz/Mv32WuOmfu3p3Ef9R
         piTg==
X-Gm-Message-State: APjAAAUQS+jA/fTevBUoYtyz2ZG6ZFFnqIPiopQ3KHvZK+aDwGOFcU1S
        FJkVPFZh+06Iz7DGwqn3iSvjYcBi
X-Google-Smtp-Source: APXvYqwpiSwqWlnIlalgNSkUl+Ca6jhD9tqyq37+oS+TLdvoAKzWkd1L92TqxGeEbAfIE3W3vBOcEQ==
X-Received: by 2002:a0d:cbd7:: with SMTP id n206mr7198949ywd.167.1579368398635;
        Sat, 18 Jan 2020 09:26:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d13sm13272444ywj.91.2020.01.18.09.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 09:26:38 -0800 (PST)
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
Subject: [PATCH v2 4/5] hwmon: (k10temp) Show core and SoC current and voltages on Ryzen CPUs
Date:   Sat, 18 Jan 2020 09:26:14 -0800
Message-Id: <20200118172615.26329-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
References: <20200118172615.26329-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryzen CPUs report core and SoC voltages and currents. Add support
for it to the k10temp driver.

For the time being, only report voltages and currents for Ryzen
CPUs. Threadripper and EPYC appear to use a different mechanism.

Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Tested-by: tags.
    Don't try to report voltage and current information on Threadripper
    and EPYC CPUs.

 drivers/hwmon/k10temp.c | 126 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 944ba8008bc4..a4313b662a3a 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -11,6 +11,13 @@
  *   convert raw register values is from https://github.com/ocerman/zenpower.
  *   The information is not confirmed from chip datasheets, but experiments
  *   suggest that it provides reasonable temperature values.
+ * - Register addresses to read chip voltage and current is also from
+ *   https://github.com/ocerman/zenpower, and not confirmed from chip
+ *   datasheets. Experiments suggest that reported current and voltage
+ *   information is reasonable.
+ * - It is unknown if the mechanism to read CCD1/CCD2 temperature as well as
+ *   current and voltage information works on higher-end Ryzen CPUs, or if
+ *   additional information is available on those CPUs.
  */
 
 #include <linux/bitops.h>
@@ -70,6 +77,10 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F17H_M70H_CCD1_TEMP			0x00059954
 #define F17H_M70H_CCD2_TEMP			0x00059958
 
+#define F17H_M01H_SVI				0x0005A000
+#define F17H_M01H_SVI_TEL_PLANE0		(F17H_M01H_SVI + 0xc)
+#define F17H_M01H_SVI_TEL_PLANE1		(F17H_M01H_SVI + 0x10)
+
 #define CUR_TEMP_SHIFT				21
 #define CUR_TEMP_RANGE_SEL_MASK			BIT(19)
 
@@ -82,6 +93,9 @@ struct k10temp_data {
 	bool show_tdie;
 	bool show_tccd1;
 	bool show_tccd2;
+	u32 svi_addr[2];
+	bool show_current;
+	int cfactor[2];
 };
 
 struct tctl_offset {
@@ -99,6 +113,16 @@ static const struct tctl_offset tctl_offset_table[] = {
 	{ 0x17, "AMD Ryzen Threadripper 29", 27000 }, /* 29{20,50,70,90}[W]X */
 };
 
+static bool is_threadripper(void)
+{
+	return strstr(boot_cpu_data.x86_model_id, "Threadripper");
+}
+
+static bool is_epyc(void)
+{
+	return strstr(boot_cpu_data.x86_model_id, "EPYC");
+}
+
 static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
 {
 	pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
@@ -157,16 +181,76 @@ const char *k10temp_temp_label[] = {
 	"Tccd2",
 };
 
+const char *k10temp_in_label[] = {
+	"Vcore",
+	"Vsoc",
+};
+
+const char *k10temp_curr_label[] = {
+	"Icore",
+	"Isoc",
+};
+
 static int k10temp_read_labels(struct device *dev,
 			       enum hwmon_sensor_types type,
 			       u32 attr, int channel, const char **str)
 {
-	*str = k10temp_temp_label[channel];
+	switch (type) {
+	case hwmon_temp:
+		*str = k10temp_temp_label[channel];
+		break;
+	case hwmon_in:
+		*str = k10temp_in_label[channel];
+		break;
+	case hwmon_curr:
+		*str = k10temp_curr_label[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
-static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
-			u32 attr, int channel, long *val)
+static int k10temp_read_curr(struct device *dev, u32 attr, int channel,
+			     long *val)
+{
+	struct k10temp_data *data = dev_get_drvdata(dev);
+	u32 regval;
+
+	switch (attr) {
+	case hwmon_curr_input:
+		amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+			     data->svi_addr[channel], &regval);
+		*val = DIV_ROUND_CLOSEST(data->cfactor[channel] *
+					 (regval & 0xff),
+					 1000);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int k10temp_read_in(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct k10temp_data *data = dev_get_drvdata(dev);
+	u32 regval;
+
+	switch (attr) {
+	case hwmon_in_input:
+		amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+			     data->svi_addr[channel], &regval);
+		regval = (regval >> 16) & 0xff;
+		*val = DIV_ROUND_CLOSEST(155000 - regval * 625, 100);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
+			     long *val)
 {
 	struct k10temp_data *data = dev_get_drvdata(dev);
 	u32 regval;
@@ -216,6 +300,21 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
 	return 0;
 }
 
+static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_temp:
+		return k10temp_read_temp(dev, attr, channel, val);
+	case hwmon_in:
+		return k10temp_read_in(dev, attr, channel, val);
+	case hwmon_curr:
+		return k10temp_read_curr(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static umode_t k10temp_is_visible(const void *_data,
 				  enum hwmon_sensor_types type,
 				  u32 attr, int channel)
@@ -290,6 +389,11 @@ static umode_t k10temp_is_visible(const void *_data,
 			return 0;
 		}
 		break;
+	case hwmon_in:
+	case hwmon_curr:
+		if (!data->show_current)
+			return 0;
+		break;
 	default:
 		return 0;
 	}
@@ -338,6 +442,12 @@ static const struct hwmon_channel_info *k10temp_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL),
 	NULL
 };
 
@@ -393,8 +503,18 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x8:	/* Zen+ */
 		case 0x11:	/* Zen APU */
 		case 0x18:	/* Zen+ APU */
+			data->show_current = !is_threadripper() && !is_epyc();
+			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE0;
+			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE1;
+			data->cfactor[0] = 1039211;	/* core */
+			data->cfactor[1] = 360772;	/* SoC */
 			break;
 		case 0x71:	/* Zen2 */
+			data->show_current = !is_threadripper() && !is_epyc();
+			data->cfactor[0] = 658823;	/* core */
+			data->cfactor[1] = 294300;	/* SoC */
+			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
+			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
 			amd_smn_read(amd_pci_dev_to_node_id(pdev),
 				     F17H_M70H_CCD1_TEMP, &regval);
 			if (regval & 0xfff)
-- 
2.17.1

