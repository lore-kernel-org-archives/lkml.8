Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D60C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 03:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EE720735
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 03:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbgCLDAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 23:00:00 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:53506 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbgCLDAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 23:00:00 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 22:59:59 EDT
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdddac63711ac14014bd38@ACLMS1.advantech.com.tw>;
 Thu, 12 Mar 2020 10:49:55 +0800
Received: from ADVANTECH.CORP (172.17.10.74) by taipei08.ADVANTECH.CORP
 (172.20.0.235) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Mar
 2020 10:49:54 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, <yuechao.zhao@advantech.com.cn>
Subject: [v1,1/1] Fix the incorrect quantity for fan & temp attributes.
Date:   Thu, 12 Mar 2020 02:49:34 +0000
Message-ID: <20200312024934.3533-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.74]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

nct7904d supports 12 fan tachometers input and 13 temperatures
(TEMP_CH1~4 and LTD + DTS TCPU1~8), fix the quantity for fan & temp
attributes.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 281c81e..1f5743d 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -7,6 +7,11 @@
  *
  * Copyright (c) 2019 Advantech
  * Author: Amy.Shih <amy.shih@advantech.com.tw>
+ *
+ * Supports the following chips:
+ *
+ * Chip        #vin  #fan  #pwm  #temp  #dts  chip ID
+ * nct7904d     20    12    4     5      8    0xc5
  */
 
 #include <linux/module.h>
@@ -820,6 +825,10 @@ static int nct7904_detect(struct i2c_client *client,
 			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
 			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
 			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
 			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
@@ -853,6 +862,18 @@ static int nct7904_detect(struct i2c_client *client,
 			   HWMON_T_CRIT_HYST,
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
 			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
+			   HWMON_T_CRIT_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
 			   HWMON_T_CRIT_HYST),
 	NULL
 };
-- 
1.8.3.1

