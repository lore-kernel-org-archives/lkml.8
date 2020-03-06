Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23105C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053E32073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCFA6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:58:20 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41449 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCFA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:58:18 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B2565E0004;
        Fri,  6 Mar 2020 00:58:15 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] rtc: pl031: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Fri,  6 Mar 2020 01:58:09 +0100
Message-Id: <20200306005809.38530-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306005809.38530-1-alexandre.belloni@bootlin.com>
References: <20200306005809.38530-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion to allow extending
support after 2106 and properly supporting the STv2 range.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pl031.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 07dc0f264100..40d7450a1ce4 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -125,11 +125,9 @@ static int pl031_stv2_tm_to_time(struct device *dev,
 		return -EINVAL;
 	} else if (wday == -1) {
 		/* wday is not provided, calculate it here */
-		unsigned long time;
 		struct rtc_time calc_tm;
 
-		rtc_tm_to_time(tm, &time);
-		rtc_time_to_tm(time, &calc_tm);
+		rtc_time64_to_tm(rtc_tm_to_time64(tm), &calc_tm);
 		wday = calc_tm.tm_wday;
 	}
 
@@ -246,30 +244,25 @@ static int pl031_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(ldata->base + RTC_DR), tm);
+	rtc_time64_to_tm(readl(ldata->base + RTC_DR), tm);
 
 	return 0;
 }
 
 static int pl031_set_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long time;
 	struct pl031_local *ldata = dev_get_drvdata(dev);
-	int ret;
 
-	ret = rtc_tm_to_time(tm, &time);
-
-	if (ret == 0)
-		writel(time, ldata->base + RTC_LR);
+	writel(rtc_tm_to_time64(tm), ldata->base + RTC_LR);
 
-	return ret;
+	return 0;
 }
 
 static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
+	rtc_time64_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
 
 	alarm->pending = readl(ldata->base + RTC_RIS) & RTC_BIT_AI;
 	alarm->enabled = readl(ldata->base + RTC_IMSC) & RTC_BIT_AI;
@@ -280,16 +273,10 @@ static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
-	unsigned long time;
-	int ret;
 
-	ret = rtc_tm_to_time(&alarm->time, &time);
-	if (ret == 0) {
-		writel(time, ldata->base + RTC_MR);
-		pl031_alarm_irq_enable(dev, alarm->enabled);
-	}
+	writel(rtc_tm_to_time64(&alarm->time), ldata->base + RTC_MR);
 
-	return ret;
+	return 0;
 }
 
 static int pl031_remove(struct amba_device *adev)
-- 
2.24.1

