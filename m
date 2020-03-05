Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785E2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C249208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEVud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:50:33 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:36071 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCEVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:50:32 -0500
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1F057240003;
        Thu,  5 Mar 2020 21:50:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] rtc: davinci: convert to devm_rtc_allocate_device
Date:   Thu,  5 Mar 2020 22:50:19 +0100
Message-Id: <20200305215022.32533-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver. Also remove the unnecessary
error string as the core will already display error messages.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-davinci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index 390b7351e0fe..d620d147c604 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -485,13 +485,11 @@ static int __init davinci_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, davinci_rtc);
 
-	davinci_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				    &davinci_rtc_ops, THIS_MODULE);
-	if (IS_ERR(davinci_rtc->rtc)) {
-		dev_err(dev, "unable to register RTC device, err %d\n",
-				ret);
+	davinci_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(davinci_rtc->rtc))
 		return PTR_ERR(davinci_rtc->rtc);
-	}
+
+	davinci_rtc->rtc->ops = &davinci_rtc_ops;
 
 	rtcif_write(davinci_rtc, PRTCIF_INTFLG_RTCSS, PRTCIF_INTFLG);
 	rtcif_write(davinci_rtc, 0, PRTCIF_INTEN);
@@ -516,7 +514,7 @@ static int __init davinci_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 0);
 
-	return 0;
+	return rtc_register_device(davinci_rtc->rtc);
 }
 
 static int __exit davinci_rtc_remove(struct platform_device *pdev)
-- 
2.24.1

