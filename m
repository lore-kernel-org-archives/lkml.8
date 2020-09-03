Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE7C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786D120786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jYQYUggT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgICPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:18:34 -0400
Received: from crapouillou.net ([89.234.176.41]:51512 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgICLb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132381; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q++myQyFVGc5viHm1my4fERz4BkgXBYuJlPFvw347zc=;
        b=jYQYUggTNuQ1S6/3AD+ZmojFJNLvAFPZAu3nlpl+R3Zxjg7o0i+1ZV9A/w9OncyVirf37r
        RDUjJo7sVHvcVRBsCymTMBSH3cp4BYuaJq2KJjp3ncoaZ+8635HCMWW3Twt/Oy+vizidMX
        QmnPSvEHoqj0+1aIe8xKa3yGbcwpIp0=
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
Subject: [PATCH 07/20] usb/misc: usb3503: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:41 +0200
Message-Id: <20200903112554.34263-8-paul@crapouillou.net>
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
 drivers/usb/misc/usb3503.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 116bd789e568..48099c6bf04c 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -322,8 +322,7 @@ static int usb3503_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int usb3503_suspend(struct usb3503 *hub)
+static int __maybe_unused usb3503_suspend(struct usb3503 *hub)
 {
 	usb3503_switch_mode(hub, USB3503_MODE_STANDBY);
 	clk_disable_unprepare(hub->clk);
@@ -331,7 +330,7 @@ static int usb3503_suspend(struct usb3503 *hub)
 	return 0;
 }
 
-static int usb3503_resume(struct usb3503 *hub)
+static int __maybe_unused usb3503_resume(struct usb3503 *hub)
 {
 	clk_prepare_enable(hub->clk);
 	usb3503_switch_mode(hub, hub->mode);
@@ -339,30 +338,29 @@ static int usb3503_resume(struct usb3503 *hub)
 	return 0;
 }
 
-static int usb3503_i2c_suspend(struct device *dev)
+static int __maybe_unused usb3503_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
 	return usb3503_suspend(i2c_get_clientdata(client));
 }
 
-static int usb3503_i2c_resume(struct device *dev)
+static int __maybe_unused usb3503_i2c_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
 	return usb3503_resume(i2c_get_clientdata(client));
 }
 
-static int usb3503_platform_suspend(struct device *dev)
+static int __maybe_unused usb3503_platform_suspend(struct device *dev)
 {
 	return usb3503_suspend(dev_get_drvdata(dev));
 }
 
-static int usb3503_platform_resume(struct device *dev)
+static int __maybe_unused usb3503_platform_resume(struct device *dev)
 {
 	return usb3503_resume(dev_get_drvdata(dev));
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(usb3503_i2c_pm_ops, usb3503_i2c_suspend,
 		usb3503_i2c_resume);
@@ -388,7 +386,7 @@ MODULE_DEVICE_TABLE(of, usb3503_of_match);
 static struct i2c_driver usb3503_i2c_driver = {
 	.driver = {
 		.name = USB3503_I2C_NAME,
-		.pm = &usb3503_i2c_pm_ops,
+		.pm = pm_ptr(&usb3503_i2c_pm_ops),
 		.of_match_table = of_match_ptr(usb3503_of_match),
 	},
 	.probe		= usb3503_i2c_probe,
@@ -400,7 +398,7 @@ static struct platform_driver usb3503_platform_driver = {
 	.driver = {
 		.name = USB3503_I2C_NAME,
 		.of_match_table = of_match_ptr(usb3503_of_match),
-		.pm = &usb3503_platform_pm_ops,
+		.pm = pm_ptr(&usb3503_platform_pm_ops),
 	},
 	.probe		= usb3503_platform_probe,
 	.remove		= usb3503_platform_remove,
-- 
2.28.0

