Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E8FC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B7420739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgCKWkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:40:04 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:28793 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgCKWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:40:02 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 447A6240004;
        Wed, 11 Mar 2020 22:40:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] rtc: 88pm860x: stop calling unused callback
Date:   Wed, 11 Mar 2020 23:39:53 +0100
Message-Id: <20200311223956.51352-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200311223956.51352-1-alexandre.belloni@bootlin.com>
References: <20200311223956.51352-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pdata->sync is not defined by any platform, stop calling it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm860x.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index d6aca28905e3..0abf2b194938 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -28,7 +28,6 @@ struct pm860x_rtc_info {
 
 	int			irq;
 	int			vrtc;
-	int			(*sync)(unsigned int ticks);
 };
 
 #define REG_VRTC_MEAS1		0x7D
@@ -155,8 +154,6 @@ static int pm860x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	pm860x_page_reg_write(info->i2c, REG2_DATA, (base >> 8) & 0xFF);
 	pm860x_page_reg_write(info->i2c, REG3_DATA, base & 0xFF);
 
-	if (info->sync)
-		info->sync(ticks);
 	return 0;
 }
 
@@ -317,8 +314,6 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm860x_rtc_pdata *pdata = NULL;
 	struct pm860x_rtc_info *info;
-	struct rtc_time tm;
-	unsigned long ticks = 0;
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -355,18 +350,7 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 	pm860x_page_reg_write(info->i2c, REG2_ADDR, REG2_DATA);
 	pm860x_page_reg_write(info->i2c, REG3_ADDR, REG3_DATA);
 
-	ret = pm860x_rtc_read_time(&pdev->dev, &tm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to read initial time.\n");
-		return ret;
-	}
-	rtc_tm_to_time(&tm, &ticks);
-	if (pm860x_rtc_dt_init(pdev, info)) {
-		if (pdata && pdata->sync) {
-			pdata->sync(ticks);
-			info->sync = pdata->sync;
-		}
-	}
+	pm860x_rtc_dt_init(pdev, info);
 
 	info->rtc_dev->ops = &pm860x_rtc_ops;
 
-- 
2.24.1

