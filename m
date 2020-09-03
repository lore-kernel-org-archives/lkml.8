Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA918C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5EF20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="p43itBv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgICLlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:41:25 -0400
Received: from crapouillou.net ([89.234.176.41]:51770 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbgICLdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132392; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XW0R3A7h61kqVO9LHIfPbKDh6AHGGvcxGKCBLPMwEw=;
        b=p43itBv7pIcpgpQk29PzyvPKV0bvvqU7w2NCQtGv28IZlDXG/g383913UyPEdgcZy94ccQ
        wWQOhhbDp8JG5qUeiMANp5kO0L3OYfS3eVJPL5lXk2mG+o/wGUWDI+myv9l6KgdOj40ue3
        KU6GbN4Ags8dJ5BehODyZ4GCKabfjO4=
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
Subject: [PATCH 11/20] usb/musb: musb_dsps: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:45 +0200
Message-Id: <20200903112554.34263-12-paul@crapouillou.net>
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
 drivers/usb/musb/musb_dsps.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 30085b2be7b9..cb196bb6661d 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -665,26 +665,22 @@ dsps_dma_controller_create(struct musb *musb, void __iomem *base)
 	return controller;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static void dsps_dma_controller_suspend(struct dsps_glue *glue)
+static void __maybe_unused dsps_dma_controller_suspend(struct dsps_glue *glue)
 {
 	void __iomem *usbss_base = glue->usbss_base;
 
 	musb_writel(usbss_base, USBSS_IRQ_CLEARR, USBSS_IRQ_PD_COMP);
 }
 
-static void dsps_dma_controller_resume(struct dsps_glue *glue)
+static void __maybe_unused dsps_dma_controller_resume(struct dsps_glue *glue)
 {
 	void __iomem *usbss_base = glue->usbss_base;
 
 	musb_writel(usbss_base, USBSS_IRQ_ENABLER, USBSS_IRQ_PD_COMP);
 }
-#endif
 #else /* CONFIG_USB_TI_CPPI41_DMA */
-#ifdef CONFIG_PM_SLEEP
-static void dsps_dma_controller_suspend(struct dsps_glue *glue) {}
-static void dsps_dma_controller_resume(struct dsps_glue *glue) {}
-#endif
+static void __maybe_unused dsps_dma_controller_suspend(struct dsps_glue *glue) {}
+static void __maybe_unused dsps_dma_controller_resume(struct dsps_glue *glue) {}
 #endif /* CONFIG_USB_TI_CPPI41_DMA */
 
 static struct musb_platform_ops dsps_ops = {
@@ -961,8 +957,7 @@ static const struct of_device_id musb_dsps_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
 
-#ifdef CONFIG_PM_SLEEP
-static int dsps_suspend(struct device *dev)
+static int __maybe_unused dsps_suspend(struct device *dev)
 {
 	struct dsps_glue *glue = dev_get_drvdata(dev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
@@ -996,7 +991,7 @@ static int dsps_suspend(struct device *dev)
 	return 0;
 }
 
-static int dsps_resume(struct device *dev)
+static int __maybe_unused dsps_resume(struct device *dev)
 {
 	struct dsps_glue *glue = dev_get_drvdata(dev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
@@ -1024,7 +1019,6 @@ static int dsps_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
 
@@ -1033,7 +1027,7 @@ static struct platform_driver dsps_usbss_driver = {
 	.remove         = dsps_remove,
 	.driver         = {
 		.name   = "musb-dsps",
-		.pm	= &dsps_pm_ops,
+		.pm	= pm_ptr(&dsps_pm_ops),
 		.of_match_table	= musb_dsps_of_match,
 	},
 };
-- 
2.28.0

