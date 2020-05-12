Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71145C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E98D2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgELCf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:35:56 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:44257 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgELCf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:35:56 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2020 22:35:54 EDT
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdf14d40ebeac14014b1d04@ACLMS1.advantech.com.tw>;
 Tue, 12 May 2020 10:25:48 +0800
Received: from ADVANTECH.CORP (172.17.10.130) by taipei08.ADVANTECH.CORP
 (172.20.0.235) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 May
 2020 10:25:47 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, <yuechao.zhao@advantech.com.cn>,
        <Hy.Lee@advantech.com.tw>
Subject: [v1,1/1] hwmon: (nct7904) Add to read all of the SMI status registers in probe function.
Date:   Tue, 12 May 2020 02:25:23 +0000
Message-ID: <20200512022523.13690-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.130]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

When nct7904 power up, it compares current sensor readings within the
default threshold immediately, thus some of SMI status registers would
get non zero values cause the false alarms on first reading. Add to
read all of the SMI status registers in probe function to clear the
alarms.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 571a649..6fb06f7 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -45,6 +45,7 @@
 #define FANCTL_MAX		4	/* Counted from 1 */
 #define TCPU_MAX		8	/* Counted from 1 */
 #define TEMP_MAX		4	/* Counted from 1 */
+#define SMI_STS_MAX		10	/* Counted from 1 */
 
 #define VT_ADC_CTRL0_REG	0x20	/* Bank 0 */
 #define VT_ADC_CTRL1_REG	0x21	/* Bank 0 */
@@ -1126,6 +1127,13 @@ static int nct7904_probe(struct i2c_client *client,
 		data->fan_mode[i] = ret;
 	}
 
+	/* Read all of SMI status register to clear alarms */
+	for (i = 0; i < SMI_STS_MAX; i++) {
+		ret = nct7904_read_reg(data, BANK_0, SMI_STS1_REG + i);
+		if (ret < 0)
+			return ret;
+	}
+
 	hwmon_dev =
 		devm_hwmon_device_register_with_info(dev, client->name, data,
 						     &nct7904_chip_info, NULL);
-- 
1.8.3.1

