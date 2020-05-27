Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887FFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7139F2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgE0BSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:18:55 -0400
Received: from [58.211.163.100] ([58.211.163.100]:60551 "EHLO
        mail.advantech.com.cn" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728184AbgE0BSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:18:54 -0400
Received: from ACNMB2.ACN.ADVANTECH.CORP (unverified [172.21.128.148]) by ACN-SWEEPER01.ACN.ADVANTECH.CORP
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdf61d37908ac158030ecc@ACN-SWEEPER01.ACN.ADVANTECH.CORP>;
 Wed, 27 May 2020 09:15:56 +0800
Received: from ADVANTECH.CORP (172.17.10.144) by ACNMB2.ACN.ADVANTECH.CORP
 (172.21.128.148) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 May
 2020 09:18:48 +0800
From:   <yuechao.zhao@advantech.com.cn>
To:     <345351830@qq.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v1,1/1 1/2] Check the timeout module parameter is in the min-max range
Date:   Wed, 27 May 2020 01:18:38 +0000
Message-ID: <1590542319-35736-1-git-send-email-yuechao.zhao@advantech.com.cn>
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

Check the return value of 'watchdog_init_timeout()' for checking the
timeout module parameter is in the min-max range.

Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
---
 drivers/hwmon/nct7904.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 18c95be..d069d59 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -1152,7 +1152,10 @@ static int nct7904_probe(struct i2c_client *client,
 	data->wdt.max_timeout = MAX_TIMEOUT;
 	data->wdt.parent = &client->dev;
 
-	watchdog_init_timeout(&data->wdt, timeout * 60, &client->dev);
+	ret = watchdog_init_timeout(&data->wdt, timeout * 60, &client->dev);
+	if (ret < 0)
+		return ret;
+
 	watchdog_set_nowayout(&data->wdt, nowayout);
 	watchdog_set_drvdata(&data->wdt, data);
 
-- 
1.8.3.1

