Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20635C3F2D8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADAC20870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCFBAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:00:13 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:47995 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCFBAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:00:10 -0500
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D191824000B;
        Fri,  6 Mar 2020 01:00:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] rtc: au1xxx: remove goto label
Date:   Fri,  6 Mar 2020 01:59:56 +0100
Message-Id: <20200306005958.39203-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306005958.39203-1-alexandre.belloni@bootlin.com>
References: <20200306005958.39203-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the driver by removing the goto label as it only does return ret.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-au1xxx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
index a13ac73aa2b7..73aeb15f9491 100644
--- a/drivers/rtc/rtc-au1xxx.c
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -65,17 +65,13 @@ static int au1xtoy_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtcdev;
 	unsigned long t;
-	int ret;
 
 	t = alchemy_rdsys(AU1000_SYS_CNTRCTRL);
 	if (!(t & CNTR_OK)) {
 		dev_err(&pdev->dev, "counters not working; aborting.\n");
-		ret = -ENODEV;
-		goto out_err;
+		return -ENODEV;
 	}
 
-	ret = -ETIMEDOUT;
-
 	/* set counter0 tickrate to 1Hz if necessary */
 	if (alchemy_rdsys(AU1000_SYS_TOYTRIM) != 32767) {
 		/* wait until hardware gives access to TRIM register */
@@ -88,7 +84,7 @@ static int au1xtoy_rtc_probe(struct platform_device *pdev)
 			 * counters are unusable.
 			 */
 			dev_err(&pdev->dev, "timeout waiting for access\n");
-			goto out_err;
+			return -ETIMEDOUT;
 		}
 
 		/* set 1Hz TOY tick rate */
@@ -108,9 +104,6 @@ static int au1xtoy_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtcdev);
 
 	return rtc_register_device(rtcdev);
-
-out_err:
-	return ret;
 }
 
 static struct platform_driver au1xrtc_driver = {
-- 
2.24.1

