Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F73B207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbgE0DuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:50:01 -0400
Received: from [58.211.163.100] ([58.211.163.100]:60890 "EHLO
        mail.advantech.com.cn" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387487AbgE0DuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:50:01 -0400
Received: from ACNMB2.ACN.ADVANTECH.CORP (unverified [172.21.128.148]) by ACN-SWEEPER01.ACN.ADVANTECH.CORP
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdf625ddc7dac158030ecc@ACN-SWEEPER01.ACN.ADVANTECH.CORP>;
 Wed, 27 May 2020 11:47:05 +0800
Received: from ADVANTECH.CORP (172.17.10.144) by ACNMB2.ACN.ADVANTECH.CORP
 (172.21.128.148) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 May
 2020 11:49:57 +0800
From:   <yuechao.zhao@advantech.com.cn>
To:     <345351830@qq.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2,1/1] hwmon:(nct7904) Set default timeout
Date:   Wed, 27 May 2020 03:49:50 +0000
Message-ID: <1590551390-40177-1-git-send-email-yuechao.zhao@advantech.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.144]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 ACNMB2.ACN.ADVANTECH.CORP (172.21.128.148)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

The timeout module parameter should not be used for setting the default
timeout. Because, if you set the timeout = 0, the default timeout will
be meaningless. And the timeout module parameter of 0 means "no timeout
module paraameter specified".

Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
---
- modify subject to 'hwmon:(nct7904) Set default timeout'
---
 drivers/hwmon/nct7904.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 18c95be..27eb276 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -1147,7 +1147,7 @@ static int nct7904_probe(struct i2c_client *client,
 	data->wdt.ops = &nct7904_wdt_ops;
 	data->wdt.info = &nct7904_wdt_info;
 
-	data->wdt.timeout = timeout * 60; /* in seconds */
+	data->wdt.timeout = WATCHDOG_TIMEOUT * 60; /* Set default timeout */
 	data->wdt.min_timeout = MIN_TIMEOUT;
 	data->wdt.max_timeout = MAX_TIMEOUT;
 	data->wdt.parent = &client->dev;
-- 
1.8.3.1

