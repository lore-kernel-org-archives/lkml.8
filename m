Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9188DC35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B09D20637
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MkgppYUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBXBkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:40:45 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:49026 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXBkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582508429; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMkGWYSXhw/tNPFUtRSta3c/ysIRlFeCxyXP8lthelM=;
        b=MkgppYUDEMC13a98282HoDO+pyrKcBbjoLr8cDSlXQwD6Om8wGxNS6wnpT+yJKKG9DyxVb
        NFItuGR3SXYIWmL0+/jvh5Y31hrlu9+yZFjrirPOoaKyXsxDgMYLTf4bXlTG21gPlBIUHd
        vHemmoLPJVbIdw9Mp127b7JonMVHl3M=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/5] usb: musb: jz4740: Unconditionally depend on devicetree
Date:   Sun, 23 Feb 2020 22:40:07 -0300
Message-Id: <20200224014008.27114-4-paul@crapouillou.net>
In-Reply-To: <20200224014008.27114-1-paul@crapouillou.net>
References: <20200224014008.27114-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jz4740-musb driver is unconditionally probed from devicetree, so we
can add a hard dependency on devicetree. This makes the code a bit
cleaner, and is more future-proof as the platform data is now retrieved
using of_device_get_match_data().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 drivers/usb/musb/Kconfig  |  1 +
 drivers/usb/musb/jz4740.c | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 3268adb7d7cf..3b0d1c20ebe6 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -110,6 +110,7 @@ config USB_MUSB_UX500
 
 config USB_MUSB_JZ4740
 	tristate "JZ4740"
+	depends on OF
 	depends on MIPS || COMPILE_TEST
 	depends on USB_MUSB_GADGET
 	depends on USB=n || USB_OTG_BLACKLIST_HUB
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index bbfeb9881788..b6747bad4fb2 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -164,7 +164,7 @@ static const struct musb_hdrc_platform_data jz4740_musb_pdata = {
 static int jz4740_probe(struct platform_device *pdev)
 {
 	struct device			*dev = &pdev->dev;
-	const struct musb_hdrc_platform_data *pdata = &jz4740_musb_pdata;
+	const struct musb_hdrc_platform_data *pdata;
 	struct platform_device		*musb;
 	struct jz4740_glue		*glue;
 	struct clk			*clk;
@@ -174,6 +174,12 @@ static int jz4740_probe(struct platform_device *pdev)
 	if (!glue)
 		return -ENOMEM;
 
+	pdata = of_device_get_match_data(dev);
+	if (!pdata) {
+		dev_err(dev, "missing platform data");
+		return -EINVAL;
+	}
+
 	musb = platform_device_alloc("musb-hdrc", PLATFORM_DEVID_AUTO);
 	if (!musb) {
 		dev_err(dev, "failed to allocate musb device");
@@ -240,20 +246,18 @@ static int jz4740_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id jz4740_musb_of_match[] = {
-	{ .compatible = "ingenic,jz4740-musb" },
+	{ .compatible = "ingenic,jz4740-musb", .data = &jz4740_musb_pdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, jz4740_musb_of_match);
-#endif
 
 static struct platform_driver jz4740_driver = {
 	.probe		= jz4740_probe,
 	.remove		= jz4740_remove,
 	.driver		= {
 		.name	= "musb-jz4740",
-		.of_match_table = of_match_ptr(jz4740_musb_of_match),
+		.of_match_table = jz4740_musb_of_match,
 	},
 };
 
-- 
2.25.0

