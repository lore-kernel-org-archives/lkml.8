Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C27C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFEE206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bNYvg+rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgICLqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:46:21 -0400
Received: from crapouillou.net ([89.234.176.41]:51956 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgICLfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132405; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TaaXhuQwpGfBU2Mff+uP9EGClNX7jlEbfP7HfZOJNPw=;
        b=bNYvg+rqcT9I6lnK9NOk6dQ3I3ikbPyWzzWj+7j7zASSo8UWh2eNXEhZT6A0FlMbpwnKuO
        AqKMlucd0Apm1bT4Mtxx1jBksZGS1c2rOj5Az/A5Z0OoSkipsXVWktFPoEIL7xqgBcr9Cy
        snbEctfTNJq76cOvdt179trzl0YEbQc=
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
Subject: [PATCH 16/20] usb/gadget/udc: bdc: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:50 +0200
Message-Id: <20200903112554.34263-17-paul@crapouillou.net>
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
 drivers/usb/gadget/udc/bdc/bdc_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 5ff36525044e..da3a7a59ccae 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -597,8 +597,7 @@ static int bdc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int bdc_suspend(struct device *dev)
+static int __maybe_unused bdc_suspend(struct device *dev)
 {
 	struct bdc *bdc = dev_get_drvdata(dev);
 	int ret;
@@ -611,7 +610,7 @@ static int bdc_suspend(struct device *dev)
 	return ret;
 }
 
-static int bdc_resume(struct device *dev)
+static int __maybe_unused bdc_resume(struct device *dev)
 {
 	struct bdc *bdc = dev_get_drvdata(dev);
 	int ret;
@@ -630,8 +629,6 @@ static int bdc_resume(struct device *dev)
 	return 0;
 }
 
-#endif /* CONFIG_PM_SLEEP */
-
 static SIMPLE_DEV_PM_OPS(bdc_pm_ops, bdc_suspend,
 		bdc_resume);
 
@@ -644,7 +641,7 @@ static const struct of_device_id bdc_of_match[] = {
 static struct platform_driver bdc_driver = {
 	.driver		= {
 		.name	= BRCM_BDC_NAME,
-		.pm = &bdc_pm_ops,
+		.pm = pm_ptr(&bdc_pm_ops),
 		.of_match_table	= bdc_of_match,
 	},
 	.probe		= bdc_probe,
-- 
2.28.0

