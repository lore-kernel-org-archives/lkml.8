Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57CFC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84CB217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgCFHoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:44:09 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51965 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgCFHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:44:08 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B89D2E0002;
        Fri,  6 Mar 2020 07:44:06 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] rtc: mpc5121: convert to devm_rtc_allocate_device
Date:   Fri,  6 Mar 2020 08:44:01 +0100
Message-Id: <20200306074404.58909-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306074404.58909-1-alexandre.belloni@bootlin.com>
References: <20200306074404.58909-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the path for the rtc_ops selection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mpc5121.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index 9e4454d35352..845212fd1e33 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -344,6 +344,15 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 		goto out_dispose2;
 	}
 
+	rtc->rtc = devm_rtc_allocate_device(&op->dev);
+	if (IS_ERR(rtc->rtc)) {
+		err = PTR_ERR(rtc->rtc);
+		goto out_dispose2;
+	}
+
+	rtc->rtc->ops = &mpc5200_rtc_ops;
+	rtc->rtc->uie_unsupported = 1;
+
 	if (of_device_is_compatible(op->dev.of_node, "fsl,mpc5121-rtc")) {
 		u32 ka;
 		ka = in_be32(&rtc->regs->keep_alive);
@@ -352,19 +361,12 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 				"mpc5121-rtc: Battery or oscillator failure!\n");
 			out_be32(&rtc->regs->keep_alive, ka);
 		}
-
-		rtc->rtc = devm_rtc_device_register(&op->dev, "mpc5121-rtc",
-						&mpc5121_rtc_ops, THIS_MODULE);
-	} else {
-		rtc->rtc = devm_rtc_device_register(&op->dev, "mpc5200-rtc",
-						&mpc5200_rtc_ops, THIS_MODULE);
+		rtc->rtc->ops = &mpc5121_rtc_ops;
 	}
 
-	if (IS_ERR(rtc->rtc)) {
-		err = PTR_ERR(rtc->rtc);
+	err = rtc_register_device(rtc->rtc);
+	if (err)
 		goto out_dispose2;
-	}
-	rtc->rtc->uie_unsupported = 1;
 
 	return 0;
 
-- 
2.24.1

