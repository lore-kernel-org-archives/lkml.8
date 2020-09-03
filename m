Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56ADC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DEA206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="uyPH2gOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgICLyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:54:44 -0400
Received: from crapouillou.net ([89.234.176.41]:52110 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgICLiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132416; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/usum2lMn5S572mPjualJXpI8Hb8PYrLN5qLjcBg/E=;
        b=uyPH2gOXuLKzSt6R9ogD6oYnN48BacMq2YCnxfq+SGRV9cExif4lnLNhWfRYfiVN93vpTU
        iNEmJHYhwhvBHbRXKzQno5TLuA3CiRE064g8znLpMhPwYtZ6Op5Vc612zeV2FlJUHU6NF7
        kv1P84KdA4TY9WoGREISDXYqyfPPtow=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, Bin Liu <b-liu@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 20/20] usb/gadget/udc: snps: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:54 +0200
Message-Id: <20200903112554.34263-21-paul@crapouillou.net>
In-Reply-To: <20200903112554.34263-1-paul@crapouillou.net>
References: <20200903112554.34263-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced pm_ptr() macro, and mark the suspend/resume
functions __maybe_unused. These functions can then be moved outside the
CONFIG_PM_SUSPEND block, and the compiler can then process them and
detect build failures independently of the config. If unused, they will
simply be discarded by the compiler.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/gadget/udc/snps_udc_plat.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 32f1d3e90c26..6b8f08287c84 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -257,8 +257,7 @@ static int udc_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int udc_plat_suspend(struct device *dev)
+static int __maybe_unused udc_plat_suspend(struct device *dev)
 {
 	struct udc *udc;
 
@@ -275,7 +274,7 @@ static int udc_plat_suspend(struct device *dev)
 	return 0;
 }
 
-static int udc_plat_resume(struct device *dev)
+static int __maybe_unused udc_plat_resume(struct device *dev)
 {
 	struct udc *udc;
 	int ret;
@@ -302,11 +301,8 @@ static int udc_plat_resume(struct device *dev)
 
 	return 0;
 }
-static const struct dev_pm_ops udc_plat_pm_ops = {
-	.suspend	= udc_plat_suspend,
-	.resume		= udc_plat_resume,
-};
-#endif
+
+static SIMPLE_DEV_PM_OPS(plat_pm_ops, udc_plat_suspend, udc_plat_resume);
 
 #if defined(CONFIG_OF)
 static const struct of_device_id of_udc_match[] = {
@@ -324,9 +320,7 @@ static struct platform_driver udc_plat_driver = {
 	.driver		= {
 		.name	= "snps-udc-plat",
 		.of_match_table = of_match_ptr(of_udc_match),
-#ifdef CONFIG_PM_SLEEP
-		.pm	= &udc_plat_pm_ops,
-#endif
+		.pm	= pm_ptr(&udc_plat_pm_ops),
 	},
 };
 module_platform_driver(udc_plat_driver);
-- 
2.28.0

