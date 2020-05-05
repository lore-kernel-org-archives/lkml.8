Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6CAC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD3D206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="GWhZXVFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgEEWNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:13:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:32932 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1588716821; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=B7AW81mUri4IKELUm8+zf4lFXbt6nY0kP/M2sSO0lDk=;
        b=GWhZXVFY0FF2zp29kFOhmdr1wgKTrZSA/InL/LR+4DKKEvIj6E2cPFty8aVzImQ1p/kdHd
        Y7SQsKfFrxtHPAjgD8mUafveqAScP9YlA+Sc630ElXKuo2SKyTo41DKxYm+jE923rdVKZb
        DHQzG4+xEHsrOBFFQg/VbzPMh0x1yyI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     od@zcrc.me, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/7] rtc: ingenic: Only support probing from devicetree
Date:   Wed,  6 May 2020 00:13:30 +0200
Message-Id: <20200505221336.222313-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent work on supporting Device Tree on Ingenic SoCs, no
driver ever probes from platform code anymore, so we can clean a bit
this driver by removing the non-devicetree paths.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/Kconfig      |  1 +
 drivers/rtc/rtc-jz4740.c | 20 +++-----------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ec873f09c763..82a210920c1d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1680,6 +1680,7 @@ config RTC_DRV_MPC5121
 config RTC_DRV_JZ4740
 	tristate "Ingenic JZ4740 SoC"
 	depends on MIPS || COMPILE_TEST
+	depends on OF
 	help
 	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
 	  controllers.
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index e4c719085c31..949d395066e2 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -309,19 +309,13 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_rtc *rtc;
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	const struct of_device_id *of_id = of_match_device(
-			jz4740_rtc_of_match, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
-	if (of_id)
-		rtc->type = (enum jz4740_rtc_type)of_id->data;
-	else
-		rtc->type = id->driver_data;
+	rtc->type = (enum jz4740_rtc_type)device_get_match_data(dev);
 
 	rtc->irq = platform_get_irq(pdev, 0);
 	if (rtc->irq < 0)
@@ -370,7 +364,7 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (np && of_device_is_system_power_controller(np)) {
+	if (of_device_is_system_power_controller(np)) {
 		if (!pm_power_off) {
 			/* Default: 60ms */
 			rtc->reset_pin_assert_time = 60;
@@ -395,20 +389,12 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id jz4740_rtc_ids[] = {
-	{ "jz4740-rtc", ID_JZ4740 },
-	{ "jz4780-rtc", ID_JZ4780 },
-	{}
-};
-MODULE_DEVICE_TABLE(platform, jz4740_rtc_ids);
-
 static struct platform_driver jz4740_rtc_driver = {
 	.probe	 = jz4740_rtc_probe,
 	.driver	 = {
 		.name  = "jz4740-rtc",
-		.of_match_table = of_match_ptr(jz4740_rtc_of_match),
+		.of_match_table = jz4740_rtc_of_match,
 	},
-	.id_table = jz4740_rtc_ids,
 };
 
 module_platform_driver(jz4740_rtc_driver);
-- 
2.26.2

