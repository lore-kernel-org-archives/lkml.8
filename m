Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9859C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCCB20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TdDiNKC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgICLl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:41:59 -0400
Received: from crapouillou.net ([89.234.176.41]:51890 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgICLei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132397; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=So1ydkKuCEbYZRfPCMaB7KCDvSR7hgpAAFNtUES9lnU=;
        b=TdDiNKC/us7YKeyMnnsJ+Gvaf3XEHP0+ivVh03DILw/6xdyhGyQYHfRGGRBxn4+7b7Tgdm
        wwZTFIbsD9ztA92cvXnUd128sxT5s47A/ML1Xf6o+EBbRib8GKDkXWG0m7A4xoDPlpv154
        0sKvjhacukZekWOSySQ8noyCTQC5i+U=
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
Subject: [PATCH 13/20] usb/phy: am335x: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:47 +0200
Message-Id: <20200903112554.34263-14-paul@crapouillou.net>
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
 drivers/usb/phy/phy-am335x.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index 8524475d942d..a238f866634b 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -90,8 +90,7 @@ static int am335x_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int am335x_phy_suspend(struct device *dev)
+static int __maybe_unused am335x_phy_suspend(struct device *dev)
 {
 	struct am335x_phy *am_phy = dev_get_drvdata(dev);
 
@@ -111,7 +110,7 @@ static int am335x_phy_suspend(struct device *dev)
 	return 0;
 }
 
-static int am335x_phy_resume(struct device *dev)
+static int __maybe_unused am335x_phy_resume(struct device *dev)
 {
 	struct am335x_phy	*am_phy = dev_get_drvdata(dev);
 
@@ -122,7 +121,6 @@ static int am335x_phy_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(am335x_pm_ops, am335x_phy_suspend, am335x_phy_resume);
 
@@ -137,7 +135,7 @@ static struct platform_driver am335x_phy_driver = {
 	.remove         = am335x_phy_remove,
 	.driver         = {
 		.name   = "am335x-phy-driver",
-		.pm = &am335x_pm_ops,
+		.pm = pm_ptr(&am335x_pm_ops),
 		.of_match_table = am335x_phy_ids,
 	},
 };
-- 
2.28.0

