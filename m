Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C129C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750232071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgCPK1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:27:11 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58729 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgCPK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:27:11 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id EF11B100050;
        Mon, 16 Mar 2020 10:25:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: 88pm860x: remove platform data support
Date:   Mon, 16 Mar 2020 11:25:37 +0100
Message-Id: <20200316102537.180398-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no users of the rtc platform data left, remove its support.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm860x.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 88bda3e072d8..12d75d717730 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -267,18 +267,15 @@ static int pm860x_rtc_dt_init(struct platform_device *pdev,
 	return 0;
 }
 #else
-#define pm860x_rtc_dt_init(x, y)	(-1)
+#define pm860x_rtc_dt_init(x, y)	do { } while (0)
 #endif
 
 static int pm860x_rtc_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
-	struct pm860x_rtc_pdata *pdata = NULL;
 	struct pm860x_rtc_info *info;
 	int ret;
 
-	pdata = dev_get_platdata(&pdev->dev);
-
 	info = devm_kzalloc(&pdev->dev, sizeof(struct pm860x_rtc_info),
 			    GFP_KERNEL);
 	if (!info)
@@ -328,12 +325,6 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 
 #ifdef VRTC_CALIBRATION
 	/* <00> -- 2.7V, <01> -- 2.9V, <10> -- 3.1V, <11> -- 3.3V */
-	if (pm860x_rtc_dt_init(pdev, info)) {
-		if (pdata && pdata->vrtc)
-			info->vrtc = pdata->vrtc & 0x3;
-		else
-			info->vrtc = 1;
-	}
 	pm860x_set_bits(info->i2c, PM8607_MEAS_EN2, MEAS2_VRTC, MEAS2_VRTC);
 
 	/* calibrate VRTC */
-- 
2.24.1

