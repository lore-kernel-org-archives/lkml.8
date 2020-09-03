Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B75C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C5D20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cZdEy8G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgICPT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:19:58 -0400
Received: from crapouillou.net ([89.234.176.41]:50454 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgICL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132368; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x3OFdNgDOF418fBVzdMohbSbtTKgDO7T8r5jfdzMW+Y=;
        b=cZdEy8G+8PzfzbjNeQPWjcgH4RuZLLGYI+UFG+0EM4Os/uxIEVg9VRlPSPIq0MFzGom6gZ
        xf4dLy8m8gUtlKR5m97mL6G9y/7iwJwSW2++d6wxv8RwkniTcl5k/Tiuz3zY1TYlGlBDPl
        PtCEqNNndRth3fbZkYtNmah952TlGGE=
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
Subject: [PATCH 02/20] usb/host: ehci-spear: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:36 +0200
Message-Id: <20200903112554.34263-3-paul@crapouillou.net>
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
 drivers/usb/host/ehci-spear.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index add796c78561..3694e450a11a 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -34,8 +34,7 @@ struct spear_ehci {
 
 static struct hc_driver __read_mostly ehci_spear_hc_driver;
 
-#ifdef CONFIG_PM_SLEEP
-static int ehci_spear_drv_suspend(struct device *dev)
+static int __maybe_unused ehci_spear_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	bool do_wakeup = device_may_wakeup(dev);
@@ -43,14 +42,13 @@ static int ehci_spear_drv_suspend(struct device *dev)
 	return ehci_suspend(hcd, do_wakeup);
 }
 
-static int ehci_spear_drv_resume(struct device *dev)
+static int __maybe_unused ehci_spear_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
 	ehci_resume(hcd, false);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(ehci_spear_pm_ops, ehci_spear_drv_suspend,
 		ehci_spear_drv_resume);
@@ -155,7 +153,7 @@ static struct platform_driver spear_ehci_hcd_driver = {
 	.driver		= {
 		.name = "spear-ehci",
 		.bus = &platform_bus_type,
-		.pm = &ehci_spear_pm_ops,
+		.pm = pm_ptr(&ehci_spear_pm_ops),
 		.of_match_table = spear_ehci_id_table,
 	}
 };
-- 
2.28.0

