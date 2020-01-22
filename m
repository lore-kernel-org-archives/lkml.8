Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090D2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093024673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c994Q/iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAVQIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39404 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAVQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id 4so3763291pgd.6;
        Wed, 22 Jan 2020 08:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lT+xLTE4SmZvPBNnp31awLJXu11Xl4yWiIAtrtZ/Rv8=;
        b=c994Q/ivfyJhO2jTecWDxMq6jyzCJCpj+8o8V5dXH2vM5BPqKcAHfLJKm30SnXCgja
         PG+ERy+irwrN96KU1GN6ThmXh4VEaZT0U32yrgibzA4Ql/eUCcxj4jRu5DHdRINM/hCY
         Z90w1Lz5akdzrVaDW6Bu4occFmi8fWCeiIB/fDHonuU2A4UTEZ7RNHbGtbO6PmCeStF8
         pbyB8uzU7sXYnqlKEvCSXEJC4xAsN+55Mf6kUlwfCik5OL4ARwM456zrSWkip9IBDfko
         XF7b8VajsJg6qUmGoKApY06tZhK0BIu++THITTmjdi1QymU47eagKUyo9NghH6UikpFu
         M69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=lT+xLTE4SmZvPBNnp31awLJXu11Xl4yWiIAtrtZ/Rv8=;
        b=OSpr0dgb3QmR0/tpWvzIlJJX7wqSIO+YbB2KbyX8TmvBo0K4OF20KJ+3gGEXiRaK+3
         oDdxxKyRkvEkjZv+Bj9evKnB+ylPJKx57hs7PyGbN5fA9J4l26p94DF8qijexdT1aHo3
         OIeXON4IxlixROzD5Hx3ZfqhhPv32gWjzPIG9RACNUaa/yiSDIcUs62mvEgfVJOaHjYv
         AZGQjPZBtHjhF+E6bNQPWtueCu1h4c1bjH6OmWjOSbxCsHKYJfww19b5vNQFC1rOplwx
         mgCtJJvLEKPTXocWJGqMBCfwKJwg34V9tJBBOSdmeh+XNGPCZNsqvt6hRyDXwSScib59
         2jBQ==
X-Gm-Message-State: APjAAAVbgE2rxe3KTkCgmpc/FPcTmqpmEzWX0UeK1NEZTpen3tQHDHpq
        oxiqWGPcHXdEdajSfibtfqHCMLAV
X-Google-Smtp-Source: APXvYqwkKEX60wH575NGXA38r3M3xClRWzBIyHhGwIuTzu+Ys2YIIdqZyGTfoxrJGW/iYt6CEaImlA==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr3297698pfl.32.1579709292924;
        Wed, 22 Jan 2020 08:08:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3sm49549261pfo.72.2020.01.22.08.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 08:08:12 -0800 (PST)
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
Subject: [PATCH v4 4/6] hwmon: (k10temp) Show core and SoC current and voltages on Ryzen CPUs
Date:   Wed, 22 Jan 2020 08:07:58 -0800
Message-Id: <20200122160800.12560-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
References: <20200122160800.12560-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryzen CPUs report core and SoC voltages and currents. Add support
for it to the k10temp driver.

For the time being, only report voltages and currents for Ryzen
CPUs. Threadripper and EPYC appear to use a different mechanism.

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
Tested-by: Michael Larabel <michael@phoronix.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Ken Moffat <zarniwhoop73@googlemail.com>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 134 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 0af096b061fa..b961e12c6f58 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -11,6 +11,18 @@
  *   convert raw register values is from https://github.com/ocerman/zenpower.
  *   The information is not confirmed from chip datasheets, but experiments
  *   suggest that it provides reasonable temperature values.
+ * - Register addresses to read chip voltage and current are also from
+ *   https://github.com/ocerman/zenpower, and not confirmed from chip
+ *   datasheets. Current calibration is board specific and not typically
+ *   shared by board vendors. For this reason, current values are
+ *   normalized to report 1A/LSB for core current and and 0.25A/LSB for SoC
+ *   current. Reported values can be adjusted using the sensors configuration
+ *   file.
+ * - It is unknown if the mechanism to read CCD1/CCD2 temperature as well as
+ *   current and voltage information works on higher-end Ryzen CPUs.
+ *   Information reported by Windows tools suggests that additional sensors
+ *   (both temperature and voltage/current) are supported, but their register
+ *   location is currently unknown.
  */
 
 #include <linux/bitops.h>
@@ -70,9 +82,16 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F17H_M70H_CCD1_TEMP			0x00059954
 #define F17H_M70H_CCD2_TEMP			0x00059958
 
+#define F17H_M01H_SVI				0x0005A000
+#define F17H_M01H_SVI_TEL_PLANE0		(F17H_M01H_SVI + 0xc)
+#define F17H_M01H_SVI_TEL_PLANE1		(F17H_M01H_SVI + 0x10)
+
 #define CUR_TEMP_SHIFT				21
 #define CUR_TEMP_RANGE_SEL_MASK			BIT(19)
 
+#define CFACTOR_ICORE				1000000	/* 1A / LSB	*/
+#define CFACTOR_ISOC				250000	/* 0.25A / LSB	*/
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -82,6 +101,9 @@ struct k10temp_data {
 	bool show_tdie;
 	bool show_tccd1;
 	bool show_tccd2;
+	u32 svi_addr[2];
+	bool show_current;
+	int cfactor[2];
 };
 
 struct tctl_offset {
@@ -99,6 +121,16 @@ static const struct tctl_offset tctl_offset_table[] = {
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
@@ -157,16 +189,76 @@ const char *k10temp_temp_label[] = {
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
@@ -216,6 +308,21 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -290,6 +397,11 @@ static umode_t k10temp_is_visible(const void *_data,
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
@@ -338,6 +450,12 @@ static const struct hwmon_channel_info *k10temp_info[] = {
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
 
@@ -393,9 +511,19 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x8:	/* Zen+ */
 		case 0x11:	/* Zen APU */
 		case 0x18:	/* Zen+ APU */
+			data->show_current = !is_threadripper() && !is_epyc();
+			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE0;
+			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE1;
+			data->cfactor[0] = CFACTOR_ICORE;
+			data->cfactor[1] = CFACTOR_ISOC;
 			break;
 		case 0x31:	/* Zen2 Threadripper */
 		case 0x71:	/* Zen2 */
+			data->show_current = !is_threadripper() && !is_epyc();
+			data->cfactor[0] = CFACTOR_ICORE;
+			data->cfactor[1] = CFACTOR_ISOC;
+			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
+			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
 			amd_smn_read(amd_pci_dev_to_node_id(pdev),
 				     F17H_M70H_CCD1_TEMP, &regval);
 			if (regval & 0xfff)
-- 
2.17.1

