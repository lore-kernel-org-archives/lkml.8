Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59ADC54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65A0206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgELJib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:38:31 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:62168 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:38:30 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdf16602db0ac14014b1d04@ACLMS1.advantech.com.tw>;
 Tue, 12 May 2020 17:38:28 +0800
Received: from ADVANTECH.CORP (172.17.10.130) by taipei08.ADVANTECH.CORP
 (172.20.0.235) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 May
 2020 17:38:27 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, <yuechao.zhao@advantech.com.cn>,
        <Hy.Lee@advantech.com.tw>
Subject: [v1,1/1] hwmon: (nct7904) Fix the incorrect rang of temperature limitation registers.
Date:   Tue, 12 May 2020 09:38:06 +0000
Message-ID: <20200512093806.28515-1-Amy.Shih@advantech.com.tw>
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

The format of temperature limitation registers are 8-bit 2's complement
and the range is -128~127.
Converts the reading value to signed char to fix the incorrect range
of temperature limitation registers.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 6fb06f7..04f2a8e 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -390,6 +390,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 	struct nct7904_data *data = dev_get_drvdata(dev);
 	int ret, temp;
 	unsigned int reg1, reg2, reg3;
+	s8 temps;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -495,7 +496,8 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 
 	if (ret < 0)
 		return ret;
-	*val = ret * 1000;
+	temps = ret;
+	*val = temps * 1000;
 	return 0;
 }
 
-- 
1.8.3.1

