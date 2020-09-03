Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F27C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881D720786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="u8iCRRQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgICPST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:18:19 -0400
Received: from crapouillou.net ([89.234.176.41]:51696 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbgICLdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132389; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzaZBt+Vyi1bRqVISe2Fhrcj5nalR7mOXK01fT+I730=;
        b=u8iCRRQvzhTJetNnCDlzS4aOGpt9kMtxOzQtSUhUSS2708Uf/R1hUN9yNoUEzxH9j8Wurs
        bP70nLXTelzEqs3l15brpmwIMzH8VMQP0sGzQ5B44n0Af2Kziq6zlHcFO9bbroNYRUbjcc
        aOcSVghkpsh25/9qc43DoY6iNOOh1tM=
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
Subject: [PATCH 10/20] usb/musb: da8xx: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:44 +0200
Message-Id: <20200903112554.34263-11-paul@crapouillou.net>
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
 drivers/usb/musb/da8xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 1c023c0091c4..7a13463006e3 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -598,8 +598,7 @@ static int da8xx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int da8xx_suspend(struct device *dev)
+static int __maybe_unused da8xx_suspend(struct device *dev)
 {
 	int ret;
 	struct da8xx_glue *glue = dev_get_drvdata(dev);
@@ -612,7 +611,7 @@ static int da8xx_suspend(struct device *dev)
 	return 0;
 }
 
-static int da8xx_resume(struct device *dev)
+static int __maybe_unused da8xx_resume(struct device *dev)
 {
 	int ret;
 	struct da8xx_glue *glue = dev_get_drvdata(dev);
@@ -622,7 +621,6 @@ static int da8xx_resume(struct device *dev)
 		return ret;
 	return phy_power_on(glue->phy);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(da8xx_pm_ops, da8xx_suspend, da8xx_resume);
 
@@ -641,7 +639,7 @@ static struct platform_driver da8xx_driver = {
 	.remove		= da8xx_remove,
 	.driver		= {
 		.name	= "musb-da8xx",
-		.pm = &da8xx_pm_ops,
+		.pm = pm_ptr(&da8xx_pm_ops),
 		.of_match_table = of_match_ptr(da8xx_id_table),
 	},
 };
-- 
2.28.0

