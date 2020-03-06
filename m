Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62558C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBE72073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCFBAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:00:09 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52665 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFBAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:00:08 -0500
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E7ADE20000E;
        Fri,  6 Mar 2020 01:00:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] rtc: au1xxx: convert to devm_rtc_allocate_device
Date:   Fri,  6 Mar 2020 01:59:55 +0100
Message-Id: <20200306005958.39203-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-au1xxx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
index 7c5530c71285..a13ac73aa2b7 100644
--- a/drivers/rtc/rtc-au1xxx.c
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -99,16 +99,15 @@ static int au1xtoy_rtc_probe(struct platform_device *pdev)
 	while (alchemy_rdsys(AU1000_SYS_CNTRCTRL) & SYS_CNTRL_C0S)
 		msleep(1);
 
-	rtcdev = devm_rtc_device_register(&pdev->dev, "rtc-au1xxx",
-				     &au1xtoy_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtcdev)) {
-		ret = PTR_ERR(rtcdev);
-		goto out_err;
-	}
+	rtcdev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtcdev))
+		return PTR_ERR(rtcdev);
+
+	rtcdev->ops = &au1xtoy_rtc_ops;
 
 	platform_set_drvdata(pdev, rtcdev);
 
-	return 0;
+	return rtc_register_device(rtcdev);
 
 out_err:
 	return ret;
-- 
2.24.1

