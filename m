Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CC6C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B9F20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FxZYS6z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgICLb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:31:56 -0400
Received: from crapouillou.net ([89.234.176.41]:51138 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgICL3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132370; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ruSiYGMYEYwNR6DS0j0tVkBt7LK6N4xlExna60GJosA=;
        b=FxZYS6z3pPyZLRrUjh2dW2tB5f2tjvTCsiK/chiWBa/qXenSG+eYjMmtI66CraPCt3V2Ar
        fu+8Mhe20Q9WGLKBy/kMAeqWTuvZ1iEf8F9CITOWigjXBmDiXsNDu9Vn6QAjG47KG6l3T6
        VqobcZ0NBnJeO4Bg5XZ946SGd9K0G7Y=
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
Subject: [PATCH 03/20] usb/host: ehci-npcm7xx: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:37 +0200
Message-Id: <20200903112554.34263-4-paul@crapouillou.net>
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
 drivers/usb/host/ehci-npcm7xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-npcm7xx.c
index adaf8fb4b459..6b5a7a873e01 100644
--- a/drivers/usb/host/ehci-npcm7xx.c
+++ b/drivers/usb/host/ehci-npcm7xx.c
@@ -37,8 +37,7 @@ static const char hcd_name[] = "npcm7xx-ehci";
 
 static struct hc_driver __read_mostly ehci_npcm7xx_hc_driver;
 
-#ifdef CONFIG_PM_SLEEP
-static int ehci_npcm7xx_drv_suspend(struct device *dev)
+static int __maybe_unused ehci_npcm7xx_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	bool do_wakeup = device_may_wakeup(dev);
@@ -46,14 +45,13 @@ static int ehci_npcm7xx_drv_suspend(struct device *dev)
 	return ehci_suspend(hcd, do_wakeup);
 }
 
-static int ehci_npcm7xx_drv_resume(struct device *dev)
+static int __maybe_unused ehci_npcm7xx_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
 	ehci_resume(hcd, false);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(ehci_npcm7xx_pm_ops, ehci_npcm7xx_drv_suspend,
 		ehci_npcm7xx_drv_resume);
@@ -183,7 +181,7 @@ static struct platform_driver npcm7xx_ehci_hcd_driver = {
 	.driver		= {
 		.name = "npcm7xx-ehci",
 		.bus = &platform_bus_type,
-		.pm = &ehci_npcm7xx_pm_ops,
+		.pm = pm_ptr(&ehci_npcm7xx_pm_ops),
 		.of_match_table = npcm7xx_ehci_id_table,
 	}
 };
-- 
2.28.0

