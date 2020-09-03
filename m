Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E334C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3BA20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="n/sywxZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgICPTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:19:21 -0400
Received: from crapouillou.net ([89.234.176.41]:51236 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgICL3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132373; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SglRxexWR02Jo1xu/7HEB4Hand1VF9eBKwwkPhycx4=;
        b=n/sywxZY3LJtrLFp8PyB9RN3P2+He4kBjU2FJO06S1MBNfZGpYeWilBBTEMOjlEaFWtiZ7
        7+Ib+m2BtC4kB4qLGttVnuTJ2wEP39qmEVeu84HaiZS2RzTpmQqeZVA4iC5i+7XqqEHHpF
        Nx7ZrNzJXJg0TMCBkuHfpsdNb/Cp408=
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
Subject: [PATCH 04/20] usb/host: ehci-platform: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:38 +0200
Message-Id: <20200903112554.34263-5-paul@crapouillou.net>
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
 drivers/usb/host/ehci-platform.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 006c4f6188a5..4585a3a24678 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -410,8 +410,7 @@ static int ehci_platform_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ehci_platform_suspend(struct device *dev)
+static int __maybe_unused ehci_platform_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
@@ -433,7 +432,7 @@ static int ehci_platform_suspend(struct device *dev)
 	return ret;
 }
 
-static int ehci_platform_resume(struct device *dev)
+static int __maybe_unused ehci_platform_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
@@ -464,7 +463,6 @@ static int ehci_platform_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
@@ -499,7 +497,7 @@ static struct platform_driver ehci_platform_driver = {
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver		= {
 		.name	= "ehci-platform",
-		.pm	= &ehci_platform_pm_ops,
+		.pm	= pm_ptr(&ehci_platform_pm_ops),
 		.of_match_table = vt8500_ehci_ids,
 		.acpi_match_table = ACPI_PTR(ehci_acpi_match),
 	}
-- 
2.28.0

