Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4A4C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80022077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrU5RM9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgAPOSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:18:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36653 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgAPOSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:18:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so9969057pgc.3;
        Thu, 16 Jan 2020 06:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mZynjD3U9yGsCN+ZbamWkSwWS2sEkUKgi+NWwlNXliA=;
        b=jrU5RM9vr9+NfleaOKdPS7Iq+9h865y7WEfvODP4essus/oo8BeKWiMKoXjGB4DG0g
         o0CU8Wcc8kriTCoIQKtFWnFhiZADQ2gMbVeCHrY//vyvFt2YUyiYloLOZbh1j7/gqGK/
         7w6T/fgBszIzkomrunNfkzlCdHfqxOu/t3vtDn1g8YLP2P+OC6k2pSlFB3FwtawlyTjy
         OYmeFcA/ArX/j634qUhsabUxDqEXcSwp3LkJ6U/Vme7OXJEu5TItsDKdJJ2VUWpTzxNT
         6x90DFaaKRrQbTl7csf/6E1Wte5SXjngGAebxHWleKrMGeVccEx3XkINbeKbbeyBEgTd
         eU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mZynjD3U9yGsCN+ZbamWkSwWS2sEkUKgi+NWwlNXliA=;
        b=NDOe6o8V958WIoHiuJDmff0md8ZA5royl1yesc/Ih8YMW1wln+T01RZ08U4dP6pz1N
         3vhMYPkP3BZACbGHnPYcoQkwmrJPHatHt2/AlEJe3aLV6a9pkg6mJRkRjDO/is/TeoEU
         c4HmqklropWG09ZYr6GXwRxHtiNDuqeuhPmcX90MbUVPmGuIFehOgbHNNkFIMAzr1r09
         Vh6AJvoLg1aQF2SBTuAquH+Mh7Zyekq/tG0g25/JBJt/TpZ8m/zHk/H9aLHR5q5unrx+
         bQnKGlWxrSESCEyLbvWGjVMWrkzPEsyFYiPGyijV8Hw/adlHLQls5aPDV8NcyR/VUxpL
         bhcg==
X-Gm-Message-State: APjAAAUVxtugkxdozALcwwZ4SPVGnaDp+Tq/Mx2/q1+ZLllKTCfn0Jrw
        azJ15E3zs8aNIvlsTACVlY49VlYm
X-Google-Smtp-Source: APXvYqxH6WpSM17MWagC7+gwCKsHrj+fOlKyf0l/HQ7eDx9NsrdqI/by8620ZW5zLFyIH2pHmw8h/Q==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr39070096pgk.357.1579184297254;
        Thu, 16 Jan 2020 06:18:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9sm3840975pjo.19.2020.01.16.06.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 06:18:15 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 4/4] hwmon: (k10temp) Show core and SoC current and voltages on Zen CPUs
Date:   Thu, 16 Jan 2020 06:18:00 -0800
Message-Id: <20200116141800.9828-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
References: <20200116141800.9828-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zen CPUs report core and SoC voltages and currents. Add support for it
to the k10temp driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 116 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 944ba8008bc4..bce862bacbc5 100644
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
@@ -157,16 +171,76 @@ const char *k10temp_temp_label[] = {
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
+		*val = 1550 - DIV_ROUND_CLOSEST(625 * regval, 100);
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
@@ -216,6 +290,21 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -290,6 +379,11 @@ static umode_t k10temp_is_visible(const void *_data,
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
@@ -338,6 +432,12 @@ static const struct hwmon_channel_info *k10temp_info[] = {
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
 
@@ -393,8 +493,18 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x8:	/* Zen+ */
 		case 0x11:	/* Zen APU */
 		case 0x18:	/* Zen+ APU */
+			data->show_current = true;
+			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE0;
+			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE1;
+			data->cfactor[0] = 1039211;	/* core */
+			data->cfactor[1] = 360772;	/* SoC */
 			break;
 		case 0x71:	/* Zen2 */
+			data->show_current = true;
+			data->cfactor[0] = 658823;	/* core */
+			data->cfactor[1] = 294300;	/* SoC */
+			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
+			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
 			amd_smn_read(amd_pci_dev_to_node_id(pdev),
 				     F17H_M70H_CCD1_TEMP, &regval);
 			if (regval & 0xfff)
-- 
2.17.1

