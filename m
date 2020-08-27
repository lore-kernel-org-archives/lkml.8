Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4878C2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgH0RVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:21:43 -0400
Received: from lists.gateworks.com ([108.161.130.12]:59092 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgH0RVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:21:39 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1kBLfK-0002tg-Of; Thu, 27 Aug 2020 17:26:22 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Jones <rjones@gateworks.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] hwmon: gsc-hwmon: add fan sensor
Date:   Thu, 27 Aug 2020 10:21:32 -0700
Message-Id: <1598548892-17103-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a fan sensor to report RPM's from a fan tach input.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/hwmon/gsc-hwmon.c               | 34 ++++++++++++++++++++++++++++++---
 include/linux/platform_data/gsc_hwmon.h |  1 +
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index c6d4567..a86a0e5 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -17,6 +17,7 @@
 
 #define GSC_HWMON_MAX_TEMP_CH	16
 #define GSC_HWMON_MAX_IN_CH	16
+#define GSC_HWMON_MAX_FAN_CH	16
 
 #define GSC_HWMON_RESOLUTION	12
 #define GSC_HWMON_VREF		2500
@@ -27,11 +28,14 @@ struct gsc_hwmon_data {
 	struct regmap *regmap;
 	const struct gsc_hwmon_channel *temp_ch[GSC_HWMON_MAX_TEMP_CH];
 	const struct gsc_hwmon_channel *in_ch[GSC_HWMON_MAX_IN_CH];
+	const struct gsc_hwmon_channel *fan_ch[GSC_HWMON_MAX_FAN_CH];
 	u32 temp_config[GSC_HWMON_MAX_TEMP_CH + 1];
 	u32 in_config[GSC_HWMON_MAX_IN_CH + 1];
+	u32 fan_config[GSC_HWMON_MAX_FAN_CH + 1];
 	struct hwmon_channel_info temp_info;
 	struct hwmon_channel_info in_info;
-	const struct hwmon_channel_info *info[3];
+	struct hwmon_channel_info fan_info;
+	const struct hwmon_channel_info *info[4];
 	struct hwmon_chip_info chip;
 };
 
@@ -155,6 +159,9 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	case hwmon_temp:
 		ch = hwmon->temp_ch[channel];
 		break;
+	case hwmon_fan:
+		ch = hwmon->fan_ch[channel];
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -187,6 +194,9 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		/* adjust by uV offset */
 		tmp += ch->mvoffset;
 		break;
+	case mode_fan:
+		tmp *= 30; /* convert to revolutions per minute */
+		break;
 	case mode_voltage_24bit:
 	case mode_voltage_16bit:
 		/* no adjustment needed */
@@ -211,6 +221,9 @@ gsc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp:
 		*buf = hwmon->temp_ch[channel]->name;
 		break;
+	case hwmon_fan:
+		*buf = hwmon->fan_ch[channel]->name;
+		break;
 	default:
 		return -ENOTSUPP;
 	}
@@ -304,7 +317,7 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
 	struct gsc_hwmon_platform_data *pdata = dev_get_platdata(dev);
 	struct gsc_hwmon_data *hwmon;
 	const struct attribute_group **groups;
-	int i, i_in, i_temp;
+	int i, i_in, i_temp, i_fan;
 
 	if (!pdata) {
 		pdata = gsc_hwmon_get_devtree_pdata(dev);
@@ -324,7 +337,9 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
 	if (IS_ERR(hwmon->regmap))
 		return PTR_ERR(hwmon->regmap);
 
-	for (i = 0, i_in = 0, i_temp = 0; i < hwmon->pdata->nchannels; i++) {
+	for (i = 0, i_in = 0, i_temp = 0, i_fan = 0;
+	     i < hwmon->pdata->nchannels; i++)
+	{
 		const struct gsc_hwmon_channel *ch = &pdata->channels[i];
 
 		switch (ch->mode) {
@@ -338,6 +353,16 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
 						     HWMON_T_LABEL;
 			i_temp++;
 			break;
+		case mode_fan:
+			if (i_fan == GSC_HWMON_MAX_FAN_CH) {
+				dev_err(gsc->dev, "too many fan channels\n");
+				return -EINVAL;
+			}
+			hwmon->fan_ch[i_fan] = ch;
+			hwmon->fan_config[i_fan] = HWMON_F_INPUT |
+						   HWMON_F_LABEL;
+			i_fan++;
+			break;
 		case mode_voltage_24bit:
 		case mode_voltage_16bit:
 		case mode_voltage_raw:
@@ -361,10 +386,13 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
 	hwmon->chip.info = hwmon->info;
 	hwmon->info[0] = &hwmon->temp_info;
 	hwmon->info[1] = &hwmon->in_info;
+	hwmon->info[2] = &hwmon->fan_info;
 	hwmon->temp_info.type = hwmon_temp;
 	hwmon->temp_info.config = hwmon->temp_config;
 	hwmon->in_info.type = hwmon_in;
 	hwmon->in_info.config = hwmon->in_config;
+	hwmon->fan_info.type = hwmon_fan;
+	hwmon->fan_info.config = hwmon->fan_config;
 
 	groups = pdata->fan_base ? gsc_hwmon_groups : NULL;
 	hwmon_dev = devm_hwmon_device_register_with_info(dev,
diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
index 37a8f554d..281f499 100644
--- a/include/linux/platform_data/gsc_hwmon.h
+++ b/include/linux/platform_data/gsc_hwmon.h
@@ -7,6 +7,7 @@ enum gsc_hwmon_mode {
 	mode_voltage_24bit,
 	mode_voltage_raw,
 	mode_voltage_16bit,
+	mode_fan,
 	mode_max,
 };
 
-- 
2.7.4

