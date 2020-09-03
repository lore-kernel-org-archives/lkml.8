Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C5FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989C9208B3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="M/kfg7wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgICPRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:17:46 -0400
Received: from crapouillou.net ([89.234.176.41]:51792 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgICLdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132394; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utgKzOLLgksdIlgLwCETskaSs78Yqz7cFo3jO08OUyA=;
        b=M/kfg7waEBVPPqIV29RKlzuq3XReCvGUEPpjSph3PabopjIxrBkgzq9CYDplp1G5OYhDNf
        aHBI9oaDeg83VY3j4WmlVnJVSOYEoVhQXX1bSJSmMQWYhx0lP9O1oReKYaOzr1AWZcjU6T
        XX8DWnJ6kqxSyv/lG6knaAdaaNawWu4=
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
Subject: [PATCH 12/20] usb/musb: ux500: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:46 +0200
Message-Id: <20200903112554.34263-13-paul@crapouillou.net>
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
 drivers/usb/musb/ux500.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 73538d1d0524..3defe83f3a16 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -327,8 +327,7 @@ static int ux500_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ux500_suspend(struct device *dev)
+static int __maybe_unused ux500_suspend(struct device *dev)
 {
 	struct ux500_glue	*glue = dev_get_drvdata(dev);
 	struct musb		*musb = glue_to_musb(glue);
@@ -341,7 +340,7 @@ static int ux500_suspend(struct device *dev)
 	return 0;
 }
 
-static int ux500_resume(struct device *dev)
+static int __maybe_unused ux500_resume(struct device *dev)
 {
 	struct ux500_glue	*glue = dev_get_drvdata(dev);
 	struct musb		*musb = glue_to_musb(glue);
@@ -358,7 +357,6 @@ static int ux500_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ux500_pm_ops, ux500_suspend, ux500_resume);
 
@@ -374,7 +372,7 @@ static struct platform_driver ux500_driver = {
 	.remove		= ux500_remove,
 	.driver		= {
 		.name	= "musb-ux500",
-		.pm	= &ux500_pm_ops,
+		.pm	= pm_ptr(&ux500_pm_ops),
 		.of_match_table = ux500_match,
 	},
 };
-- 
2.28.0

