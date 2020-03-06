Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28B2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCFBB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:01:59 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52143 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFBB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:01:58 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 516B720002;
        Fri,  6 Mar 2020 01:01:57 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rtc: sa1100: fix possible race condition
Date:   Fri,  6 Mar 2020 02:01:44 +0100
Message-Id: <20200306010146.39762-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both RTC IRQs are requested before the struct rtc_device is allocated,
this may lead to a NULL pointer dereference in the IRQ handler.

To fix this issue, allocating the rtc_device struct before requesting
the IRQs using devm_rtc_allocate_device, and use rtc_register_device
to register the RTC device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sa1100.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index d37893f6eaee..97c352594033 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -182,7 +182,6 @@ static const struct rtc_class_ops sa1100_rtc_ops = {
 
 int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info)
 {
-	struct rtc_device *rtc;
 	int ret;
 
 	spin_lock_init(&info->lock);
@@ -211,15 +210,14 @@ int sa1100_rtc_init(struct platform_device *pdev, struct sa1100_rtc *info)
 		writel_relaxed(0, info->rcnr);
 	}
 
-	rtc = devm_rtc_device_register(&pdev->dev, pdev->name, &sa1100_rtc_ops,
-					THIS_MODULE);
-	if (IS_ERR(rtc)) {
+	info->rtc->ops = &sa1100_rtc_ops;
+	info->rtc->max_user_freq = RTC_FREQ;
+
+	ret = rtc_register_device(info->rtc);
+	if (ret) {
 		clk_disable_unprepare(info->clk);
-		return PTR_ERR(rtc);
+		return ret;
 	}
-	info->rtc = rtc;
-
-	rtc->max_user_freq = RTC_FREQ;
 
 	/* Fix for a nasty initialization problem the in SA11xx RTSR register.
 	 * See also the comments in sa1100_rtc_interrupt().
@@ -267,6 +265,10 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	info->irq_1hz = irq_1hz;
 	info->irq_alarm = irq_alarm;
 
+	info->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(info->rtc))
+		return PTR_ERR(info->rtc);
+
 	ret = devm_request_irq(&pdev->dev, irq_1hz, sa1100_rtc_interrupt, 0,
 			       "rtc 1Hz", &pdev->dev);
 	if (ret) {
-- 
2.24.1

