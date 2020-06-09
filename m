Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316E2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgFIO5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:57:34 -0400
Received: from lists.gateworks.com ([108.161.130.12]:54523 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgFIO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:57:29 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jifjx-0002Dv-Ge; Tue, 09 Jun 2020 15:00:37 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/2] hwmon: (gsc): add 16bit pre-scaled voltage mode
Date:   Tue,  9 Jun 2020 07:57:20 -0700
Message-Id: <1591714640-10332-3-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
References: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a 16-bit pre-scaled voltage mode to adc and clarify that existing
pre-scaled mode is 24bit.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/hwmon/gsc-hwmon.c               | 8 +++++---
 include/linux/platform_data/gsc_hwmon.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index 2137bc6..3dfe2ca 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -159,7 +159,7 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		return -EOPNOTSUPP;
 	}
 
-	sz = (ch->mode == mode_voltage) ? 3 : 2;
+	sz = (ch->mode == mode_voltage_24bit) ? 3 : 2;
 	ret = regmap_bulk_read(hwmon->regmap, ch->reg, buf, sz);
 	if (ret)
 		return ret;
@@ -186,7 +186,8 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		/* adjust by uV offset */
 		tmp += ch->mvoffset;
 		break;
-	case mode_voltage:
+	case mode_voltage_24bit:
+	case mode_voltage_16bit:
 		/* no adjustment needed */
 		break;
 	}
@@ -336,7 +337,8 @@ static int gsc_hwmon_probe(struct platform_device *pdev)
 						     HWMON_T_LABEL;
 			i_temp++;
 			break;
-		case mode_voltage:
+		case mode_voltage_24bit:
+		case mode_voltage_16bit:
 		case mode_voltage_raw:
 			if (i_in == GSC_HWMON_MAX_IN_CH) {
 				dev_err(gsc->dev, "too many input channels\n");
diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
index ec1611a..37a8f554d 100644
--- a/include/linux/platform_data/gsc_hwmon.h
+++ b/include/linux/platform_data/gsc_hwmon.h
@@ -4,8 +4,9 @@
 
 enum gsc_hwmon_mode {
 	mode_temperature,
-	mode_voltage,
+	mode_voltage_24bit,
 	mode_voltage_raw,
+	mode_voltage_16bit,
 	mode_max,
 };
 
-- 
2.7.4

